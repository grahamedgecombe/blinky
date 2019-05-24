QUIET = -q

SPEED   = up
DEVICE  = 5k
PACKAGE = sg48
FREQ    = 12

IL   = blinky.il
V    = blinky.v
JSON = blinky.json
PCF  = blinky.pcf
ASC  = blinky.asc
BIN  = blinky.bin

.PHONY: all verilog clean flash

all: $(BIN)

clean:
	$(RM) $(IL) $(V) $(JSON) $(ASC) $(BIN)

$(IL):
	./blinky.py generate -t il $@

$(V):
	./blinky.py generate -t v $@

verilog: $(V)

$(JSON): $(IL)
	yosys $(QUIET) -p 'read_ilang $<; synth_ice40 -json $@'

$(ASC): $(JSON) $(PCF)
	nextpnr-ice40 $(QUIET) \
		--$(SPEED)$(DEVICE) \
		--package $(PACKAGE) \
		--json $< \
		--pcf $(PCF) \
		--freq $(FREQ) \
		--asc $@

$(BIN): $(ASC)
	icepack $< $@

flash: $(BIN)
	iceprog $<
