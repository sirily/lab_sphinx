#!/bin/bash

# диктор, использующийся для тестов 
test_user_name="test-speaker"

# скрипт создает корпус из файлов voxforge
pushd ru_base
mkdir etc

# train - все дикторы, кроме тестируемого
cat `find wav -name PROMPTS` | grep -v "^${test_user_name}" | awk '{print $1}' |\
  sed 's/\/mfc\//\/wav\//g' > etc/ru_base_train.fileids

# вытаскиваем текст для обучения языковой модели
cat `find wav -name PROMPTS` | grep -v "^${test_user_name}"  |\
  awk '$1=""; {print "<s>"tolower($0)" </s>"}' |\
   sed 's/[\!\+\?\,\.\:\;-]/ /g' | sed "s/'//g"> etc/ru_base_train.text


awk -F'/' '{print $NF}' etc/ru_base_train.fileids > etc/ru_base_train.fileids.base.tmp

# готовим файл транскрипций
awk 'FNR==NR { a[FNR""] = $0; next } { print a[FNR""], "("$0")" }' \
  etc/ru_base_train.text \
  etc/ru_base_train.fileids.base.tmp > etc/ru_base_train.transcription

rm -rf etc/ru_base_train.fileids.base.tmp

# test - ваш диктор
cat `find wav -name PROMPTS` | grep  "^${test_user_name}" | awk '{print $1}' |\
  sed 's/\/mfc\//\/wav\//g' > etc/ru_base_test.fileids

cat `find wav -name PROMPTS` | grep  "^${test_user_name}" |\
  awk '$1=""; {print "<s>"tolower($0)" </s>"}' |\
   sed 's/[\!\+\?\,\.\:\;-]/ /g' | sed "s/'//g"  > etc/ru_base_test.text


awk -F'/' '{print $NF}' etc/ru_base_test.fileids > etc/ru_base_test.fileids.base.tmp

awk 'FNR==NR { a[FNR""] = $0; next } { print a[FNR""], "("$0")" }' \
  etc/ru_base_test.text \
  etc/ru_base_test.fileids.base.tmp > etc/ru_base_test.transcription

rm -rf etc/ru_base_test.fileids.base.tmp

# очистка лишних данных
rm -rf etc/*.tmp
popd





