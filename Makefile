# Makefile recipe for Assembly Crash Course

# Toolchain vars
AS=cl65
TGT=nes
ASFLAGS=--verbose --target $(TGT)

SRCDIR=examples
BUILDDIR=build

# Targets
%.nes: $(SRCDIR)/%.s
	if [[ ! -d $(BUILDDIR) ]]; then mkdir $(BUILDDIR); fi;
	$(AS) $(ASFLAGS) -o $(BUILDDIR)/$@ wrapper.s $^

clean:
	find . -type f -iname "*.o" -exec rm {} \;
	$(RM) -r $(BUILDDIR)

.PHONY: clean
