import json

import matplotlib.pyplot as plt
import mlflow
import numpy as np
import pandas as pd
from dotenv import load_dotenv


def visualization(true_qualities, predicted_qualities):
    t = np.arange(0, len(true_qualities), 1)

    plt.figure(figsize=(10, 10))
    plt.plot(t, predicted_qualities, "b.", t, true_qualities, "g*")
    plt.legend(["Predicted Quatity", "True Quatity"])
    plt.savefig("artifacts/inference/predictions.png")
    # plt.show()

    plt.figure(figsize=(10, 10))
    plt.scatter(true_qualities, predicted_qualities, c="crimson")
    plt.yscale("log")
    plt.xscale("log")
    p1 = max(max(predicted_qualities), max(true_qualities))
    p2 = min(min(predicted_qualities), min(true_qualities))
    plt.plot([p1, p2], [p1, p2], "b-")
    plt.xlabel("True Values", fontsize=15)
    plt.ylabel("Predictions", fontsize=15)
    plt.axis("equal")
    plt.savefig("artifacts/inference/prediction_correlation.png")
    # plt.show()


if __name__ == "__main__":

    test_data_path = "artifacts/data_transformation/test.csv"
    json_file_path = "artifacts/model_evaluation/metrics.json"
    # the JSON file
    with open(json_file_path, "r") as file:
        model_info = json.load(file)

    # load credentials
    # credential_path = ".env-ip-mlops"
    # load_dotenv(credential_path)
    credential_path = ".env-mlops"
    load_dotenv(credential_path)

    # load trained model
    logged_model = model_info["model_uri"]

    # Load model as a PyFuncModel.
    loaded_model = mlflow.pyfunc.load_model(logged_model)

    # load data
    test_data = pd.read_csv(test_data_path)
    test_x = test_data.drop(["quality"], axis=1)
    true_qualities = test_data["quality"].values
    print(f"test_data={test_x.head()}")

    # Predict on a Pandas DataFrame.
    predicted_qualities = loaded_model.predict(pd.DataFrame(test_x))

    # print(
    #    f"\n - true_qualities={true_qualities}\
    #       \n - predicted_qualities={predicted_qualities}"
    # )

    # visualization
    visualization(true_qualities, predicted_qualities)
