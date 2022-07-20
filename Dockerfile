# An example of extension of the jupyter stack 'datascience-notebook'
# with pip modules ('pip install ...') and their system dependancies ('apt-get install -y ...')
FROM jupyter/datascience-notebook
USER root
RUN apt update
RUN apt install -y python3-pyqt5 pyqt5-dev-tools qttools5-dev-tools
RUN pip install PyQt5 ete3 owlready2 pyproteinsExt ipympl jupyterlab

#Adding dedicated kernel
RUN python3 -m pip install --upgrade ipython
RUN python3 -m pip install bash_kernel
RUN python3 -m bash_kernel.install

ENV JUPYTER_ENABLE_LAB=yes

#Install for non-specific ONT 
RUN apt install -y unzip seqtk wget build-essential cmake git-all tar gzip

#Dedicated install to ONT analyses, packed
RUN apt install -y minimap2 sniffles seqtk assemblytics bandage
RUN conda install -c bioconda nanocomp
RUN conda create -n medaka -c conda-forge -c bioconda medaka
RUN conda install -c bioconda raven-assembler
RUN conda install -c bioconda survivor
RUN conda install -c bioconda ragtag
RUN conda install -c bioconda flye
RUN conda install -c bioconda mummer 
RUN conda install -c bioconda racon 
RUN conda install -c bioconda assembly-stats 
RUN conda install -c bioconda nanoplot
RUN conda install -c bioconda python=3.7 quast
RUN conda install -c bioconda blobtools
RUN conda install -c bioconda kraken2 
