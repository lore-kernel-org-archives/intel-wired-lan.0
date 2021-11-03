From: Andrew Lunn <andrew@lunn.ch>
Date: Wed, 3 Nov 2021 01:48:19 +0100
Subject: [Intel-wired-lan] [PATCH v2 net] ixgbe: set X550 MDIO speed
 before talking to PHY
In-Reply-To: <896681e4-fcd7-3187-8e59-75ce0896ebd3@lynx.com>
References: <896681e4-fcd7-3187-8e59-75ce0896ebd3@lynx.com>
Message-ID: <YYHcUxOA5jvrRtEs@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Nov 01, 2021 at 06:39:36PM -0700, Cyril Novikov wrote:
> The MDIO bus speed must be initialized before talking to the PHY the first
> time in order to avoid talking to it using a speed that the PHY doesn't
> support.
> 
> This fixes HW initialization error -17 (IXGBE_ERR_PHY_ADDR_INVALID) on
> Denverton CPUs (a.k.a. the Atom C3000 family) on ports with a 10Gb network
> plugged in. On those devices, HLREG0[MDCSPD] resets to 1, which combined
> with the 10Gb network results in a 24MHz MDIO speed, which is apparently
> too fast for the connected PHY. PHY register reads over MDIO bus return
> garbage, leading to initialization failure.
> 
> Reproduced with Linux kernel 4.19 and 5.15-rc7. Can be reproduced using
> the following setup:
> 
> * Use an Atom C3000 family system with at least one X552 LAN on the SoC
> * Disable PXE or other BIOS network initialization if possible
>   (the interface must not be initialized before Linux boots)
> * Connect a live 10Gb Ethernet cable to an X550 port
> * Power cycle (not reset, doesn't always work) the system and boot Linux
> * Observe: ixgbe interfaces w/ 10GbE cables plugged in fail with error -17
> 
> Signed-off-by: Cyril Novikov <cnovikov@lynx.com>
> Fixes: e84db7272798 ("ixgbe: Introduce function to control MDIO speed")

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
