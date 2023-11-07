+++
title = '[OUTDATED/ARCHIVED] Vulkan 3D API Development'
date = 2023-11-06T21:05:57-06:00
draft = true
type = "post"
tags = ["Archive"]
+++

# Outdated Tutorial, for Archival purposes mainly

Page Dedicated to Vulkan API
Here is my guide on booting from a fresh Ubuntu install to a VulkanSDK enabled setup so you can work with the vulkan-tutorial:

This is a rough guide I made while following Vulkan-Tutorial.com, it can be followed using any vulkan compatible Ubuntu Distro but its called 20.04 because thats the version I started on.

This guide will fill in details that I had to discover myself through research and looking through the comments on the tutorial.

I hope it can be useful, I will try to keep it updated. I am currently working on a guide to convert this into an efficient renderer->engine stil in c++.
Comments section may be added later.
Fix Packages Method (use incase of unknown kernel errors) :

```
sudo apt update --fix-missing

sudo apt install -f
```

Step 1: Make sure to set up Sudo-User Priveleges using usermod:

(CHANGE “username” to your username)
```
sudo usermod -aG sudo username 
```

Install all software updates before proceeding with further software installations



How To Check Your Current Kernel Version

At a terminal window, type:

`uname –rs`

The terminal returns something like:

`Linux 5.5.0-64 generic`


Follow these steps to update kernel: (repeat sometimes)

```
sudo apt-get update


sudo apt-get dist-upgrade
```

Install Brave Browser(or browser of choice)

```
sudo apt install apt-transport-https curl

curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add -

echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list

sudo apt update

sudo apt install brave-browser
```

(If you get gnutls_handshake() errors after adding the Brave repository on Debian 9, you may need to uninstall old conflicting packages.)


Download and install amd-vulkan gpu drivers (rx570 drivers for me)

https://www.amd.com/en/support/graphics/radeon-500-series/radeon-rx-500-series/radeon-rx-570


WARNING, if you are on an AMD 6000 GPU the usual install for drivers may not be working. See this blogpost for details on installing for 6000 series: https://forum.level1techs.com/t/ubuntu-20-10-rx-6800-xt-how-to-steam-vulkan-up-and-runing-guide-wip/164137

Upgrade GPU Open-GL Drivers:


`sudo add-apt-repository ppa:oibaf/graphics-drivers`


Use this to get essential packages like make:



`sudo apt-get install build-essential`

Install Cmake:

```
sudo apt-get install cmake


sudo apt-get install git python cmake
```


Vulkan Package Installation:

```
sudo apt-get install vulkan-utils mesa-vulkan-drivers


sudo apt-get install libxcb1-dev libx11-dev libxrandr-dev libwayland-dev


wget -qO - https://packages.lunarg.com/lunarg-signing-key-pub.asc | sudo apt-key add -

sudo wget -qO /etc/apt/sources.list.d/lunarg-vulkan-focal.list https://packages.lunarg.com/vulkan/lunarg-vulkan-focal.list



sudo apt update
sudo apt install vulkan-sdk
sudo apt update
```

(check for upgrades if any do sudo apt-get upgrade)

Use these commands to ensure all needed packages were installed, they will either intall them or return as already installed:


```
sudo apt install vulkan-tools: Command-line utilities, most importantly vulkaninfo and vkcube. Run these to confirm your machine supports Vulkan.

sudo apt install libvulkan-dev: Installs Vulkan loader. The loader looks up the functions in the driver at runtime, similarly to GLEW for OpenGL - if you're familiar with that.

sudo apt install vulkan-validationlayers-dev: Installs the standard validation layers. These are crucial when debugging Vulkan applications.
```


verify VulkanSDK installation:


vkvia - Will Analyze your installation

vulkaninfo - Will display info about installation

vkcube - Runs a Spinning Cube Test Vulkan Window



setting VK_INSTANCE_LAYERS variable


` export VK_INSTANCE_LAYERS=VK_LAYER_KHRONOS_validation:VK_LAYER_LUNARG_gfxreconstruct`

Install XORG-Dev packages:

