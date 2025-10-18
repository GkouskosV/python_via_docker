# 1) Base: Miniconda (CPU). Pin a tag if you want reproducibility
FROM continuumio/miniconda3:latest

# 2) Workdir
WORKDIR /workspace