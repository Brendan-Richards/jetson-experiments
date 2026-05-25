# nvidia-l4t-core	36.4.7-20250918154033

# pin snap version to fix browser issue
# https://forums.developer.nvidia.com/t/chromium-other-browsers-not-working-after-flashing-or-updating-heres-why-and-quick-fix/338891
snap download snapd --revision=24724 && \
	snap ack snapd_24724.assert && \
	sudo snap install snapd_24724.snap && \
	sudo snap refresh --hold snapd

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
