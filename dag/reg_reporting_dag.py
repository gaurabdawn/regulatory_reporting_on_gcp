from airflow import DAG
from airflow.operators.bash import BashOperator
from datetime import datetime

# Point to the actual dbt project folder inside the repo
DBT_DIR = "/home/airflow/gcs/data/dbt_project/dbt"
PROFILES_DIR = "/home/airflow/gcs/data"

default_args = {
    "owner": "airflow",
    "retries": 1,
}

with DAG(
    dag_id="dbt_medallion_pipeline",
    start_date=datetime(2024, 1, 1),
    schedule=None,
    catchup=False,
    default_args=default_args,
    tags=["dbt"],
) as dag:

    # 1️⃣ Clone dbt repo
    clone_repo = BashOperator(
    task_id="clone_repo",
    bash_command="""
    if [ -d "/home/airflow/gcs/data/dbt_project/.git" ]; then
        cd /home/airflow/gcs/data/dbt_project
        git pull
    else
        git clone https://github.com/gaurabdawn/regulatory_reporting_on_gcp.git /home/airflow/gcs/data/dbt_project
    fi
    """
    )

    # 2️⃣ Create profiles.yml
    create_profile = BashOperator(
        task_id="create_profile",
        bash_command=f"""
        cat <<EOF > {PROFILES_DIR}/profiles.yml
regulatory_reporting_on_gcp:
  outputs:
    dev:
      dataset: regreport
      job_execution_timeout_seconds: 300
      job_retries: 1
      location: US
      method: oauth
      priority: interactive
      project: reg-reporting-490417
      threads: 1
      type: bigquery
  target: dev
EOF
        """
    )

    # 3️⃣ Install dependencies
    dbt_deps = BashOperator(
        task_id="dbt_deps",
        bash_command=f"""
        export DBT_PROFILES_DIR={PROFILES_DIR}
        cd {DBT_DIR}
        dbt deps
        """
    )

    # 4️⃣ Run BRONZE
    dbt_bronze = BashOperator(
        task_id="dbt_bronze",
        bash_command=f"""
        export DBT_PROFILES_DIR={PROFILES_DIR}
        cd {DBT_DIR}
        dbt run --select bronze
        """
    )

    # 5️⃣ Run SILVER
    dbt_silver = BashOperator(
        task_id="dbt_silver",
        bash_command=f"""
        export DBT_PROFILES_DIR={PROFILES_DIR}
        cd {DBT_DIR}
        dbt run --select silver
        """
    )

    # 6️⃣ Run GOLD
    dbt_gold = BashOperator(
        task_id="dbt_gold",
        bash_command=f"""
        export DBT_PROFILES_DIR={PROFILES_DIR}
        cd {DBT_DIR}
        dbt run --select gold
        """
    )

    # DAG flow
    clone_repo >> create_profile >> dbt_deps >> dbt_bronze >> dbt_silver >> dbt_gold