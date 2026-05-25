
sudo apt update && sudo apt install -y \
	nvidia-l4t-gstreamer \
	nvidia-l4t-multimedia \
	gstreamer1.0-tools \
	gstreamer1.0-plugins-base \
	gstreamer1.0-plugins-good \
	gstreamer1.0-plugins-bad \
	gstreamer1.0-plugins-ugly \
	htop \
	nvtop
	
# install docker and nvidia-docker
sudo apt update && sudo apt install -y docker.io nvidia-container-toolkit && \
	sudo nvidia-ctk runtime configure --runtime=docker && \
	sudo systemctl enable docker && \
	sudo systemctl start docker && \
	sudo usermod -aG docker $USER


# docker run --network host --runtime nvidia nvcr.io/nvidia/l4t-base:r36.2.0 nvidia-smi

# test dual cams
gst-launch-1.0 \
  nvcompositor name=comp \
    sink_0::xpos=0 \
    sink_0::ypos=0 \
    sink_0::width=1280 \
    sink_0::height=720 \
    sink_1::xpos=1280 \
    sink_1::ypos=0 \
    sink_1::width=1280 \
    sink_1::height=720 \
  ! 'video/x-raw(memory:NVMM),width=2560,height=720,framerate=30/1' \
  ! nvvidconv \
  ! xvimagesink sync=false \
  nvarguscamerasrc sensor-id=0 \
  ! 'video/x-raw(memory:NVMM),width=1280,height=720,framerate=30/1' \
  ! comp.sink_0 \
  nvarguscamerasrc sensor-id=1 \
  ! 'video/x-raw(memory:NVMM),width=1280,height=720,framerate=30/1' \
  ! comp.sink_1
