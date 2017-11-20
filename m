From: Florian Larysch <fl@n621.de>
Date: Mon, 20 Nov 2017 13:11:23 +0100
Subject: [Intel-wired-lan] Using X550 on unidirectional links
Message-ID: <20171120121123.GA24603@nyx.n621.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,

I'm trying to get an ixgbe card (X550EM_X_SFP as integrated in the Xeon
D-1500 on a Supermicro X10SDV-2C-TP4F board) to transmit via a
1000BASE-SX SFP even when not receiving a signal. While setting the FLU
bit in MACC causes the link detection to signal a link up and the
transmit counters go up when sending packets, nothing seems to go out on
the wire.

I guess some part of the PHY or the controller's firmware is dropping
the packets because no carrier is being sensed and/or autonegotiation
cannot proceed. Is there a way to override this behavior? The driver is
poking numerous PHY registers, but I've not been able to find a list of
those.

I've also thought about using the PHY loopbacks mentioned in the
datasheet to achieve this, but there's no description on how to actually
configure those.

Can somebody point me into the right direction on this?

Thanks,
Florian
