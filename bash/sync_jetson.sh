START=$(date +%s)
##########################################################################
echo && echo " #################################################" 
echo " ##              SYNC THE JETSON NANO            " 
echo " #################################################" && echo  


echo && echo  " ---> Sending  files to the Jetson..." 
rsync -azP ../Edge-device-inference  jetson@10.0.0.163:/home/jetson/mlcodes/   


# echo && echo  " ---> Receiving files from Jetson..." 
# rsync -azP  jetson@10.0.0.163:/home/jetson/mlcodes/Edge-device-inference   ../


#echo && echo  " ---> Receiving files from Jetson :  $1 " 
#rsync -azP jetson@10.0.0.163:/home/jetson/mlcodes/$1 .   

# #------------- CLEAN THE CODE -------------
# ./bash/run/run_clean_build_files.sh

