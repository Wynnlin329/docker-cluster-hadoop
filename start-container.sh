#!/bin/bash

# the default node number is 3
N=${1:-3}


# start hadoop master container
sudo docker rm -f master &> /dev/null
echo "start master container..."
sudo docker run -itd \
                --net=hadoop \
                -p 50070:50070 \
                -p 8088:8088 \
                --name master \
                --hostname master \
                orozcohsu/cluster-hadoop:v1 &> /dev/null


# start hadoop slaver container
i=1
while [ $i -lt $N ]
do
	sudo docker rm -f slaver$i &> /dev/null
	echo "start slaver$i container..."
	sudo docker run -itd \
	                --net=hadoop \
	                --name slaver$i \
	                --hostname slaver$i \
	                orozcohsu/cluster-hadoop:v1 &> /dev/null
	i=$(( $i + 1 ))
done 

# get into hadoop master container
sudo docker exec -it master bash
