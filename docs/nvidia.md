

### Remove any previous installation of nvidia software

sudo apt-get --purge -y remove 'nvidia*'
sudo apt-get --purge -y remove 'cuda*'
sudo reboot

### Search for latest drivers on current distribution 

apt search nvidia-driver


### Install Linux Proprietary GPU Drivers [Link](https://launchpad.net/~graphics-drivers/+archive/ubuntu/ppa)

sudo add-apt-repository ppa:graphics-drivers/ppa
sudo apt-get update
sudo apt install nvidia-driver-XXX

> Where XXX is replaced with the driver version 


### eGPU: Enable Thunderbolt [Link](https://www.kernel.org/doc/html/v4.15/admin-guide/thunderbolt.html)

boltctl list
boltctl authorize XXX

> Where XXX is replaced with the uuid of the connected peripheral device  

### Reboot

sudo reboot


### Checking driver and CUDA version [Compatibility](https://docs.nvidia.com/deploy/cuda-compatibility/index.html)

Be aware that the CUDA VERSION displayed by nvidia-smi associated with newer drivers is the DRIVER API COMPATIBILITY VERSION. It does not indicate anything at all about what CUDA version is actually installed. For example: A 410.72 driver will display CUDA VERSION 10.0 even when no CUDA toolkit is installed. 

CUDA version can be checked with `nvcc --version`
If nothing shows up install the CUDA toolkit


### Installing CUDA toolkit [Link](https://developer.nvidia.com/cuda-toolkit-archive)

After following the install directions in the link above we need to follow the [Post-installation Actions](https://docs.nvidia.com/cuda/cuda-installation-guide-linux/index.html#post-installation-actions). Some actions must be taken after the installation before the CUDA Toolkit and Driver can be used.
> Note: `nvcc --version` will not work yet since it is not on the path. 

export PATH=/usr/local/cuda-XXX/bin${PATH:+:${PATH}}
> Where XXX is replaced with the cuda toolkit version i.e. 11.3 
> Note: add this line to your shell e.g. bashrc, zshrc ... to add to the PATH each terminal startup

Verify with `echo $PATH`






