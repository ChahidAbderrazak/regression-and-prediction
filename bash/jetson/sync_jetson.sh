START=$(date +%s)
project_folder=${PWD##*/}
project_folder=${project_folder:-/}

##########################################################################
echo && echo " ##########################################################" 
echo " ##     SYNC THE JETSON NANO [${project_folder}]            " 
echo " ##########################################################" && echo  


echo && echo  " ---> Sending [${project_folder}] files to the Jetson..." 
rsync -azP ../$project_folder jetson@10.0.0.163:/home/jetson/mlcodes/   

echo && echo  " ---> Receiveing [${project_folder}] files from the Jetson..." 
rsync -azP ../$project_folder  jetson@10.0.0.163:/home/jetson/mlcodes/   


# 
# #------------- CLEAN THE CODE -------------
# ./bash/run/run_clean_build_files.sh