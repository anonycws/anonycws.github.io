# Interpretable Evaluation for CWS
The implementation of interpretable evaluation for CWS in our paper:

"Is Chinese Word Segmentation a Solved Task? Rethinking Neural Chinese Word Segmentation"

## Advantages of This Codes
* Our codes can automatically generate figures (with latex codes), web pages.
* It is easy to delete or add attributes by simply modifying the `conf.cws-attributes`.
* It is easy to change the bucketing strategy for a specific attribute by modifying the bucketing strategy defined in  `conf.cws-attributes`.
* It is easy to extend this code for other sequence labeling tasks. Only a few parameters in the `run_task_cws.sh` need to be modified, such as `task_type` and  `path_attribute_conf`. (Maybe adding or deleting attributes are needed.)
* It can help us quickly analyze and diagnose the strengths and weaknesses of a model.


## Requirements

-  `python3`
-  `texlive`
- `pip3 install -r requirements.txt`

 
## Run

`./run_task_cws.sh`

The shell scripts include the following three aspects:

- `tensorEvaluation-cws.py` -> Calculate the dependent results of the fine-grained analysis.

- `genFig.py` -> Drawing figures to show the results of the fine-grained analysis.

- `genHtml.py` -> Put the figures drawing in the previous step into the web page.

After running `./run_task_cws.sh`, a web page named "tEval-cws.html" will be generated for displaying the figures with respect to fine-grained analysis. 


## Datasets

The datasets utilized in our paper including:

- ctb (in this repository.)
- msr, cityu, ckip, ncc, pku, sxu 


## Results
We provide analysis and diagnosis of model architectures and pre-trained knowledge on **seven** data sets, and the fine-grained analysis includes **five** aspects: 
- Holistic Results; 
- Break-down Performance; 
- Self-diagnosis; 
- Aided-diagnosis; 
- Heatmap. 

Following, we give an example of the **BERT- and ELMo-system pair** analysis and diagnosis on **ctb**.

1) Holistic Results

![show fig](https://github.com/anonycws/interpretablecws.github.io/raw/master/img/1holistic-result.png)

2) Break-down Performance

BERT: ![show fig](https://github.com/anonycws/interpretablecws.github.io/raw/master/img/2breakdown-bert.png)

ELMo: ![show fig](https://github.com/anonycws/interpretablecws.github.io/raw/master/img/2breakdown-elmo.png)


3) Self-diagnosis

![show fig](https://github.com/anonycws/interpretablecws.github.io/raw/master/img/3selfdiag-bertelmo.png)

4) Aided-diagnosis

![show fig](https://github.com/anonycws/interpretablecws.github.io/raw/master/img/4compdiag-bertelmo.png)

5) Heatmap

![show fig](https://github.com/anonycws/interpretablecws.github.io/raw/master/img/5heatmap.png)

You can check the above example with the web page:
- **BERT-ELMo**: https://anonycws.github.io/analysis/tEval-cws-ctb-bertelmo.html

## Analysis and diagnosis your own model.

1) Put the result-files of your models on this path: `preComputed/cws/result/`. 
At least two result-files are required because the comparative-diagnosis is based on comparing with two models. 
If you have only one result-file for a model, you can choose one result-file provided by us (on the path: `preComputed/cws/metric/result/`).

2) Put the train-set (your result-file trained on) on the path: `./data/`. 
<!-- You need to set the column delimiter of your train-set and result-file in the `main()` function of `tensorEvaluation-ner.py`. -->

3) Modify parameters in `run_task_ner.sh` to adjust to your data. Such as setting the following parameters:   `path_data` (path of training set), `datasets[-]` (dataset name), `model1` (the first model's name), `model2` (the second model's name), and `resfiles[-]` (the paths of the results).

### Note: 
- **At least two result-files are required.**  Comparative-diagnosis is utilized to compare the strengths and weaknesses of two models, so it is necessary to input as least two model results. 

- **The result-file must contain three columns separated by spaces, the columns from left to right are words, true-tags, and predicted-tags.** If your result-file format does not meet the requirement, you can set the column delimiter of your result-file (or train-set file) in `tensorEvaluation-cws.py`.

Here, we give an example of result file format as follow:

<!-- ![show fig](https://github.com/anonycws/anonycws.github.io/raw/master/img/data-format.png) -->
<img src="https://github.com/anonycws/anonycws.github.io/raw/master/img/data-format.png" width="150">
