#/bin/bash
. .env

if [[ $# -eq 0  ]]; then
    echo && echo "###### production demo: run project use case ###### " && echo
    #----------------------------------------------------------------
    ##### production demo: run project use case
    #-1: build the docker image
    bash bash/1-build.sh

    #-2: run the project container
    bash bash/3-run.sh

elif [[ $1 ==  "dev"  ]]; then
    echo && echo "###### development: trained the model  ###### " && echo

    #----------------------------------------------------------------
    ##### development: trained the model
    #-1: build the docker image
    bash bash/1-build.sh

    #-2: run mlops servers such as mlflow
    bash bash/2-run-mlops-servers.sh

    #-1: run the dev container
    bash bash/dev/dev.sh

elif [[ $1 ==  "predict"  ]]; then
    echo && echo "###### model predictions: trained model  infeence ###### " && echo

    #----------------------------------------------------------------
    ##### model predictions: trained model  infeence
    bash bash/run/run_inference.sh


else
    echo " error: undefined argument(s) : < $@ > !!"
    echo && echo "Please use dev argument or without arguments to run hte use case " && echo
    echo "###### Unusual Exit!  ###### " && echo

fi