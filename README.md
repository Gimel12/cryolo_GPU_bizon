# crYOLO & napari Container Guide

This guide will walk you through downloading and running a pre-configured Docker container that contains both **crYOLO** and **napari**. This container allows you to use crYOLO either via the **Command Line Interface (CLI)** or through the **napari Graphical User Interface (GUI)**.

## Prerequisites

Before you begin, ensure you have the following installed on your system:

1. **Docker**: If you don't have Docker installed, you can download it from here: [https://docs.docker.com/get-docker/](https://docs.docker.com/get-docker/).
2. **X11 Server** (for GUI usage):
   - On **Linux**, X11 is typically pre-installed.
   - On **macOS**, you'll need to install [XQuartz](https://www.xquartz.org/).
   - On **Windows**, you'll need to install [VcXsrv](https://sourceforge.net/projects/vcxsrv/).

## Step 1: Download the Docker Container

To download the crYOLO container from Docker Hub, run the following command in your terminal:

```
docker pull gimel12/cryolo:latest
```
This will download the container from Docker Hub to your local system.

Step 2: Run the Container
You can run the container in two ways depending on whether you want to use the napari GUI or the crYOLO CLI. Follow the appropriate instructions below.

Option 1: Run crYOLO CLI (Command Line Interface)
If you prefer to use crYOLO from the command line for tasks like particle picking and model training, follow these steps:

Run the container:

bash
Copy code
docker run --gpus all -it gimel12/cryolo:latest
Once inside the container, activate the crYOLO environment:

bash
Copy code
conda activate cryolo
You can now run crYOLO commands like:

bash
Copy code
cryolo_predict.py --help
This will display the available options for crYOLO. You can use this to process your images directly from the command line.

Option 2: Run napari GUI
If you prefer to use the napari GUI for an easier, visual interface for cryo-EM data analysis, follow these steps:

Before running the container, you need to enable X11 forwarding on your system. Run this command to allow Docker to use your display:

bash
Copy code
xhost +local:docker
Run the container with the appropriate display forwarding options:

bash
Copy code
docker run -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix --gpus all -it gimel12/cryolo:latest
Once inside the container, activate the napari environment:

bash
Copy code
conda activate napari-cryolo
Launch napari to access the GUI:

bash
Copy code
napari
You should now see the napari graphical interface open, and you can use it to visually interact with your cryo-EM data and crYOLO particle picking.

Additional Information
crYOLO CLI is ideal for users who are comfortable with the command line and prefer to automate processes or work with large datasets.
napari GUI is perfect for users who prefer a visual, interactive environment for their data analysis and particle picking.
Troubleshooting
If you're using macOS or Windows, make sure that your X11 server (like XQuartz or VcXsrv) is running before you launch the container. You can test your X11 forwarding by running the following command in the container:

bash
Copy code
xeyes
If you see a pair of eyes pop up on your screen, X11 forwarding is working correctly.
