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

After using above code, the permission issues fixed but SSH connection was interrupted and i was not able to connect back. Thus, i deleted ./logs folder

And recreated my self.
i ran below code to find UID of my AIRFLOW USR and add it to .env file
> echo -e "AIRFLOW_UID=$(id -u)" >> .env

This also fixed the permission issue in ./logs
The SSH Interruption was not due to permission issue, it was because of memory exhaustion.
So, increased VMs memory to 8GM, this is minimum requirement for Airflow

Got Error:
airflow-webserver_1  | ERROR: You need to initialize the database. Please run `airflow db init`. Make sure the command is run using Airflow vers

> docker-compose up airflow-init

Great!! 
Now we can reach to airflow webserver at http://localhost:8085
username:airflow
password:airflow


# Configure Airflow Connections
Go to Admin > Connections
    conn Id: google_cloud_default
    Conn Type: Google Cloud
    Upload service account key file

Add Kafka connection:
    conn Id: kafka_default
    conn Type: Kafka
    Host: kafka
    Port: 9092


We need to run python code in jupyter notebook
So, i installed jupyter note book in uv

> pwd
/home/ani.bhai.yt2022/finalproject-ref
> uv init --python=3.13
> uv add --dev juypter
> uv run jupyter notebook

we get http://localhost:8888/tree?token=edb09184be5d913ec7337bd7f895cd10e3d8331783124806
You can use jupter notebook in browser as well as in VS Code.

Create notebook.ipynb
test notebook cell by executing 
print(123)

VS code will ask for kernel.
we can use above url in VS code as Jupyter kernel. So that we can execute python code in notebook cell.

job_id
fetch_api_to_gcs executed successfully
prepare_transform_script executed successfully


Enable Dataflow API in GCP
Job was lunched but getting error

severity: "ERROR"
textPayload: "Error occurred in the launcher container: Template launch failed. See console logs."

Added Below roles to the svc_dtc-ab-de-2026@developer.gserviceaccount.com
roles/Viewer

And use this service account to run the Dataflow Jobs
"environment": {
                    "serviceAccountEmail": "svc-dtc-ab-de-2026@dtc-ab-de-2026.iam.gserviceaccount.com"
                }
Add this code below parameters:

Finally Dataflow job ran successfully.


