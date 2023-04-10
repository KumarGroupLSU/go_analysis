FC = gfortran

PROJDIR := $(realpath $(CURDIR))
SRCDIR := $(PROJDIR)/src
BINDIR := $(PROJDIR)/bin
BUILDDIR := $(PROJDIR)/build

ifneq ($(BINDIR),)
 $(shell test -d $(BINDIR) || mkdir -p $(BINDIR))
endif
ifneq ($(BUILDDIR),)
 $(shell test -d $(BUILDDIR) || mkdir -p $(BUILDDIR))
endif

ifeq ($(FC), gfortran)
	FCFLAGS+= -J$(BUILDDIR) -fopenmp
endif

ifeq ($(FC), ifort)
	FCFLAGS += -module $(BUILDDIR) -qopenmp
endif

SRC := $(shell find $(SRCDIR) -type f -name *.f90)
OBJ := $(patsubst $(SRCDIR)/%,$(BUILDDIR)/%,$(SRC:.f90=.o))
MOD := $(patsubst $(SRCDIR)/%,$(BUILDDIR)/%,$(SRC:.f90=.mod))

$(BUILDDIR)/assign.o: $(BUILDDIR)/input.o $(BUILDDIR)/sb_go.o
$(BUILDDIR)/surface_wrap.o: $(BUILDDIR)/input.o $(BUILDDIR)/sb_go.o
$(BUILDDIR)/density.o: $(BUILDDIR)/input.o $(BUILDDIR)/sb_go.o
$(BUILDDIR)/dist.o: $(BUILDDIR)/input.o $(BUILDDIR)/sb_go.o
$(BUILDDIR)/react_event.o: $(BUILDDIR)/input.o $(BUILDDIR)/sb_go.o
$(BUILDDIR)/fluctuation.o: $(BUILDDIR)/input.o $(BUILDDIR)/sb_go.o
$(BUILDDIR)/water_angle.o: $(BUILDDIR)/input.o $(BUILDDIR)/sb_go.o
$(BUILDDIR)/hbonds.o: $(BUILDDIR)/input.o $(BUILDDIR)/sb_go.o
$(BUILDDIR)/vvcf.o: $(BUILDDIR)/input.o $(BUILDDIR)/sb_go.o
$(BUILDDIR)/proton_hop.o: $(BUILDDIR)/input.o $(BUILDDIR)/sb_go.o
$(BUILDDIR)/hydroxyde_hop.o: $(BUILDDIR)/input.o $(BUILDDIR)/sb_go.o

$(BUILDDIR)/%.o: $(SRCDIR)/%.f90
	$(FC) $(FCFLAGS) -o$@ -c $<
	@touch $@

all: assign surface_wrap density dist react_event fluctuation water_angle hbonds vvcf proton_hop hydroxyde_hop

assign: $(BUILDDIR)/assign.o $(BUILDDIR)/input.o $(BUILDDIR)/sb_go.o
	$(FC) $(FCFLAGS) -o $(BINDIR)/assign $^

surface_wrap: $(BUILDDIR)/surface_wrap.o $(BUILDDIR)/input.o $(BUILDDIR)/sb_go.o
	$(FC) $(FCFLAGS) -o $(BINDIR)/surface_wrap $^

density: $(BUILDDIR)/density.o $(BUILDDIR)/input.o $(BUILDDIR)/sb_go.o
	$(FC) $(FCFLAGS) -o $(BINDIR)/density $^

dist: $(BUILDDIR)/dist.o $(BUILDDIR)/input.o $(BUILDDIR)/sb_go.o
	$(FC) $(FCFLAGS) -o $(BINDIR)/dist $^

react_event: $(BUILDDIR)/react_event.o $(BUILDDIR)/input.o $(BUILDDIR)/sb_go.o
	$(FC) $(FCFLAGS) -o $(BINDIR)/react_event $^

fluctuation: $(BUILDDIR)/fluctuation.o $(BUILDDIR)/input.o $(BUILDDIR)/sb_go.o
	$(FC) $(FCFLAGS) -o $(BINDIR)/fluctuation $^

water_angle: $(BUILDDIR)/water_angle.o $(BUILDDIR)/input.o $(BUILDDIR)/sb_go.o
	$(FC) $(FCFLAGS) -o $(BINDIR)/water_angle $^

hbonds: $(BUILDDIR)/hbonds.o $(BUILDDIR)/input.o $(BUILDDIR)/sb_go.o
	$(FC) $(FCFLAGS) -o $(BINDIR)/hbonds $^

vvcf: $(BUILDDIR)/vvcf.o $(BUILDDIR)/input.o $(BUILDDIR)/sb_go.o
	$(FC) $(FCFLAGS) -o $(BINDIR)/vvcf $^

proton_hop: $(BUILDDIR)/proton_hop.o $(BUILDDIR)/input.o $(BUILDDIR)/sb_go.o
	$(FC) $(FCFLAGS) -o $(BINDIR)/proton_hop $^

hydroxyde_hop: $(BUILDDIR)/hydroxyde_hop.o $(BUILDDIR)/input.o $(BUILDDIR)/sb_go.o
	$(FC) $(FCFLAGS) -o $(BINDIR)/hydroxyde_hop $^

clean:
	rm -rf $(BUILDDIR)

realclean:
	rm -rf $(BUILDDIR) $(BINDIR)
