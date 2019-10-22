#!/bin/bash

# слова из тренировки должны быть в словаре обязательно
text2wfreq < ru_base/etc/ru_base_train.text | wfreq2vocab -top 30000 |\
   grep -v '[^а-я-]'  | grep -v -w '^-$' > ru_base/etc/ru_base.vocab

# создаем произношения
python scripts/words2prons.py ru_base/etc/ru_base.vocab \
  >  ru_base/etc/ru_base.dic

# добавляем символы начала и конца строки <s> и </s> 
echo '<s>' >> ru_base/etc/ru_base.vocab
echo '</s>' >> ru_base/etc/ru_base.vocab

# список фонем
awk '$1=""; {print $0}' ru_base/etc/ru_base.dic |\
   tr ' ' '\n' | sort -u | grep -v '^$' > ru_base/etc/ru_base.phone
echo 'SIL' >> ru_base/etc/ru_base.phone

# fillers - непроизносимые слова
echo '<s> SIL' > ru_base/etc/ru_base.filler
echo '</s> SIL' >> ru_base/etc/ru_base.filler
echo '<sil> SIL' >> ru_base/etc/ru_base.filler

# создаем языковую модель
text2idngram -vocab ru_base/etc/ru_base.vocab -idngram ru_base/etc/ru_base.idngram < ru_base/etc/ru_base_train.text
idngram2lm -vocab_type 0 -idngram ru_base/etc/ru_base.idngram -vocab \
     ru_base/etc/ru_base.vocab -arpa ru_base/etc/ru_base.lm

# бинаризация языковой модели
sphinx_lm_convert -i ru_base/etc/ru_base.lm -o ru_base/etc/ru_base.lm.DMP
