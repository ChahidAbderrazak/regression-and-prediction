from pathlib import Path
from urllib.parse import urlparse

import joblib
import mlflow
import mlflow.sklearn
import numpy as np
import pandas as pd
from sklearn.metrics import mean_absolute_error, mean_squared_error, r2_score

from entity.config_entity import ModelEvaluationConfig
from utils.common import save_json


class ModelEvaluation:
    def __init__(self, config: ModelEvaluationConfig):
        self.config = config
        self.artifact_path = "model"

    def eval_metrics(self, actual, pred):
        rmse = np.sqrt(mean_squared_error(actual, pred))
        mae = mean_absolute_error(actual, pred)
        r2 = r2_score(actual, pred)
        return rmse, mae, r2

    def log_into_mlflow(self):
        try:
            test_data = pd.read_csv(self.config.test_data_path)
            model = joblib.load(self.config.model_path)

            test_x = test_data.drop([self.config.target_column], axis=1)
            test_y = test_data[[self.config.target_column]]
            # logging into MLflow
            print(f"\n - logging into MLflow {self.config.mlflow_uri}")
            mlflow.set_registry_uri(self.config.mlflow_uri)
            tracking_url_type_store = urlparse(
                mlflow.get_tracking_uri()
            ).scheme

            with mlflow.start_run():

                predicted_qualities = model.predict(test_x)

                (rmse, mae, r2) = self.eval_metrics(
                    test_y, predicted_qualities
                )

                # save the mlflow experiment performance
                mlflow.log_params(self.config.all_params)
                mlflow.log_metric("rmse", rmse)
                mlflow.log_metric("r2", r2)
                mlflow.log_metric("mae", mae)

                # Model registry does not work with file store
                if tracking_url_type_store != "file":

                    # Register the model
                    # There are other ways to use the Model Registry,
                    # which depends on the use case,
                    # please refer to the doc for more information:
                    # https://mlflow.org/docs/latest/model-registry.html#api-workflow
                    mlflow.sklearn.log_model(
                        model,
                        artifact_path=self.artifact_path,
                        registered_model_name="ElasticnetModel",
                    )
                else:
                    mlflow.sklearn.log_model(
                        model, artifact_path=self.artifact_path
                    )

                # Get the logged model uri so that we can load it from the
                # artifact store
                model_uri = mlflow.get_artifact_uri(self.artifact_path)
                # show the performance
                print(
                    f"\n\n ---> Model Evaluation Predictions :\
                        \n - model_uri => ( {model_uri} ) \
                        \n - performance:\
                        \n\t - rmse={rmse:.2f}\
                        \n\t - r2={r2:.2f}\
                        \n\t - mae={mae:.2f}]"
                )

                # Saving metrics as local
                scores = {
                    "rmse": rmse,
                    "mae": mae,
                    "r2": r2,
                    "model_uri": model_uri,
                }
                save_json(path=Path(self.config.metric_file_name), data=scores)

        except Exception as e:
            print(
                f"warning: cannot log into mlflow!!\
                \n\t MLflow is skipped because of: \n\t {e}"
            )
