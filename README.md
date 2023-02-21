# judo-datasets

This is a plugin for the [judo](https://github.com/dennisschneider-ml/judo) project and adds a reproducible way to preprocess datasets.

## Why would I want to use judo-datasets?

If you use datasets in a project, you probably want other researchers to be able to easily reproduce your results, beginning with using the same datasets.
Most research projects provide a step-by-step instruction on how to get these datasets.
But why not encapsule all this into a single command? \
judo-datasets is an extension of the judo project and provides an easy and reproducible way to generate datasets by simply invoking the `make` command, generating only these datasets which have not been processed yet, which also makes it suitable for using while continuously adding new datasets to the project.

## Great, so how does it work?


First, run `make` once to create the `./data/` directory in the root of your project.

After finding a dataset you want to use, add an empty directory in this `./data/` directory.
Run `make` again to create the recommended directory structure for the new dataset.

This results in the following data tree:
```shell
 data
└──  dataset
   ├──  get_original_data.sh
   ├──  original
   ├──  preprocess.py
   └──  preprocessed
```
At this point you can place the commands for populating the `original`-subdirectory in the `get_original_data.sh` file.
Furthermore, the `preprocess.py` script enables us to preprocess the original datasets for further usage.
By invoking `make` once more, the sh script is invoked and the files are downloaded (or however you choose to retrieve these files).
And, since no files have been preprocessed yet, all files in `original` are then suitably converted into preprocessed files by running them through `preprocess.py`.
It conveniently already employs multithreading and splits up the dataset among all CPU-cores. You simply have to implement the preprocessing-logic in the `process`-function in the python-script.

The Makefile conveniently detects which datasets need a file-structure, which files have to be downloaded and which have unprocessed data. So mass-processing multiple datasets over night is as easy as it gets. \
Furthermore, by adding the `original` and `preprocessed` subdirectories in the gitignore, a researcher can reproduce all datasets by simply running `make`.

## I want to use this without the Docker ... stuff

Sure, for this case, you are not interested in the `run.py`-file.
In order to get only the relevant files and set them up correctly, run the following commands:
```Makefile
wget https://raw.githubusercontent.com/dennisschneider-ml/judo-datasets/main/Makefile
wget https://raw.githubusercontent.com/dennisschneider-ml/judo-datasets/main/preprocess.py
sed -i 's/^PROCESSING_SCRIPT=.*$/PROCESSING_SCRIPT=.\/preprocess.py/' Makefile
```
