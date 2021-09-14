#!/bin/bash
source ~/env37/bin/activate

TASK_NAME=MNLI
CLUSTER_NUM=8
FT_BERT_BASE_DIR=/home/mcao610/scratch/TinyBERT_TEST/${TASK_NAME}/teacher-cluster-${CLUSTER_NUM}
GENERAL_TINYBERT_DIR=/home/mcao610/scratch/General_TinyBERT_6L_768D
TASK_DIR=/home/mcao610/scratch/glue_data/${TASK_NAME}
TMP_TINYBERT_DIR=/home/mcao610/scratch/TinyBERT_TEST/${TASK_NAME}/intermediate-cluster-${CLUSTER_NUM}

mkdir $TMP_TINYBERT_DIR
python /home/mcao610/Pretrained-Language-Model/TinyBERT/task_distill.py \
                                    --teacher_model ${FT_BERT_BASE_DIR} \
                                    --student_model ${GENERAL_TINYBERT_DIR} \
                                    --data_dir ${TASK_DIR} \
                                    --task_name ${TASK_NAME} \
                                    --output_dir ${TMP_TINYBERT_DIR} \
                                    --max_seq_length 128 \
                                    --train_batch_size 32 \
                                    --num_train_epochs 10 \
                                    --eval_step 3000 \
                                    --aug_train \
                                    --do_lower_case \
                                    --k ${CLUSTER_NUM};