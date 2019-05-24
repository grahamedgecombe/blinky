#!/usr/bin/env python

from nmigen import *
from nmigen.cli import main


class Blinky(Elaboratable):
    def __init__(self):
        self.cd_sync = ClockDomain(reset_less=True)
        self.count = Signal(max=12000000)
        self.led = Signal()

    def elaborate(self, platform):
        m = Module()
        m.domains += self.cd_sync
        m.d.sync += self.count.eq(self.count + 1)
        m.d.comb += self.led.eq(self.count[-1])
        return m


if __name__ == "__main__":
    blinky = Blinky()
    main(blinky, ports=[blinky.cd_sync.clk, blinky.led])
