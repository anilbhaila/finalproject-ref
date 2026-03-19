Referenced Project
https://github.com/Maddiezheng/LTA_CarParkAvailability_DE_Project


Install terraform locally with mentioned tutorials
https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli

> sudo apt update
> sudo apt-get install terraform

> terraform init
> terraform plan
> terraform apply
> terraform destroy


All working in this project. Till upto this point.

> pwd
/home/ani.bhai.yt2022/finalproject-ref/processing

> docker-compose up -d
Creating carpark-redpanda ... done

# Set Up Airflow Workflow Orchestration

> pwd
/home/ani.bhai.yt2022/finalproject-ref/orchestration
> docker-compose up -d
Starting orchestration_postgres_1 ... done
Starting orchestration_airflow-webserver_1 ... done
Starting orchestration_airflow-init_1      ... done
Starting orchestration_airflow-scheduler_1 ... done

So, Orchestration, airflow is working great. no error.

Port mapping needed to access airflow at  http://localhost:8085

Got error. due to permission issues.

> sudo chown -R 50000:0 ./logs
> sudo chmod -R 775 ./logs

Got Error:
airflow-webserver_1  | ERROR: You need to initialize the database. Please run `airflow db init`. Make sure the command is run using Airflow vers

> docker-compose up airflow-init

Great!! 
Now we can reach to airflow webserver at http://localhost:8085
username:airflow
password:airflow