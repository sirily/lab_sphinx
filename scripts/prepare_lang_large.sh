#!/bin/bash

# все слова из тренировочных транскриптов и языковой модели 
# должны быть добавлены в словарь

# входные данные
# тексты для тренировки языковой модели 

lm_train_data=ru_base/lm_train_data.txt
# lm_train_data=""

# соединяем с данными тренировочной выборки

cat ${lm_train_data} ru_base/etc/ru_base_train.text \
   > ru_base/etc/lm_texts


# создаем словарь
text2wfreq <  ru_base/etc/ru_base_train.text | wfreq2vocab -top 1000000 |\
   grep -v '[^а-я-]'  | grep -v -w '^-$' > ru_base/etc/ru_base.vocab.0
# слова из тренировки должны быть в словаре обязательно
text2wfreq < ${lm_train_data}  | wfreq2vocab -top 30000 |\
   grep -v '[^а-я-]'  | grep -v -w '^-$' > ru_base/etc/ru_base.vocab.1

cat ru_base/etc/ru_base.vocab.1 ru_base/etc/ru_base.vocab.0 | sort -u > ru_base/etc/ru_base.vocab


# создаем произношения
python scripts/words2prons.py ru_base/etc/ru_base.vocab \
  >  ru_base/etc/ru_base.dic

# add <s> and </s> to LM
echo '<s>' >> ru_base/etc/ru_base.vocab
echo '</s>' >> ru_base/etc/ru_base.vocab
# список фонем
awk '$1=""; {print $0}' ru_base/etc/ru_base.dic |\
   tr ' ' '\n' | sort -u | grep -v '^$' > ru_base/etc/ru_base.phone
echo 'SIL' >> ru_base/etc/ru_base.phone


# создаем языковую модель
text2idngram -vocab ru_base/etc/ru_base.vocab -idngram ru_base/etc/ru_base.idngram < ru_base/etc/lm_texts
idngram2lm -vocab_type 0 -idngram ru_base/etc/ru_base.idngram -vocab \
     ru_base/etc/ru_base.vocab -arpa ru_base/etc/ru_base_large.lm

# бинаризация языковой модели
sphinx_lm_convert -i ru_base/etc/ru_base_large.lm -o ru_base/etc/ru_base_large.lm.DMP
