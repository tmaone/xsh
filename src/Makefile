XSHELL_HOME = $(abspath ..)
include $(XSHELL_HOME)/Makefile.inc

override CFLAGS += $(JCFLAGS)
override CXXFLAGS += $(JCXXFLAGS)
override CPPFLAGS += $(JCPPFLAGS)

SRCS = xshell

FLAGS = -I$(JULIA_INCLUDE)
ifneq ($(USEMSVC), 1)
FLAGS += -Wall -Wno-strict-aliasing -fno-omit-frame-pointer
endif

OBJS = $(SRCS:%=%.o)
DOBJS = $(SRCS:%=%.dbg.obj)
DEBUGFLAGS += $(FLAGS)
SHIPFLAGS += $(FLAGS)
ifeq ($(USE_LLVM_SHLIB),1)
LLVMLINK = $(call exec,$(LLVM_CONFIG) --ldflags) -lLLVM-$(call exec,$(LLVM_CONFIG) --version)
else
LLVMLINK =
endif

# JLDFLAGS += $(LDFLAGS) $(NO_WHOLE_ARCHIVE) $(OSLIBS) $(LLVMLINK) $(RPATH)
JLDFLAGS += $(LDFLAGS) $(NO_WHOLE_ARCHIVE) $(OSLIBS) $(LLVMLINK)

ifeq ($(USE_SYSTEM_LIBM),0)
ifneq ($(UNTRUSTED_SYSTEM_LIBM),0)
JLDFLAGS += $(WHOLE_ARCHIVE) $(build_libdir)/libopenlibm.a $(NO_WHOLE_ARCHIVE)
endif
endif

ifeq ($(OS),WINNT)
JLDFLAGS += -municode
endif

release debug:
	$(MAKE) xsh-$@

%.o: %.c
	@$(call PRINT_CC, $(CC) $(CPPFLAGS) $(CFLAGS) $(SHIPFLAGS) -c $< -o $@)
%.dbg.obj: %.c
	@$(call PRINT_CC, $(CC) $(CPPFLAGS) $(CFLAGS) $(DEBUGFLAGS) -c $< -o $@)

xsh-release: $(build_bindir)/xsh$(EXE)
xsh-debug: $(build_bindir)/xsh-debug$(EXE)

ifneq ($(USEMSVC), 1)
CXXLD = $(CXX)
else
CXXLD = $(LD)
endif

$(build_bindir)/xsh$(EXE): $(OBJS)
	@$(call PRINT_LINK, $(CXXLD) $(CXXLDFLAGS) $(LINK_FLAGS) $(SHIPFLAGS) $^ -o $@ -L$(build_private_libdir) -L$(JULIA_LIB) -L$(build_shlibdir) -ljulia -lxshell-sys $(JLDFLAGS) $(CXXLDFLAGS))
$(build_bindir)/xsh-debug$(EXE): $(DOBJS)
	@$(call PRINT_LINK, $(CXXLD) $(CXXLDFLAGS) $(LINK_FLAGS) $(DEBUGFLAGS) $^ -o $@ -L$(build_private_libdir) -L$(JULIA_LIB) -L$(build_shlibdir) -ljulia -lxshell-sys $(JLDFLAGS) $(CXXLDFLAGS))

clean: | $(CLEAN_TARGETS)
	rm -f *.o *.dbg.obj
	rm -f $(build_bindir)/xsh*

.PHONY: clean release debug xsh-release xsh-debug


build: release
	-echo "done"
