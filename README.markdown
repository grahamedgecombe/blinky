# Blinky

LED blinking example for [iCEBreaker][icebreaker] FPGA boards, written in
[nMigen][nmigen].

I think the most interesting part of this example is the `Makefile`, as the
nMigen repository currently lacks documentation or an example showing how to
hook nMigen up to nextpnr.

Run `make flash` to run the synthesis process and flash the iCEBreaker with the
bitstream. The red LED should turn on and off approximately once per second.

[icebreaker]: https://icebreaker-fpga.com/
[nmigen]: https://github.com/m-labs/nmigen
