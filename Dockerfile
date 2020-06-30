FROM ubuntu:18.04 #AS stage1
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get upgrade -y && apt-get clean
RUN apt-get update  && apt-get install -y vim curl wget unzip jq bash ca-certificates git openssl

RUN apt-get update && apt-get install --yes --no-install-recommends supervisor  python-dateutil


RUN apt-get clean
RUN apt-get update
RUN apt-get install --yes --no-install-recommends software-properties-common
RUN apt-get install --yes --no-install-recommends --fix-missing libffi-dev
RUN apt-get install --yes --no-install-recommends libssl-dev
RUN apt-get install --yes --no-install-recommends libxml2-dev libxslt1-dev
RUN apt-get install --yes --no-install-recommends --fix-missing


RUN apt-get install -y curl python3.7 python3.7-dev python3.7-distutils python3-venv
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3.7 1
RUN update-alternatives --set python /usr/bin/python3.7
RUN curl -s https://bootstrap.pypa.io/get-pip.py -o get-pip.py && \
    python get-pip.py --force-reinstall && \
    rm get-pip.py


# if mysql needed it can be installed for ubuntu 18 differently
# RUN apt-get install --yes mysql-server libmysqlclient-dev mysql-client

# docker-engine for ubuntu 18
# RUN echo "deb http://apt.dockerproject.org/repo ubuntu-trusty main" > /etc/apt/sources.list.d/docker.list
# RUN apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
# RUN apt-get install --yes docker-engine=1.10.3-0~trusty
 # node and ember for ubuntu 18
# Install node and Ember dependencies
# RUN curl -sL https://deb.nodesource.com/setup_4.x | bash && \
#         apt-get install --yes --no-install-recommends nodejs libfontconfig
# RUN npm install -g bower \
#     && sudo npm install -g phantomjs-prebuilt \
#     && npm install -g ember-cli

#older
# RUN pip install -U pip
# RUN pip install --upgrade six>=1.10

RUN python3 -V
RUN python -V

###############
#RUN git clone https://github.com/duplodemo/demoservice.git
#
ADD mysite /mysite
WORKDIR /mysite
#outsie venv
RUN pip install awscli boto3 click zappa requests
RUN pip install -r requirements.txt
###
RUN pip install virtualenv
SHELL ["/bin/bash", "-c"]
RUN virtualenv duplo && \
   source duplo/bin/activate  && \
   pip install awscli boto click zappa requests  && \
   pip install -r requirements.txt  && \
   zappa package dev  && \
   ls -alth *.zip

#new zappa build is at /misite/zip/mysite-zappa.zip
RUN mkdir zip && mv mysite-*.zip zip/apigateway-zappa-demo.zip  && ls -atlh zip

#RUN pip install awscli boto3 click zappa requests
#todo:find zip and upload to s3
###############
#
ADD *.sh /
RUN chmod 777 /*.sh

CMD ["/startup.sh"]

# FROM scratch AS export-stage
# COPY  --from=stage1 /mysite/zip/mysite-zappa.zip .
