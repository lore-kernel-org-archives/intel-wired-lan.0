From: Andrew Lunn <andrew@lunn.ch>
Date: Mon, 3 Dec 2018 19:54:45 +0100
Subject: [Intel-wired-lan] [PATCH net-next v2 1/2] ixgbe: register a
 mdiobus
In-Reply-To: <8ff5f4f0-9a4a-d601-3add-fcfc91b6414d@silicom-usa.com>
References: <20181203163227.5107-1-stephend@silicom-usa.com>
 <20181203163227.5107-2-stephend@silicom-usa.com>
 <20181203165445.GI25748@lunn.ch>
 <70350444-f05f-c57f-d4d8-0e059b4d896c@silicom-usa.com>
 <20181203172116.GJ25748@lunn.ch>
 <bc3570c5-0da7-ca8d-b095-6bbc80afaf02@silicom-usa.com>
 <20181203181811.GM25748@lunn.ch>
 <8ff5f4f0-9a4a-d601-3add-fcfc91b6414d@silicom-usa.com>
Message-ID: <20181203185445.GO25748@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> You can actually strap the 6390 and friends for a multi-chip mode where
> they claim only a single address, instead of one per port, plus a couple
> more for global registers.  It vastly slows things down because of the
> extra indirection, but it allows the switch to play nicely with other
> MDIO devs.

As you say, it slows things down a lot, so it is not used very often.
In fact, i don't know of any recent board which actually uses a single
address, for any DSA supported switch.

If you need multiple devices, e.g. an odd PHY as well as a switch, i
would use a couple of GPIO lines and do a bit-banging MDIO bus for the
PHY, and let the switch have all the address of the hardware MDIO bus.
This assumes you are using the kernel infrastructure, so you can
connect the MAC to any arbitrary PHY.

	 Andrew
