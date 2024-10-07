# Use NVIDIA's CUDA 11.4.3 base image with support for TensorFlow and GPU
FROM nvidia/cuda:11.4.3-cudnn8-devel-ubuntu20.04

# Set environment variables for CUDA
ENV LD_LIBRARY_PATH=/usr/local/cuda/lib64:/usr/local/cuda/extras/CUPTI/lib64
ENV CUDA_HOME=/usr/local/cuda

# Update the package lists and install necessary tools (including OpenGL and X11 support)
RUN apt-get update && apt-get install -y \
    python3-pip \
    python3-dev \
    git \
    wget \
    libgl1-mesa-glx \
    libegl1-mesa \
    libgles2-mesa \
    x11-apps \
    && rm -rf /var/lib/apt/lists/*

# Install Miniconda
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
    bash ~/miniconda.sh -b -p $HOME/miniconda && \
    rm ~/miniconda.sh

# Initialize conda and add to PATH
ENV PATH=/root/miniconda/bin:$PATH
RUN conda init bash

# Create conda environment for crYOLO with CUDA 11 support
RUN conda create -n cryolo -c conda-forge -c anaconda pyqt=5 python=3.8 numpy=1.18.5 libtiff wxPython=4.1.1 adwaita-icon-theme 'setuptools<66'

# Activate crYOLO environment and install crYOLO with custom TensorFlow for CUDA 11
RUN /bin/bash -c "source activate cryolo && \
    pip install nvidia-pyindex && \
    pip install 'cryolo[c11]'"

# Create and activate environment for napari and install napari-boxmanager
RUN conda create -y -n napari-cryolo -c conda-forge python=3.10 napari=0.4.17 pyqt pip
RUN /bin/bash -c "source activate napari-cryolo && pip install napari-boxmanager"

# Separate the steps to set up napari link, breaking into smaller parts
RUN /bin/bash -c "source activate cryolo && \
    echo 'Setting up napari link...' && \
    cryolo_dir=/root/miniconda/envs/cryolo/bin && \
    napari_link_file=${cryolo_dir}/napari_boxmanager"

# Continue in the next RUN step for simplicity
RUN /bin/bash -c "source activate napari-cryolo && \
    echo -e '#!/usr/bin/bash\nexport NAPARI_EXE=$(which napari)\nnapari_exe=$(which napari_boxmanager)\n\${napari_exe} \"\${@}\"' > /root/miniconda/envs/cryolo/bin/napari_boxmanager && \
    chmod +x /root/miniconda/envs/cryolo/bin/napari_boxmanager && \
    echo 'Napari link created at /root/miniconda/envs/cryolo/bin/napari_boxmanager'"

# Set the default entrypoint to bash
ENTRYPOINT ["/bin/bash"]
