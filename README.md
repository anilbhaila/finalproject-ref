# First
GCP Project Set up
Created New Project: dtc-ab-de-2026
Created New Service Account: svc_dtc-ab-de-2026
    Added Role: Owner

Generated Key for service account: gave error because Disable service account key creation is enabled.
Organization Policies => Disable service account key creation => Manage Policy => Override parent's policy => Add Rule => Enforcement => Off

Now you can create service account key:
Select dtc-ab-de-2026 => Service Accounts => svc_dtc-ab-de-2026 => keys => Add key => Create new key => JSON


What i did to understand this project reference:

https://github.com/Giko20/DataTalks-Data-Engineering-Project/blob/main/README.md

Let's run the project without error first.

# Created the .env file and added below code and adjusted accordingly. This .env file is used in docker-compose.yaml file
    POSTGRES_USER=airflow
    POSTGRES_PASSWORD=airflow
    POSTGRES_DB=etl_db
    KAFKA_BROKER=kafka:9092
    BIGQUERY_PROJECT=dtc-ab-de-2026
    BIGQUERY_DATASET=dtc_project_bucket

# requirements.txt file is created and added below code: This requirement.txt file is used in Dockerfile
pandas
requests
beautifulsoup4
sqlalchemy
kafka-python
pyarrow
apache-airflow-providers-docker
docker

# Created Dockerfile and copied below code: This file is used in docker-compose.yaml to build custom airflow image.
FROM apache/airflow:2.10.4

USER root

RUN groupadd docker
RUN usermod -aG docker airflow

USER airflow

COPY requirements.txt .

RUN pip install -r requirements.txt


# Created Dockerfile.kafka and copied below code:
# Description: Dockerfile to build a custom image for Kafka
FROM bitnami/kafka:3.6.1

USER root

RUN mkdir -p /var/lib/apt/lists/partial && \
    apt-get clean && \
    apt-get update -y && \
    apt-get install -y --no-install-recommends \
    python3 \
    python3-pip \
    python3-venv && \
    rm -rf /var/lib/apt/lists/*

RUN python3 -m venv /venv
ENV PATH="/venv/bin:$PATH"

RUN pip install --no-cache-dir \
    pandas==2.2.1 \
    kafka-python==2.0.2 \
    numpy==1.26.4 \
    apache-airflow-providers-apache-kafka==1.3.0

ENV KAFKA_CFG_LISTENER_SECURITY_PROTOCOL_MAP="PLAINTEXT:PLAINTEXT"
USER 1001

# Created Dockerfile.kafka and copied below code:
# Description: Dockerfile to build a container with Terraform installed
FROM ubuntu:latest

USER root

# Update and install dependencies
RUN apt-get update && apt-get install -y wget unzip

COPY /terraform /terraform
WORKDIR /terraform

# Download and install Terraform
RUN wget https://releases.hashicorp.com/terraform/1.5.0/terraform_1.5.0_linux_amd64.zip \
    && unzip terraform_1.5.0_linux_amd64.zip \
    && mv terraform /usr/local/bin/ \
    && rm terraform_1.5.0_linux_amd64.zip

CMD ["sleep", "infinity"]

# create-topics.sh is created with below code, which is made availble in docker image via volumes mapping in docker-compose.yaml

#!/bin/bash
echo "Attempting to create Kafka topic ..."
/opt/bitnami/kafka/bin/kafka-topics.sh --create \
  --bootstrap-server localhost:9092 \
  --replication-factor 1 \
  --partitions 1 \
  --topic ${'KAFKA_TOPIC'} \
  --if-not-exists

echo "Topic creation attempt completed"

# terraform directory is created and added below file:
main.tf
variables.tf

# Created key directory and added gcp-credentials.json file

# Created data folder

# Created dags folder and added below file:
project_01_dag.py
