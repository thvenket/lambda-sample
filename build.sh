#!/bin/bash -e

########
# apt-get update
# apt-get install -y curl python3.7 python3.7-dev python3.7-distutils python3-venv
# update-alternatives --install /usr/bin/python python /usr/bin/python3.7 1
# update-alternatives --set python /usr/bin/python3.7
# curl -s https://bootstrap.pypa.io/get-pip.py -o get-pip.py
# python get-pip.py --force-reinstall
# rm get-pip.py
# apt-get python3-venv
#########
python3 -V
python -V

###############
#git clone https://github.com/duplodemo/demoservice.git #???
cd mysite
pip install awscli boto3 click zappa requests
pip install -r requirements.txt
###
pip install virtualenv
virtualenv duplo
source duplo/bin/activate
pip install awscli boto3 click zappa requests
pip install -r requirements.txt
zappa package dev
ls -alth *.zip

#copy zappa zip build to ./mysite/zip/mysite-zappa.zip
mkdir zip
mv mysite-*.zip zip/mysite-zappa.zip
ls -atlh zip

#s3 uppload
aws s3 cp zip/apigateway-zappa-demo.zip s3://$S3_BUCKET_LAMBDA/

echo "python lambda_update.py  start"
python lambda_update.py
echo "python lambda_update.py  done"

cd ..

echo "lambda_api_gateway_demo Build Finished.."

# sleep 1h
