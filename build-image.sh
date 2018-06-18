#!/bin/bash

echo ""

echo -e "\nbuild docker hadoop image\n"
sudo docker build -t orozcohsu/cluster-hadoop:v1 .

echo ""
