jtext-classifier
================

Rubyの日本語テキスト分類スクリプト

## Installation
Gemfileのインストール  
`$ bundle install`  

LiblinearとOkuraのコンパイル  
`$ ./install.sh`

## Usage
### Train phase
`$ ./bin/train /path/to/train-file.tsv`

### Predict phase
`$ ./bin/predict /path/to/predict-file.tsv`

## Input file format
### Train file(tsv file)
```
(category)¥t(text)¥n
...
```

### Predict file(tsv file)
```
(id)¥t(text)¥n
...
```
