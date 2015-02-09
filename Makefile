XSH_HOME = $(abspath .)
include $(XSH_HOME)/Makefile.in

all: default
ifeq ($(DEBUG), 1)
default: debug
else
default: release
endif

# sort is used to remove potential duplicates
BUILD_DIRS = $(sort $(build_prefix) $(build_bindir) $(build_libdir) $(build_private_libdir) $(build_includedir) $(build_sysconfdir) $(build_datarootdir) $(build_docdir) $(build_man1dir))

$(foreach dir,$(BUILD_DIRS),$(eval $(call dir_target,$(dir))))

debug release: | $(BUILD_DIRS) $(build_sysconfdir)/xshrc
	@$(MAKE) $(QUIET_MAKE) xsh-$@

xsh-debug xsh-release:
	# @$(MAKE) $(QUIET_MAKE) -C deps
	# @$(MAKE) $(QUIET_MAKE) -C lib$@
	# @$(MAKE) $(QUIET_MAKE) -C src $@
	@$(MAKE) $(QUIET_MAKE) $@-symlink

xsh-debug-symlink:
	@ln -sf $(XSH_EXECUTABLE_DEBUG) xsh

xsh-release-symlink:
	@ln -sf $(XSH_EXECUTABLE_RELEASE) xsh

$(build_sysconfdir)/xshrc:
	@cp $< $@







	# @export private_libdir=$(private_libdir) && \
	# $(MAKE) $(QUIET_MAKE) LD_LIBRARY_PATH=$(build_libdir):$(LD_LIBRARY_PATH) JULIA_EXECUTABLE="$(JULIA_EXECUTABLE_$@)" $(build_private_libdir)/sys.$(SHLIB_EXT)

# all: detect-julia

# init: $(BUILD_DIRS)
# 	@$(MAKE) $(QUIET_MAKE) -C deps getall

# build: init
# 	@$(MAKE) $(QUIET_MAKE) -C deps default
# 	@$(MAKE) $(QUIET_MAKE) -C lib build
# 	@$(MAKE) $(QUIET_MAKE) -C src build

# release: build

# update: init git-submodules-update
# 	@$(MAKE) $(QUIET_MAKE) -C deps update
# 	@$(MAKE) $(QUIET_MAKE) -C lib build

# install: release $(INSTALL_DIRS)

# clean:
# 	@$(MAKE) $(QUIET_MAKE) -C deps cleanall
# 	@rm -rfv $(build_prefix)
# 	@rm -rfv $(prefix)

# distclean: clean
# 	@$(MAKE) $(QUIET_MAKE) -C deps distcleanall
# 	@rm -rfv ${XSHELL_HOME}/xshell-*

# deps:
# 	@$(MAKE) $(QUIET_MAKE) -C deps @


# devel-sys:
# 	@export JULIA_PKGDIR=$(JULIA_PKGDIR) && \
# 	$(call spawn,$(JULIA_BIN)) -C $(JULIA_CPU_TARGET) -J$(JULIA_SYSTEM_IMAGE) 

# devel-sys-xshell:
# 	@export JULIA_PKGDIR=$(JULIA_PKGDIR) && \
# 	$(call spawn,$(JULIA_BIN)) -C $(JULIA_CPU_TARGET) -J$(JULIA_SYSTEM_IMAGE) $(XSHELL_HOME)/lib/xshell.jl

# devel-xshell:
# 	@export JULIA_PKGDIR=$(JULIA_PKGDIR) && \
# 	$(call spawn,$(JULIA_BIN)) -C $(JULIA_CPU_TARGET) -J$(XSHELL_SYSTEM_IMAGE) $(XSHELL_HOME)/lib/xshell.jl

# devel:
# 	@export JULIA_PKGDIR=$(JULIA_PKGDIR) && \
# 	$(call spawn,$(JULIA_BIN)) -C $(JULIA_CPU_TARGET) -J$(XSHELL_SYSTEM_IMAGE)

# all: 
# 	# @echo $(IS_GIT)
# 	# @echo $(JULIA) 
# 	# @echo $(USE_SYSTEM_JULIA) 
# 	# @echo $(XSH_VER) 
# 	# @echo $(XSH_COMMIT) 

# .PHONY: all