`sudo install xorg-dev`

Installing GLFW – OpenGL LinuxNative window creation tool


`sudo apt install libglfw3-dev`

Installing GLM – Linear Algebra Library


`sudo apt install libglm-dev`


Download the gcc or clang(if gcc doesn’t work when compiling use clang) shadercompiler off this unofficial github repo:

https://github.com/google/shaderc/blob/main/downloads.md


Move the file “glslc” to usr/local/bin with sudo permissions


Go to downloads folder, extract the install tgz file, open the extracted folder, navigate to bin, rightclick the folder and select open in terminal.


Move the file with the following shell command:

`sudo mv glslc /usr/local/bin`


At this point install your IDE’s of choice. Mine are notepad++, VSCODE, and Sublime Text.


Then Restart Ubuntu after running sudo apt update and sudo apt upgrade if you need to upgrade any packages.



AVOID USING THE SNAP STORE(it sucks) but I had to when I started so no shame in learning WHY it sucks( i guess)

If your snap store/ software installer is running an error then go to system monitor, search for snap store and hit end process. It happens usually before or during an update and shouldn’t happen after restarted like this.


Ready to set up Vulkan-Tutorial



If you are re-installing and continuing tutorial or project you might want to verify your vulkan installation by setting up the test environment from vulkan-tutorial.com .



WHEN SETTING UP THE MAKEFILE DO IT IN VIM OR ELSE YOU WILL GET A WARNING ABOUT SPACES INSTEAD OF TABS


Use this simple Vim tutorial to help type out the makefile from scratch, to avoid previously suggested error: https://www.cyberciti.biz/faq/vim-new-file-creation-command-on-linux-unix/


When RUNNING a make file with kernel command “make” ubuntu would not find it in the correct directory. To specify the makefile run :


`make -f makefile.mak`


You can also run the test with:


`make -f makefile.make test`


Configuring VSCode to run your executable from the VSCode debugger:


In the launch.json configure the “program” entry to take the filepath of your executable like “program”: “${workspaceFolder}/VulkanTest”,


Debug from GDB c++ Launch


In c_cpp_properties.json use cStandard gnu17 and cppStandard c++17 compilerpath “/usr/bin/gcc” DONT CHANGE THESE IF YOU DONT NEED TO.


After updating vscode intellisense4 IntellisenseMode should be “gcc-x64”


Compile the shaders with compile.sh file by dragging it into terminal and entering it(possibly need sudo permission). Make sure referencing local glslc in the compile file and referencing the entire file path name to the shaders if the bash reports those files don’t exist or cannot be found.


Held up at descriptor sets part, make sure rasterizer.frontface is COUNTER clockwise not clockwise


Add stb_image.h to your include folder(or where your glfw and glm are):


`sudo mv stb_image.h /usr/include`


Same with tinyobj loader:


`sudo mv tiny_obj_loader.h /usr/include`



makefile paths and updated cflags:s

```
VULKAN_SDK_PATH = /usr/share/doc


STB_INCLUDE_PATH = /usr/include


TINYOBJ_INCLUDE_PATH = /home/user/libraries/tinyobjloader


CFLAGS = -std=c++17 -O2 -I$(VULKAN_SDK_PATH)/include -I$(STB_INCLUDE_PATH) -I$(TINYOBJ_INCLUDE_PATH)
```

LOADING MODELS:


ADD THIS AFTER 
```
return attributeDescriptions;

} 
```
in 
```
struct Vertex:



bool operator==(const Vertex& other) const

{

return pos == other.pos && color == other.color && texCoord == other.texCoord;

}
```


This line of code is referenced at the end of the tutorial but is needed for the initial test or else will generate a compiler error:

```
namespace std

{

template<> struct hash<Vertex>

{

size_t operator()(Vertex const& vertex) const

{

return ((hash<glm::vec3>()(vertex.pos) ^ (hash<glm::vec3>()(vertex.color) << 1)) >> 1) ^ (hash<glm::vec2>()(vertex.texCoord) << 1);

}

};

}
```


GOES ABOVE

```
struct UniformBufferObject
```


