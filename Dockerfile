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
RUN apt install -y minimap2 seqtk samtools bedtools vcftools bcftools assemblytics bandage
RUN python3 -m pip install matplotlib pandas

RUN conda install -c bioconda nanocomp
RUN conda create -n medaka -c conda-forge -c bioconda medaka
RUN conda install -c bioconda raven-assembler
RUN conda install -c bioconda ragtag
RUN conda install -c bioconda flye
RUN conda install -c bioconda mummer 
RUN conda install -c bioconda racon 
RUN conda install -c bioconda assembly-stats 
RUN conda install -c bioconda nanoplot
RUN conda install -c bioconda python=3.7 quast
RUN conda install -c bioconda blobtools
RUN conda install -c bioconda kraken2
RUN conda install -c bioconda porechop
RUN conda install -c bioconda diamond
RUN conda install -c bioconda blast
RUN conda install -c bioconda sourmash
RUN conda install -c bioconda kaiju

#Dedicated install to ONT analyses, unpacked
RUN mkdir -p /opt/

## bwa mem2
RUN mkdir -p /opt/bwa-mem2
RUN cd /opt/bwa-mem2 && curl -L https://github.com/bwa-mem2/bwa-mem2/releases/download/v2.0pre2/bwa-mem2-2.0pre2_x64-linux.tar.bz2 | tar jxf -
RUN ln -s /opt/bwa-mem2/bwa-mem2-2.0pre2_x64-linux/bwa-mem2.avx2 /usr/bin/bwa-mem2
