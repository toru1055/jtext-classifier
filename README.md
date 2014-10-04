jtext-classifier
================

日本語テキスト分類のスクリプト

## Installation
`$ bundle install`  
`$ ./install.sh`

## Usage
### Train phase
`$ ./bin/train (学習用ファイル)`

### Predict phase
`$ ./bin/predict (予測対象のファイル)`

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
