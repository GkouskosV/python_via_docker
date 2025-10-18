# 1) Base: Miniconda (CPU). Pin a tag if you want reproducibility
FROM continuumio/miniconda3:latest

# 2) Workdir
WORKDIR /workspace

# 3) Copy manifests FIRST (to leverage Docker layer caching
COPY environment.yml requirements.txt ./

# 4) Speed up and stabilize solves
RUN conda config --system --set channel_priority strict && \
    conda install -y mamba -n base && \
    mamba env update -n base -f environment.yml && conda clean -afy

# 5) From now on, run inside the conda env
SHELL ["conda", "run", "-n", "base_env", "/bin/bash", "-c"]

# 6) Optional: If we also keep a requirements file, it is the time to install
RUN if [ -s requirements.txt ]; then pip install --no-cache-dir -r requirements.txt; fi

# 7) Helpful defaults for pip
ENV PIP_DISABLE_PIP_VERSION_CHECK=1 \
    PYTHONDONTWRITEBYCODE=1 \
    PYTHONUNBUFFERED=1

CMD ["bash"]