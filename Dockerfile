FROM aminueza/docker-sgx

RUN apt-get update

USER root
#Hello World App
WORKDIR /home/sgx/app
RUN git clone -b hello-world https://amandasouza:BF5-ZUGPZFzyjF9cs7_X@git.lsd.ufcg.edu.br/secure-cloud/sgx-apps.git hello-world
WORKDIR /home/sgx/app/hello-world 
RUN SGX_MODE=HW SGX_DEBUG=1 make
RUN printf "#!/bin/bash\n/opt/intel/sgxpsw/aesm/aesm_service &\nsleep 1s\ncd /home/sgx/app/hello-world/\n./app_final" > ~/run.sh && \
    chmod +x ~/run.sh

#Simple Remote Attestation App
#WORKDIR /home/sgx/app
#RUN git clone -b remote-attestation-sample https://amandasouza:BF5-ZUGPZFzyjF9cs7_X@git.lsd.ufcg.edu.br/secure-cloud/sgx-apps.git remote-attestation-sample
#WORKDIR /home/sgx/app/remote-attestation-sample
#RUN SGX_MODE=HW SGX_DEBUG=1 make
#RUN printf "#!/bin/bash\n/opt/intel/sgxpsw/aesm/aesm_service &\nsleep 1s\ncd /home/sgx/app/remote-attestation-sample/\n./app_final" > ~/run.sh && \
#    chmod +x ~/run.sh

#Sac2017 App
#WORKDIR /home/sgx/app
#RUN git clone -b sac2017 https://amandasouza:BF5-ZUGPZFzyjF9cs7_X@git.lsd.ufcg.edu.br/secure-cloud/sgx-apps.git sac2017
#WORKDIR /home/sgx/app/sac2017/Aggregator
#RUN SGX_MODE=HW SGX_DEBUG=1 make
#RUN printf "#!/bin/bash\n/opt/intel/sgxpsw/aesm/aesm_service &\nsleep 1s\ncd /home/sgx/app/sac2017/Aggregator\n./aggregator" > ~/run.sh && \
#    chmod +x ~/run.sh

#WORKDIR /home/sgx/app/sac2017/SmartMeter
#RUN SGX_MODE=HW SGX_DEBUG=1 make
#RUN printf "#!/bin/bash\n/opt/intel/sgxpsw/aesm/aesm_service &\nsleep 1s\ncd /home/sgx/app/sac2017/Aggregator\n./smart-meter" > ~/run.sh && \
#    chmod +x ~/run.sh

#Simple Remote Attestation App
#WORKDIR /home/sgx/app
#RUN git clone -b remote-attestation https://amandasouza:BF5-ZUGPZFzyjF9cs7_X@git.lsd.ufcg.edu.br/secure-cloud/sgx-apps.git remote-attestation
#WORKDIR /home/sgx/app/remote-attestation/SP
#RUN cp -r /home/sgx/drivers/restbed/build/librestbed.so* .
#RUN make SGX_MODE=HW SGX_DEBUG=1 RESTBED_PATH=/home/sgx/drivers/restbed
#RUN printf "#!/bin/bash\n/opt/intel/sgxpsw/aesm/aesm_service &\nsleep 1s\ncd /home/sgx/app/remote-attestation/SP\n./service-provider" > ~/run.sh && \
#    chmod +x ~/run.sh

#Simple Remote Attestation App
#WORKDIR /home/sgx/app
#RUN git clone -b remote-attestation https://amandasouza:BF5-ZUGPZFzyjF9cs7_X@git.lsd.ufcg.edu.br/secure-cloud/sgx-apps.git remote-attestation
#WORKDIR /home/sgx/app/remote-attestation/Client
#RUN cp -r /home/sgx/drivers/restbed/build/librestbed.so* .
#RUN make SGX_MODE=HW SGX_DEBUG=1 RESTBED_PATH=/home/sgx/drivers/restbed
#RUN printf "#!/bin/bash\n/opt/intel/sgxpsw/aesm/aesm_service &\nsleep 1s\ncd /home/sgx/app/remote-attestation/Client\n./client" > ~/run.sh && \
#    chmod +x ~/run.sh
	
CMD ~/run.sh
