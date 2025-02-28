###
### script for BERT training on gpu
### reference:
###   https://github.com/mingfeima/pytorch-transformers#run_gluepy-fine-tuning-on-glue-tasks-for-sequence-classification
###
### 1. prepare dataset:
###   https://gist.github.com/W4ngatang/60c2bdb54d156a41194446737ce03e2e
###
### 2. install:
###   pip install --editable .
###   pip install -r ./examples/requirements.txt
###


NUM_GPUS=`python -c "import torch;print(torch.cuda.device_count())"`
[ $NUM_GPUS -gt 1 ] && echo -e "\n### the script run multi gpus by default, use your judgement wisedly!\n"

GLUE_DIR=./dataset/glue_data
TASK_NAME=MRPC

BATCH_SIZE=8 # default bs
OUTPUT=${TASK_NAME}_output
[ -d "$OUTPUT" ] || mkdir $OUTPUT

python ./examples/run_glue.py --model_type bert \
    --model_name_or_path bert-base-uncased \
    --task_name MRPC \
    --do_eval \
    --do_train \
    --do_lower_case \
    --data_dir $GLUE_DIR/$TASK_NAME/ \
    --max_seq_length 128 \
    --per_gpu_eval_batch_size $BATCH_SIZE \
    --per_gpu_train_batch_size $BATCH_SIZE \
    --save_steps 400 \
    --learning_rate 2e-5 \
    --num_train_epochs 1.0 \
    --output_dir $OUTPUT
