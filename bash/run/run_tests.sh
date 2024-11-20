#!/bin/bash
clear
echo && echo " #################################################" 
echo " ##         REGRESSION PROJECT           " 
echo " ## Run code tests "
echo " #################################################" && echo 
pip install pytest-cov
clear

#--------------------------------------------------------
echo && echo " -> measure  tests coverage report"
pytest --cov=src/ tests/ --verbose --durations=5 -vv --cov-report term-missing --cov-fail-under 60 


#### ----------------   NOTIFICATION MESSAGE -------------------------
# notify-send "Execution Finished!!"