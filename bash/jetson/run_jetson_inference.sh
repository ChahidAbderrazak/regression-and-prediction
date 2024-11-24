#!/bin/bash
clear
echo && echo " #################################################" 
echo " ##         REGRESSION INFERENCE  [Jetson]         " 
echo " #################################################" && echo 


#--------------------------------------------------------
echo && echo "###### Model inference ..."
python3 src/inference.py

# # #### inference Image
# root=artifacts/inference/OBJ-processed-dataset_aquash-monitoring-ADP-dev/FasterRCNN_ResNet50
# python3 ./src/inference.py   --model_path  $root/model/model.pth \
#                            --info $root/model/model_info.json \
#                            --data_source 	$root/data \
#                            --prediction_dst $root/predictions \
#                            --plot 1

# # #### inference Image
# root=artifacts/inference/aquash-monitoring-ADP/FasterRCNN_ResNet50
# python3 ./src/inference.py   --model_path  $root/model/model.pth \
#                            --info $root/model/model_info.json \
#                            --data_source 	$root/data \
#                            --prediction_dst $root/predictions \
#                            --plot 1



# #### inference Video
# root=artifacts/inference/OBJ-processed-dataset_aquash-monitoring-ADP-dev/FasterRCNN_ResNet50
# python3 ./src/inference.py   --model_path  $root/model/model_cuda.pth \
#                            --info $root/model/model_info.json \
#                            --data_source 	$root/videos/Sampling_08-03-2021--11h42min54sec.avi \
#                            --prediction_dst $root/predictions \
#                            --plot 0


#### ----------------   NOTIFICATION MESSAGE -------------------------
# notify-send "Execution Finished!!"