FROM ubuntu:bionic

ARG DEBIAN_FRONTEND=noninteractive
ENV ANDROID_HOME=/opt QEMU_AUDIO_DRV=none TOOLS=${ANDROID_HOME}/tools
ENV PATH=${ANDROID_HOME}:${ANDROID_HOME}/emulator:${TOOLS}:${TOOLS}/bin:${ANDROID_HOME}/platform-tools:${PATH} 

RUN apt update && apt dist-upgrade -y && \
    apt install -y qemu-system curl openjdk-8-jre unzip xauth x11-apps && \
    SDKURL=`curl -s https://developer.android.com/studio | grep --color=never -Eo "http.*sdk-tools-linux.*\.zip"` && \
    mkdir -p /opt && cd /opt && curl -s $SDKURL > android_sdk.zip && unzip android_sdk.zip && rm android_sdk.zip && \
    mkdir -p /root/.android/ && touch /root/.android/repositories.cfg && \
    echo y | /opt/tools/bin/sdkmanager --update >/dev/null && \
    echo y | /opt/tools/bin/sdkmanager "platform-tools" >/dev/null && \
    echo y | /opt/tools/bin/sdkmanager "tools" >/dev/null && \
    echo y | /opt/tools/bin/sdkmanager "build-tools;29.0.2" >/dev/null && \
    echo y | /opt/tools/bin/sdkmanager "platforms;android-29" >/dev/null && \
    echo y | /opt/tools/bin/sdkmanager --channel=4 "emulator" >/dev/null && \
    echo y | /opt/tools/bin/sdkmanager "extras;android;m2repository"  >/dev/null && \
    echo y | /opt/tools/bin/sdkmanager "system-images;android-29;default;x86_64" >/dev/null && \
    echo no | /opt/tools/bin/avdmanager create avd --force --name test --package 'system-images;android-29;default;x86_64'

CMD ["/opt/emulator/emulator", "@test"]

# sudo docker run -it --rm --network host --privileged -v /tmp/.X11-unix/:/tmp/.X11-unix/ -e DISPLAY=$DISPLAY -v $HOME/.Xauthority:/root/.Xauthority bannsec/revenge_testenv_android-29_default_x86_64
