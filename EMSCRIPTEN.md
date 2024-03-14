# Emscripten

## Build

```
mkdir build && cd build
emcmake cmake ..
emmake make
```

## Link

```
em++ -flto -O3 *.o libgl.a -o index.html -sUSE_SDL=2 -sENVIRONMENT=web --preload-file sm.smc --preload-file sm.ini -Wl,-u,fileno 
```


