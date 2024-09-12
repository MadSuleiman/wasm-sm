TARGET_EXEC:=sm.html

SRCS:=$(wildcard src/*.c src/snes/*.c) third_party/gl_core/gl_core_3_1.c
OBJS:=$(SRCS:%.c=%.o)

PYTHON:=/usr/bin/env python3
CFLAGS:=$(if $(CFLAGS),$(CFLAGS),-O2 -fno-strict-aliasing -Werror )
CFLAGS:=${CFLAGS} -DSYSTEM_VOLUME_MIXER_AVAILABLE=0 -sUSE_SDL=2 -I.

ifeq (${OS},Windows_NT)
    WINDRES:=windres
#    RES:=sm.res
    SDLFLAGS:=-Wl,-Bstatic $(shell sdl2-config --static-libs)
else
    SDLFLAGS:=$(shell sdl2-config --libs) -lm
endif

.PHONY: all clean clean_obj

all: $(TARGET_EXEC)
$(TARGET_EXEC): $(OBJS) $(RES)
	$(CC) $^ -o $@ $(LDFLAGS) $(SDLFLAGS) -sALLOW_MEMORY_GROWTH=1 -sWASM=1 -sINVOKE_RUN=0 -sENVIRONMENT=web -sEXPORTED_RUNTIME_METHODS="['FS','ccall','cwrap']" -sFILESYSTEM=1 -sFORCE_FILESYSTEM=1 -lidbfs.js  --embed-file sm.smc --embed-file sm.ini --shell-file shell.html

%.o : %.c
	$(CC) -c $(CFLAGS) $< -o $@

#$(RES): src/platform/win32/sm.rc
#	@echo "Generating Windows resources"
#	@$(WINDRES) $< -O coff -o $@

clean: clean_obj
clean_obj:
	@$(RM) $(OBJS) $(TARGET_EXEC)
