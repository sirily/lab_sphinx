# This project contains the acoustic models and log files, as long as several language models trained on voxforge and open subtitles data.

1) https://github.com/sirily/ru_base/tree/master/etc

contains language models (8 hours of speech), dictionary, phonemes and parameteres of training.

2) https://github.com/sirily/ru_base/tree/master/model_architecture

contains model architecture

3) https://github.com/sirily/ru_base/tree/master/model_parameters

contains model parameters

4) https://github.com/sirily/ru_base/tree/master/result

the result of ru_base_test.lm model which implements kws mode

# Table of results
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
