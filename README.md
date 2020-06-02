# Interpretable Evaluation for CWS
The implementation of interpretable evaluation for NER in our paper:

"Is Chinese Word Segmentation a Solved Task? Rethinking Neural Chinese Word Segmentation"

## Advantages of This Codes
* The process of generating analysis and diagnosis figures, the latex-sources (utilized to generate the figures), and the web page (used to display the results) are automatic.
* It is easy to delete or add attributes by simply modifying the `conf.cws-attributes`.
* It is easy to change the bucketing method for a specific attribute by modifying the definition of the bucketing method in  `conf.cws-attributes`.
* It is easy to extend this code for other sequence labeling tasks. Only a few parameters in the `run_task_cws.sh` need to be modified, such as `task_type` and  `path_attribute_conf`. (It may be necessary to add or delete attributes appropriately.)
* It can help us quickly analyze and diagnose the strengths and weaknesses of a model.




## Requirements

-  `python3`
-  `texlive`
- `pip3 install -r requirements.txt`

 
## Run

`./run_task_cws.sh`

The shell scripts include the following three aspects:

- `tensorEvaluation-cws.py` -> Calculate the dependent results of fine-grained analysis.

- `genFig.py` -> Drawing figures to show the results of the fine-grained analysis.

- `genHtml.py` -> Put the figures drawing in the previous step into the web page.

After running the above command, a web page named "tEval-cws.html" will be generated for displaying the analysis and diagnosis results of the models. You can check the results from this link: https://anonymous4nlp.github.io/analysis/tEval-cws.html

## Datasets

The datasets utilized in our paper including:

- ctb (in this repository.)
- msr, cityu, ckip, ncc, pku, sxu 


## Results
We provide analysis and diagnosis of model architectures and pre-trained knowledge on **seven** data sets, and the results are shown on the following web pages.

- **Flair-ELMo**: https://anonymous4nlp.github.io/analysis/tEval-ctb-msr-bertelmo.html


## The analysis results

Our model analysis and diagnosis includes **five** aspects: 
- Holistic Results; 
- Break-down Performance; 
- Self-diagnosis; 
- Aided-diagnosis; 
- Heatmap. 
Following, we give an example of the **BERT- and ELMo-system pair** analysis and diagnosis on **ctb**.

1) Holistic Results

![show fig](https://github.com/anonycws/interpretablecws.github.io/raw/master/img/1holistic-result.png)

2) Break-down Performance

LSTM: ![show fig](https://github.com/anonycws/interpretablecws.github.io/raw/master/img/2breakdown-bert.png)

CNN: ![show fig](https://github.com/anonycws/interpretablecws.github.io/raw/master/img/2breakdown-elmo.png)


3) Self-diagnosis

![show fig](https://github.com/anonycws/interpretablecws.github.io/raw/master/img/3selfdiag-bertelmo.png)

4) Aided-diagnosis

![show fig](https://github.com/anonycws/interpretablecws.github.io/raw/master/img/4compdiag-bertelmo.png)

5) Heatmap

![show fig](https://github.com/anonycws/interpretablecws.github.io/raw/master/img/5heatmap.png)


## Analysis and diagnosis your own model.

1) Put the result-file of your model on this path: `preComputed/cws/result/`. In order to carry out model diagnosis, two or more model result files must be included. You can also choose one of the result files provided by us as the reference model.

2) Put the train-set which your result-file trained on the path: `./data/`. You need to set the column delimiter of your train-set and result-file in the `main()` function of `tensorEvaluation-cws.py`.

3) Set the `path_data` (path of training set), `datasets[-]` (dataset name), `model1` (the first model's name), `model2` (the second model's name), `resfiles[-]` (the paths of the results) in `run_task_cws.sh` according to your data.

### Note: 
- **More than two result files are required.**  Because comparative-diagnosis is to compare the strengths and weaknesses of the model architectures and pre-trained knowledge between two or more models, it is necessary to input as least two model results. 

- **The result file must include three columns of words, true-tags, and predicted-tags, separated by space.** If your result file is not in the required format, you can modify the function `read_data()` in file `tensorEvaluation-cws.py` to adaptive to your format. 

Here, we give an example of result file format as follow:

![show fig](https://github.com/anonymous4nlp/anonymous4nlp.github.io/blob/master/img/data-format.png)




