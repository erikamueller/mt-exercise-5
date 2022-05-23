# MT Exercise 5: Byte Pair Encoding, Beam Search

This repo is just a collection of scripts showing how to install [JoeyNMT](https://github.com/joeynmt/joeynmt), download
data and train & evaluate models.

# Requirements

- This only works on a Unix-like system, with bash.
- Python 3 must be installed on your system, i.e. the command `python3` must be available
- Make sure virtualenv is installed on your system. To install, e.g.

    `pip install virtualenv`

## Steps for setting up and data download

Clone this repository in the desired place:

    git clone https://github.com/erikamueller/mt-exercise-5

Create a new virtualenv that uses Python 3. Please make sure to run this command outside of any virtual Python environment:

    ./scripts/make_virtualenv.sh

**Important**: Then activate the env by executing the `source` command that is output by the shell script above.

Download and install required software:

    ./scripts/download_install_packages.sh

Download data:

    ./download_iwslt_2017_data.sh

The data is only minimally preprocessed, so you may want to tokenize it and apply any further preprocessing steps.

#MT Exercise 5: Experiments with Byte Pair Encoding

## Steps for preprocessing data

Sub-sample parallel training data to 100k sentence pairs to make training manageable on small machines and tokenize
train, dev, test data

    ./scripts/preprocess.sh

Remark: The sub-sample script takes 30 to 40 minutes to run.

## Steps for training of word-level model 

Train word-level JoeyNMT model a) with vocabulary size set to 2000:

    ./scripts/train_word.sh

The training process can be interrupted at any time, and the best checkpoint will always be saved.

Evaluate word-level JoeyNMT model a) with

    ./scripts/evaluate_word.sh

## BPE preprocessing and training of bpe-level model b) with vocabulary size set to 2000

### Steps for BPE preprocessing 

Learn BPE model:

    ./scripts/bpe_prep.sh

Apply BPE model:

    ./scripts/bpe_apply.sh

Build single vocabulary file:

    ./scripts/bpe_build_joined_vocab.sh

### Steps for training

Train bpe-level JoeyNMT model b) with vocabulary size set to 2000:

    ./scripts/train_bpe.sh

The training process can be interrupted at any time, and the best checkpoint will always be saved.

Evaluate bpe-level JoeyNMT model b) with

    ./scripts/evaluate_bpe.sh

## BPE preprocessing and training of bpe-level model c) with vocabulary size set to 10000

### Steps for BPE preprocessing 

Learn BPE model:

    ./scripts/bpe_prep_10k.sh

Apply BPE model:

    ./scripts/bpe_apply_10k.sh

Build single vocabulary file:

    ./scripts/bpe_build_joined_vocab_10k.sh

### Steps for training

Train bpe-level JoeyNMT model c) with vocabulary size set to 10000:

    ./scripts/train_bpe_10k.sh

The training process can be interrupted at any time, and the best checkpoint will always be saved.

Evaluate bpe-level JoeyNMT model c) with

    ./scripts/evaluate_bpe_10k.sh

#MT Exercise 5: Impact of beam size on translation quality

Change the beam size parameter in the config file of the best model and evaluate ten times according the following list:

Beam size list: [1, 2, 3, 4, 5, 6, 8, 10, 12, 15]

Best model: bpe-level model c) with vocabulary size set to 10000. Evaluation run with all the beam sizes results in the
following list of BLEU score.

BLEU list: [19.8, 20.6, 20.9, 21.0, 20.9, 21.0, 21.0, 21.0, 20.8, 20.4]

Configuration file:

    ./configs/transformer_bpe_10k_config.sh

Evaluation:

    ./scripts/evaluate_bpe_10k_beam_size.sh

Jupyter notebook to produce the graph:

    ./scripts/graph.ipynb