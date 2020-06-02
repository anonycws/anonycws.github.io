# Task type
task_type="cws"

# path of training data
path_data="./data/"

# path of conf file
path_aspect_conf="conf.cws-attributes"

# # Part1: Dataset Name
# datasets[0]="ctb"
# # Part2: Model Name
# model1="sent_long"
# model2="sent_1"
# # Part3: Path of result files
# resfiles[0]="./preComputed/cws/result/ctb_CbertWnone_lstmMlp_sent5_long2short_9759.txt"
# resfiles[1]="./preComputed/cws/result/ctb_CbertWnone_lstmMlp_sent1_9768.txt"


# Part1: Dataset Name
# datasets[0]="msr"
datasets[0]="ctb"

# datasets[1]="pku"
# datasets[2]="ctb"
# datasets[3]="ckip"
# datasets[4]="cityu"
# datasets[5]="ncc"
# datasets[6]="sxu"
# Part2: Model Name
model1="BERT"
model2="ELMo"
# Part3: Path of result files
# resfiles[0]="./preComputed/cws/result/msr_CbertBnonLstmMlp_9819.txt"
# resfiles[1]="./preComputed/cws/result/msrtest_CelmBnonLstmMlp_88011852_9623.txt"
resfiles[0]="./preComputed/cws/result/ctb_CbertBnonLstmMlp_9768.txt"
resfiles[1]="./preComputed/cws/result/ctbtest_CelmBnonLstmMlp_81936000_9677.txt"

# cityu_CbertBnonLstmMlp_9709.txt
# ckip_CbertBnonLstmMlp_9623.txt
# ncc_CbertBnonLstmMlp_9577.txt
# pku_CbertBnonLstmMlp_9647.txt
# sxu_CbertBnonLstmMlp_9749.txt

# cityutest_CelmBnonLstmMlp_81326478_9644.txt
# ckiptest_CelmBnonLstmMlp_12263936_9483.txt
# ncctest_CelmBnonLstmMlp_76676118_9321.txt
# pkutest_CelmBnonLstmMlp_13529136_9533.txt
# sxutest_CelmBnonLstmMlp_97049727_9647.txt




path_preComputed="./preComputed"
path_fig=$task_type"-fig"
path_output_tensorEval="output_tensorEval/"$task_type/$model1"-"$model2


# -----------------------------------------------------
rm -fr $path_output_tensorEval/*
echo "${datasets[*]}"
python3 tensorEvaluation-cws.py \
	--path_data $path_data \
	--task_type $task_type  \
	--path_fig $path_fig \
	--data_list "${datasets[*]}"\
	--model_list $model1  $model2 \
	--path_preComputed $path_preComputed \
	--path_aspect_conf $path_aspect_conf \
	--resfile_list "${resfiles[*]}" \
	--path_output_tensorEval $path_output_tensorEval




cd analysis
rm ./$path_fig/$model1"-"$model2/*.results
rm ./$path_fig/$model1"-"$model2/*.tex
for i in `ls ../$path_output_tensorEval`
do
	cat ../$path_output_tensorEval/$i | python3 genFig.py --path_fig $path_fig/$model1"-"$model2 --path_bucket_range ./$path_fig/$model1"-"$model2/bucket.range \
		--path_bucketInfo ./$path_fig/$model1"-"$model2/bucketInfo.pkl
done


# -----------------------------------------------------

# run pdflatex .tex
cd $path_fig
cd $model1"-"$model2
find=".tex"
replace=""

for i in `ls *.tex`
do
	file=${i//$find/$replace}
	echo $file
	pdflatex $file.tex > log.latex
	pdftoppm -png $file.pdf > $file.png
done

# # -----------------------------------------------------

echo "begin to generate html ..."

rm -fr *.aux *.log *.fls *.fdb_latexmk *.gz
cd ../../
# cd analysis
echo "####################"
python3 genHtml.py 	--data_list ${datasets[*]} \
			--model_list $model1  $model2 \
			--path_fig_base ./$path_fig/$model1"-"$model2/ \
			--path_holistic_file ./$path_fig/$model1"-"$model2/holistic.results \
			--path_aspect_conf ../$path_aspect_conf \
			--path_bucket_range ./$path_fig/$model1"-"$model2/bucket.range \
			> tEval-$task_type.html


sz tEval-$task_type.html
tar zcvf $path_fig.tar.gz $path_fig
sz $path_fig.tar.gz

