# An example of extension of the jupyter stack 'datascience-notebook'
# with pip modules ('pip install ...') and their system dependancies ('apt-get install -y ...')
FROM jupyter/datascience-notebook
USER root
RUN apt update
RUN apt install -y python3-all-dev python3-pip python3-venv
RUN apt install -y python3-pyqt5 pyqt5-dev-tools qttools5-dev-tools
RUN pip install PyQt5 ete3 owlready2 pyproteinsExt ipympl jupyterlab

#Adding dedicated kernel
RUN python3 -m pip install --upgrade ipython
RUN python3 -m pip install bash_kernel
RUN python3 -m bash_kernel.install

ENV JUPYTER_ENABLE_LAB=yes

#Install for non-specific ONT 
RUN apt install -y unzip wget build-essential cmake git-all tar gzip

#Dedicated install to ONT analyses, packed
RUN apt install -y minimap2 sniffles seqtk assemblytics bandage
RUN conda create -n medaka -c conda-forge -c bioconda python=3.6 medaka
RUN conda create -n raven -c bioconda raven-assembler
RUN conda create -n survivor -c bioconda survivor
RUN conda create -n ragtag -c bioconda ragtag
RUN conda create -n flye -c bioconda flye
RUN conda create -n mummer -c bioconda mummer 
RUN conda create -n racon -c bioconda racon 
RUN conda create -n assembly-stats -c bioconda assembly-stats 
RUN conda create -n quast -c bioconda python=3.7 quast
RUN conda create -n blobtools -c bioconda blobtools
RUN conda create -n nanocomp -c bioconda python=3.7 pysam nanocomp nanoplot

