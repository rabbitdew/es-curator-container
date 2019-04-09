# This file builds 'elasticsearch-curator' into a Docker image. Build it with Ansible and set a cron job to curate the cluster. 
# Mount a directory with the ACTION and CONFIG files and use host 
# mode networking so that DNS works. 
# EG:  docker run --name curator --network host -v /opt/es_curator:/opt -e CONFIG_FILE='config.yml' -e ACTION_FILE='delete_indices.yml' curator
FROM python:2.7-stretch
MAINTAINER rabbitdew@protonmail.com
ENV ACTION_FILE=null
ENV CONFIG_FILE=null
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt
CMD curator --config /opt/"${CONFIG_FILE}" /opt/"${ACTION_FILE}" --dry-run
