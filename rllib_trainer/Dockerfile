FROM continuumio/miniconda3

COPY environment.yml / 
COPY entrypoint.sh /
RUN conda env create -f environment.yml
RUN git clone https://github.com/romi2002/gym-usv.git && cd gym-usv && conda run -n rllib pip install -e .
ENTRYPOINT ["./entrypoint.sh"]
