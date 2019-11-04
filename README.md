Android x86_64 API27 image for testing `revenge`.

Run with:

```bash
sudo docker run -it --rm --network host --privileged -v /tmp/.X11-unix/:/tmp/.X11-unix/ -e DISPLAY=$DISPLAY -v $HOME/.Xauthority:/root/.Xauthority bannsec/revenge_testenv_android-27_default_x86_64
```
