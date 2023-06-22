#Copyright 2019 Motion Signal Technologies 
#
#Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
#
#1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
#
#2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
#
#3. Neither the name of the copyright holder nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
#
#THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


FROM ubuntu:18.04


RUN apt-get update \
    && apt-get install -y --no-install-recommends  \
      libxaw7-dev freeglut3-dev libnetpbm10-dev libgd-dev libplplot-dev \
	  libavcodec-dev libcairo2-dev libjpeg-dev swig python-dev python-numpy g++ gfortran \
	  libopenmpi-dev libfftw3-dev libsuitesparse-dev python-epydoc scons \
	  git wget ca-certificates openssl \
	&& git clone https://github.com/ahay/src /madagascar-src \
    && cd /madagascar-src \
    && ./configure API=c++,python --prefix=/usr/local \
    && make install \
    && rm -r /madagascar-src \
	&& echo "\n" >> ~/.bashrc \
    && echo "source /usr/local/share/madagascar/etc/env.sh" >> ~/.bashrc \
    && echo "\n" >> ~/.bashrc \
    && apt-get remove -y \
       python-epydoc scons swig g++ gfortran \
       git wget ca-certificates openssl \
    && rm -rf /var/lib/apt/lists \
    && apt-get autoremove -y \
    && apt-get autoclean -y

    

ENTRYPOINT ["/bin/bash"]



#