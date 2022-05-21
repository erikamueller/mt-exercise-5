#! /bin/bash

scripts=`dirname "$0"`
base=$scripts/..
data=$base/data
vocab=$base/vocab
mkdir -p $vocab

src=en
trg=de

num_threads=4

# train a joint BPE model
OMP_NUM_THREADS=$num_threads python tools/joeynmt/scripts/build_vocab.py \
$data/train.bpe.$src $data/train.bpe.$trg --output_path $vocab/vocab.$src-$trg.txt
