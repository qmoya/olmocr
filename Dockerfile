# Use the continuumio/anaconda3 image which includes Anaconda
FROM continuumio/anaconda3

# Set noninteractive mode for apt-get
ENV DEBIAN_FRONTEND=noninteractive

# Install required Ubuntu packages
RUN apt-get update && apt-get install -y install poppler-utils ttf-mscorefonts-installer msttcorefonts fonts-crosextra-caladea fonts-crosextra-carlito gsfonts lcdf-typetools

# Create a new conda environment named "olmocr" with Python 3.11
RUN conda create -n olmocr python=3.11 -y && conda clean -afy

# Set the PATH to use the olmocr environment by default
ENV PATH /opt/conda/envs/olmocr/bin:$PATH

# Clone the olmocr repository and install it in editable mode with GPU extras
WORKDIR /opt
RUN git clone https://github.com/allenai/olmocr.git

WORKDIR /opt/olmocr
RUN pip install -e .[gpu] --find-links https://flashinfer.ai/whl/cu124/torch2.4/flashinfer/

# Default command to run when starting the container
CMD ["bash"]