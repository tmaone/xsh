XSHELL_HOME = $(abspath ..)
include $(XSHELL_HOME)/Makefile.inc

JULIA_BASE_SRC=$(sort exports.jl base.jl reflection.jl build_h.jl version_git.jl)

build: clean
	@cp -R $(JULIA_BASE)/ $(XSHELL_HOME)/lib/base
	@ln -s $(XSHELL_HOME)/lib/xshell.jl $(XSHELL_HOME)/lib/base/userimg.jl 
	@export private_libdir=$(private_libdir) JULIA_PKGDIR=$(JULIA_PKGDIR) && \
	$(MAKE) LD_LIBRARY_PATH=$(build_libdir):$(LD_LIBRARY_PATH) JULIA_EXECUTABLE="$(JULIA_BIN)" $(build_private_libdir)/xshell-sys.$(SHLIB_EXT)


update: clean
	@cp -R $(JULIA_BASE)/ $(XSHELL_HOME)/lib/base
	@ln -s $(XSHELL_HOME)/lib/xshell.jl $(XSHELL_HOME)/lib/base/userimg.jl 
	@export private_libdir=$(private_libdir) JULIA_PKGDIR=$(JULIA_PKGDIR) && \
	$(MAKE) LD_LIBRARY_PATH=$(build_libdir):$(LD_LIBRARY_PATH) JULIA_EXECUTABLE="$(JULIA_BIN)" $(build_private_libdir)/xshell-sys.$(SHLIB_EXT)
	
# use sys.ji if it exists, otherwise run two stages
$(build_private_libdir)/xshell-sys%ji: $(build_private_libdir)/xshell-sys%o

.SECONDARY: $(build_private_libdir)/xshell-sys.o
.SECONDARY: $(build_private_libdir)/xshell-sys0.o

$(build_private_libdir)/xshell-sys%$(SHLIB_EXT): $(build_private_libdir)/xshell-sys%o
ifneq ($(USEMSVC), 1)
	@$(call PRINT_LINK, $(CXX) -shared -fPIC -L$(build_private_libdir) -L$(JULIA_LIB) -o $@ $< \
		$$([ $(OS) = Darwin ] && echo '' -Wl,-undefined,dynamic_lookup || echo '' -Wl,--unresolved-symbols,ignore-all ) \
		$$([ $(OS) = WINNT ] && echo '' -ljulia -lssp))
	$(DSYMUTIL) $@
else
	@true
endif

$(build_private_libdir)/xshell-sys0.o:
	@export XSHELL_BUILD=1 JULIA_PKGDIR=$(JULIA_PKGDIR) && \
	@$(call PRINT_XSHELL, cd base && \
	$(call spawn,$(JULIA_BIN)) -C $(JULIA_CPU_TARGET) --build $(call cygpath_w,$(build_private_libdir)/xshell-sys0) sysimg.jl)

BASE_SRCS := $(wildcard base/*.jl base/*/*.jl base/*/*/*.jl)

# $(foreach src,$(BASE_SRCS),$(eval @echo $(src)))

$(build_private_libdir)/xshell-sys.o: $(BASE_SRCS) $(build_private_libdir)/xshell-sys0.$(SHLIB_EXT)
	@export XSHELL_BUILD=1 JULIA_PKGDIR=$(JULIA_PKGDIR) && \
	@$(call PRINT_XSHELL, cd base && \
	$(call spawn,$(JULIA_BIN)) -C $(JULIA_CPU_TARGET) --build $(call cygpath_w,$(build_private_libdir)/xshell-sys) \
		-J$(JULIA_SYSTEM_IMAGE) -f sysimg.jl)

clean:
	@rm -fv $(XSHELL_HOME)/lib/base/userimg.jl 
	@rm -rfv $(build_private_libdir)/xshell-sys*
	@rm -rfv $(XSHELL_HOME)/lib/base

test-sysimage:
	$(call spawn,$(JULIA_BIN)) -J $(build_private_libdir)/xshell-sys.ji


# @export JULIA_PKGDIR=$(JULIA_PKGDIR) && \
# 	$(call spawn,$(JULIA_BIN)) -C $(JULIA_CPU_TARGET) -J$(JULIA_SYSTEM_IMAGE) -f deps.jl
