# An example of extension of the jupyter stack 'datascience-notebook'
# with pip modules ('pip install ...') and their system dependancies ('apt-get install -y ...')
FROM jupyter/datascience-notebook
USER root
RUN apt-get update
RUN apt-get install -y python3-pyqt5 pyqt5-dev-tools qttools5-dev-tools
RUN pip install PyQt5 ete3 owlready2 pyproteinsExt ipympl jupyterlab


#Adding dedicated kernel
RUN pip install bash_kernel
RUN python3 -m bash_kernel.install

#Install for non-specific ONT 
RUN apt-get install -y unzip wget build-essential cmake git-all tar gzip curl

#Dedicated install to SV analyses, packed
RUN apt-get install -y minimap2 sniffles seqtk assemblytics samtools bedtools vcftools bcftools
RUN python3 -m pip install matplotlib pandas cython scipy python-igraph psutil pysam setuptools

RUN conda install -c bioconda mummer 
RUN conda install -c bioconda gatk4
RUN conda create -n syri_env -c bioconda syri
RUN conda install -c bioconda plotsr 
RUN conda install -c bioconda snpeff
RUN conda install -c bioconda survivor

#Dedicated install to SV analyses, unpacked
RUN mkdir -p /opt/

## bwa mem2
RUN mkdir -p /opt/bwa-mem2
RUN cd /opt/bwa-mem2 && curl -L https://github.com/bwa-mem2/bwa-mem2/releases/download/v2.0pre2/bwa-mem2-2.0pre2_x64-linux.tar.bz2 | tar jxf -
RUN ln -s /opt/bwa-mem2/bwa-mem2-2.0pre2_x64-linux/bwa-mem2 /usr/bin/bwa-mem2

## breakdancer
RUN cd /opt && git clone --recursive https://github.com/genome/breakdancer.git
RUN cd /opt/breakdancer && mkdir build
RUN cd /opt/breakdancer/build && cmake .. -DCMAKE_BUILD_TYPE=release -DCMAKE_INSTALL_PREFIX=/usr/local
RUN cd /opt/breakdancer/build && make && make install


