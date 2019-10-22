#!/bin/bash

cd ~/Рабочий\ стол/lab_sphinx
bash scripts/prepare_data.sh
bash scripts/prepare_lang.sh
cd ru_base
sphinxtrain -t ru_base setup
cp etc/sphinx_train.cfg etc/sphinx_train.cfg.bkp
cp -f ~/backup/sphinx_train.cfg etc/sphinx_train.cfg
sphinxtrain run
