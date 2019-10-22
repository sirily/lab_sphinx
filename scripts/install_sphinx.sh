#!/bin/bash

# адаптировано отсюда
# http://jrmeyer.github.io/installation/2016/01/09/Installing-CMU-Sphinx-on-Ubuntu.html


mkdir sphinx
pushd sphinx

# зависимости
sudo apt-get install libasound2 alsa-utils alsa-oss
sudo apt-get install build-essential git libtool pkg-config svn
sudo apt-get install gcc automake autoconf libtool bison swig python-dev libpulse-dev git 
sudo apt-get install sox

# sphinxbase - основные библиотеки
# компилирует sphinx_fe, sphinx_cepview, и т.д.
git clone https://github.com/cmusphinx/sphinxbase.git
pushd sphinxbase 
./autogen.sh
make
sudo make install
# добавляем пути к библиотекам
export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH
echo 'LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH' >> ~/.bashrc
popd


# pocketsphinx - декодер
# компилирует pocketsphinx_batch и pocketsphinx_contonuous
git clone https://github.com/cmusphinx/pocketsphinx.git
pushd pocketsphinx
./autogen.sh 
make
sudo make install
popd


# sphinxtrain - тренировка моделей
git clone https://github.com/cmusphinx/sphinxtrain.git
pushd sphinxtrain
./autogen.sh
make 
sudo make install 
popd


# cmulmtk - утилита для создания языковых моделей
# требуется для text2wfreq и wfreq2vocab
svn checkout svn://svn.code.sf.net/p/cmusphinx/code/trunk/cmuclmtk cmuclmtk
pushd cmuclmtk
./autogen.sh 
make
sudo make install
popd

popd
