## Files and guide which helps to create language acoustic model.

This project contains materials for creating a Russian language acoustic model:

- Guidelines.pdf contains full guide about work process and description of project files (in Russian only);

- /ru_base contains language models (8 hours of speech), dictionary, phonemes, parameteres of training and training data;

- /scripts contains utility scripts which are not really  necessary;

- /theory contains some must know information about linux and speech recongnition fundamentals.

ru_base/etc/ru_base_large.lm and ru_base/lm_train_data.txt are compressed due to github size restrictions.

#### Some trained model results
1) CI, 8 DEN: 

TOTAL Words: 197 Correct: 114 Errors: 94

TOTAL Percent correct = 57.87% Error = 47.72% Accuracy = 52.28%

TOTAL Insertions: 11 Deletions: 5 Substitutions: 78

2) CD, 16 DEN, 2000 sen + LW tune

TOTAL Words: 197 Correct: 142 Errors: 81

TOTAL Percent correct = 72.08% Error = 41.12% Accuracy = 58.88%

TOTAL Insertions: 26 Deletions: 2 Substitutions: 53

3) CD, 16 DEN, 2000 sen + lm_test

TOTAL Words: 197 Correct: 194 Errors: 5

TOTAL Percent correct = 98.48% Error = 2.54% Accuracy = 97.46%

TOTAL Insertions: 2 Deletions: 0 Substitutions: 3
