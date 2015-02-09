XSHELL_HOME = $(abspath ..)
include Versions.make
include $(XSHELL_HOME)/Makefile.inc

# If the top-level Makefile is called with environment variables,
# they will override the values passed above to ./configure
MAKE_COMMON = DESTDIR="" prefix=$(build_prefix) bindir=$(build_bindir) libdir=$(build_libdir) libexecdir=$(build_libexecdir) datarootdir=$(build_datarootdir) includedir=$(build_includedir) sysconfdir=$(build_sysconfdir)

DEPS = julia julia-deps

## Common build target prefixes

DEP_LIBS = $(DEPS)

default: $(build_prefix) install
get: $(addprefix get-, $(DEP_LIBS))
update: $(addprefix update-, $(DEP_LIBS))
configure: $(addprefix configure-, $(DEP_LIBS))
compile: $(addprefix compile-, $(DEP_LIBS))
check: $(addprefix check-, $(DEP_LIBS))
install: $(addprefix install-, $(DEP_LIBS))
cleanall: $(addprefix clean-, $(DEP_LIBS))
distcleanall: $(addprefix distclean-, $(DEP_LIBS))
getall: get-julia

## PATHS ##
# sort is used to remove potential duplicates
DIRS = $(sort $(build_bindir) $(build_libdir) $(build_includedir) $(build_sysconfdir) $(build_datarootdir))

$(foreach dir,$(DIRS),$(eval $(call dir_target,$(dir))))

## julia ##

julia/Make.user:
	cp Make.user julia/Make.user 

JULIA_OBJ_TARGET= $(build_bindir)/julia

$(JULIA_OBJ_TARGET): compile-julia
	$(MAKE) -C julia install $(MAKE_COMMON)

get-julia:
	(cd julia && git submodule init && git submodule update)

configure-julia: julia/Make.user

compile-julia: configure-julia
	$(MAKE) -C julia $(MAKE_COMMON)

check-julia: compile-julia 

update-julia: 
	(cd julia && git submodule update)
	$(MAKE) -C julia install $(MAKE_COMMON)

install-julia: $(JULIA_OBJ_TARGET)

clean-julia: get-julia
	-$(MAKE) -C julia cleanall
	-rm julia/Make.user 

distclean-julia:
	-$(MAKE) -C julia distcleanall

## julia-deps ##


update-julia-deps: 
	@export JULIA_PKGDIR=$(JULIA_PKGDIR) UPDATE=1 && \
	$(call spawn,$(JULIA_BIN)) -C $(JULIA_CPU_TARGET) -J$(JULIA_SYSTEM_IMAGE) -f install-deps.jl

install-julia-deps:
	@export JULIA_PKGDIR=$(JULIA_PKGDIR) && \
	$(call spawn,$(JULIA_BIN)) -C $(JULIA_CPU_TARGET) -J$(JULIA_SYSTEM_IMAGE) -f install-deps.jl

clean-julia-deps:
	@rm -rfv $(JULIA_SHARE)/site/v0.4/*
	@rm -rfv $(JULIA_SHARE)/site/v0.4/.cache
	@rm -rfv $(JULIA_SHARE)/site/.cache
