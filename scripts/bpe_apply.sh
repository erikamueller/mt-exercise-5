#! /bin/bash

scripts=`dirname "$0"`
base=$scripts/..
data=$base/data
vocab=$base/vocab

models=$base/models

src=en
trg=de

# tokenized files for train, dev, test
inpsrc=$data/train.sample.tokenized.$src-$trg.$src
inptrg=$data/train.sample.tokenized.$src-$trg.$trg

dev_inpsrc=$data/dev.tokenized.$src-$trg.$src
dev_inptrg=$data/dev.tokenized.$src-$trg.$trg

test_inpsrc=$data/test.tokenized.$src-$trg.$src
test_inptrg=$data/test.tokenized.$src-$trg.$trg

num_threads=4
vocab_size=2000

# apply BPE model
## apply on train source file (tokenized)
subword-nmt apply-bpe -c $models/model.bpe \
  --vocabulary $vocab/vocab.$src \
  --vocabulary-threshold 10 \
  < $inpsrc > $data/train.bpe.$src

## apply on train target file (tokenized)
subword-nmt apply-bpe -c $models/model.bpe \
  --vocabulary $vocab/vocab.$trg \
  --vocabulary-threshold 10 \
  < $inptrg > $data/train.bpe.$trg

## apply on dev source file (tokenized)
subword-nmt apply-bpe -c $models/model.bpe \
  --vocabulary $vocab/vocab.$src \
  --vocabulary-threshold 10 \
  < $dev_inpsrc > $data/dev.bpe.$src

## apply on dev target file (tokenized)
subword-nmt apply-bpe -c $models/model.bpe \
  --vocabulary $vocab/vocab.$trg \
  --vocabulary-threshold 10 \
  < $dev_inptrg > $data/dev.bpe.$trg

## apply on test source file (tokenized)
subword-nmt apply-bpe -c $models/model.bpe \
  --vocabulary $vocab/vocab.$src \
  --vocabulary-threshold 10 \
  < $test_inpsrc > $data/test.bpe.$src

## apply on test target file (tokenized)
subword-nmt apply-bpe -c $models/model.bpe \
  --vocabulary $vocab/vocab.$trg \
  --vocabulary-threshold 10 \
  < $test_inptrg > $data/test.bpe.$trg
