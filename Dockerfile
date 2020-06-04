FROM wuyue/python3-app:latest
LABEL maintainer="wuyue92tree@163.com"

WORKDIR /data/src

ADD requirements.txt requirements.txt
ADD visdom.ini /etc/supervisor/conf.d/visdom.ini

RUN pip install -r requirements.txt -i http://mirrors.aliyun.com/pypi/simple --trusted-host mirrors.aliyun.com

RUN rm -rf ~/.cache/pip

# fix download issue, when visdom startup.
RUN sed -i 's/download_scripts()/#download_scripts()/g' /usr/local/lib/python3.7/site-packages/visdom/server.py
RUN rm -rf /usr/local/lib/python3.7/site-packages/visdom/static
COPY static /usr/local/lib/python3.7/site-packages/visdom/static

EXPOSE 8097