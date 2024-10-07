# crYOLO & napari Container Guide

This guide will walk you through downloading and running a pre-configured Docker container that contains both **crYOLO** and **napari**. This container allows you to use crYOLO either via the **Command Line Interface (CLI)** or through the **napari Graphical User Interface (GUI)**.

## Prerequisites

BizonOS - v2.0 and up 

## Step 1: Download the Docker Container

To download the crYOLO container from Docker Hub, run the following command in your terminal:

```
docker pull gimel12/cryolo:latest
```
This will download the container from Docker Hub to your local system.

## Step 2: Run the Container
You can run the container in two ways depending on whether you want to use the napari GUI or the crYOLO CLI. Follow the appropriate instructions below.

### Option 1: Run crYOLO CLI (Command Line Interface)
If you prefer to use crYOLO from the command line for tasks like particle picking and model training, follow these steps:

Run the container:

```
docker run --gpus all -it gimel12/cryolo:latest
```
Once inside the container, activate the crYOLO environment:

```
conda activate cryolo
```
You can now run crYOLO commands like:

```
cryolo_predict.py --help
```
This will display the available options for crYOLO. You can use this to process your images directly from the command line.

### Option 2: Run napari GUI
If you prefer to use the napari GUI for an easier, visual interface for cryo-EM data analysis, follow these steps:

Before running the container, you need to enable X11 forwarding on your system. Run this command to allow Docker to use your display:

```
xhost +local:docker
```
Run the container with the appropriate display forwarding options:

```
docker run -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix --gpus all -it gimel12/cryolo:latest
```
Once inside the container, activate the napari environment:

```
conda activate napari-cryolo
```
### Launch napari to access the GUI:

```
napari
```
You should now see the napari graphical interface open, and you can use it to visually interact with your cryo-EM data and crYOLO particle picking.

## Additional Information
crYOLO CLI is ideal for users who are comfortable with the command line and prefer to automate processes or work with large datasets.
napari GUI is perfect for users who prefer a visual, interactive environment for their data analysis and particle picking.

## Adding folders from your machine inside the container

We map our home folder to be shown inside the container so we can easily access our data.
```
docker run -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v /home/bizon:/home/bizon --gpus all -it gimel12/cryolo:latest
```

## Video Tutorial

Watch the full video tutorial on how to use the crYOLO & napari Docker container:

[![Watch the video](https://img.youtube.com/vi/3f8480b917764426a529ebd281750d30/0.jpg)](https://www.loom.com/share/3f8480b917764426a529ebd281750d30?sid=d5206999-fe40-4020-97b2-14482328ced0)


## Troubleshooting
Check GUI apps can be displayed inside the container:

```
xeyes
```
If you see a pair of eyes pop up on your screen, X11 forwarding is working correctly.
