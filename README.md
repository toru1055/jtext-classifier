jtext-classifier
================

日本語テキスト分類のスクリプト

## Installation
`$ bundle install`  
`$ ./install.sh`

## Usage
### Train phase
`$ ./bin/train /path/to/train-file.tsv`

### Predict phase
`$ ./bin/predict /path/to/predict-file.tsv`

## File format
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
