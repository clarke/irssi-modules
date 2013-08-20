OBJDIR=$(HOME)/.irssi/scripts/autorun
SOURCES = adios.pl timezone.pl
OBJS = $(SOURCES:%=$(OBJDIR)/%)

$(OBJS): $(SOURCES)
	$(foreach FILE, $(SOURCES), $(shell cp $(FILE) $(OBJDIR)))
	@echo "Installation complete!"

install: $(OBJS)

uninstall: $(OBJS)
	$(foreach FILE, $(OBJS), $(shell rm -f $(FILE)))
	@echo "Uninstallation complete!"
