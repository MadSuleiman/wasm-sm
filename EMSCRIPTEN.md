# Emscripten

## Build

```
mkdir build && cd build
emcmake cmake ..
emmake make -j$(nproc)
```

## Add configuration file

`sm.ini` must be copied to `build` directory.

## Link

```
emcc -flto -O3 **/*.o libgl.a -o index.html --shell-file ../shell.html -sUSE_SDL=2 -sENVIRONMENT=web -sINVOKE_RUN=0 --preload-file sm.ini -Wl,-u,fileno -lidbfs.js
```


# Run locally

```
emrun index.html
```

Then open in browser: http://localhost:6931/ and upload `sm.smc`.

