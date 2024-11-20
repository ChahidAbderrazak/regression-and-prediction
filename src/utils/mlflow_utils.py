import os

import mlflow
from dotenv import find_dotenv, load_dotenv

os.environ["GIT_PYTHON_REFRESH"] = "quiet"


def check_mlflow_server_isalive(uri):
    import requests

    response = requests.get(uri + "/health")
    if response.status_code == 200:
        print(f"- the MLflow server {uri} is up and running")
        return 0
    else:
        msg = f"- the MLflow server {uri} is not reachable"
        print(msg)
        return 1
        # raise Exception(msg)


def load_env_variables(verbose=0):
    if verbose > 0:
        print(" -> searching/load for the env files ...")
    list_env_file = (
        [find_dotenv(".env")]
        + [find_dotenv(".env-ip")]
        + [find_dotenv(".env-mlops")]
        + [find_dotenv(".env-ip-mlops")]
    )

    # loading the env variables
    if verbose > 0:
        print(" -> loading the env variables")
        print(f"\t- list_env_file={list_env_file}")
    for filepath in list_env_file:
        if verbose > 0:
            print(f"\t- loading: {filepath}")
        load_dotenv(filepath)


def setup_mlflow(verbose=1):
    # searching/load for the env files
    load_env_variables(verbose=verbose)
    # setting the mlflow URI
    uri = os.getenv("MLFLOW_SERVER_URL")
    MLFLOW_S3_ENDPOINT_URL = os.getenv("MLFLOW_S3_ENDPOINT_URL")
    if verbose > 0:
        print(f" -> the MLflow URI= {uri}")
        print(f" -> MLFLOW_S3_ENDPOINT_URL= {MLFLOW_S3_ENDPOINT_URL}")
    # checking the mlflow tracking uri
    mlflow.set_tracking_uri(uri)
    err = check_mlflow_server_isalive(uri)
    if err == 0:
        return uri
    else:
        return ""


def get_or_create_experiment(experiment_name):
    """
    Retrieve the ID of an existing MLflow experiment or
    create a new one if it doesn't exist.

    This function checks if an experiment with the given
    name exists within MLflow. If it does, the function
    returns its ID. If not, it creates a new experiment
    with the provided name and returns its ID.

    Parameters:
    - experiment_name (str): Name of the MLflow experiment.

    Returns:
    - str: ID of the existing or newly created MLflow experiment.
    """

    if experiment := mlflow.get_experiment_by_name(experiment_name):
        return experiment.experiment_id
    else:
        # Create an experiment name, which must be unique and case sensitive
        return mlflow.create_experiment(experiment_name)
