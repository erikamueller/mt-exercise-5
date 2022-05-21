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
subword-nmt apply-bpe -c $models/model.10k.bpe \
  --vocabulary $vocab/vocab.10k.$src \
  --vocabulary-threshold 10 \
  < $inpsrc > $data/train.10k.bpe.$src

## apply on train target file (tokenized)
subword-nmt apply-bpe -c $models/model.10k.bpe \
  --vocabulary $vocab/vocab.10k.$trg \
  --vocabulary-threshold 10 \
  < $inptrg > $data/train.10k.bpe.$trg

## apply on dev source file (tokenized)
subword-nmt apply-bpe -c $models/model.10k.bpe \
  --vocabulary $vocab/vocab.10k.$src \
  --vocabulary-threshold 10 \
  < $dev_inpsrc > $data/dev.10k.bpe.$src

## apply on dev target file (tokenized)
subword-nmt apply-bpe -c $models/model.10k.bpe \
  --vocabulary $vocab/vocab.10k.$trg \
  --vocabulary-threshold 10 \
  < $dev_inptrg > $data/dev.10k.bpe.$trg

## apply on test source file (tokenized)
subword-nmt apply-bpe -c $models/model.10k.bpe \
  --vocabulary $vocab/vocab.10k.$src \
  --vocabulary-threshold 10 \
  < $test_inpsrc > $data/test.10k.bpe.$src

## apply on test target file (tokenized)
subword-nmt apply-bpe -c $models/model.10k.bpe \
  --vocabulary $vocab/vocab.10k.$trg \
  --vocabulary-threshold 10 \
  < $test_inptrg > $data/test.10k.bpe.$trg
