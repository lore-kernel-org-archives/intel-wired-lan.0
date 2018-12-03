From: Steve Douthit <stephend@silicom-usa.com>
Date: Mon, 3 Dec 2018 18:38:40 +0000
Subject: [Intel-wired-lan] [PATCH net-next v2 1/2] ixgbe: register a
 mdiobus
In-Reply-To: <20181203181811.GM25748@lunn.ch>
References: <20181203163227.5107-1-stephend@silicom-usa.com>
 <20181203163227.5107-2-stephend@silicom-usa.com>
 <20181203165445.GI25748@lunn.ch>
 <70350444-f05f-c57f-d4d8-0e059b4d896c@silicom-usa.com>
 <20181203172116.GJ25748@lunn.ch>
 <bc3570c5-0da7-ca8d-b095-6bbc80afaf02@silicom-usa.com>
 <20181203181811.GM25748@lunn.ch>
Message-ID: <8ff5f4f0-9a4a-d601-3add-fcfc91b6414d@silicom-usa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 12/3/18 1:18 PM, Andrew Lunn wrote:
>> Agreed, but I'd argue it's the same behavior we have today with the
>> existing MII ioctls in this driver.  That's not to say this is good,
>> it's just not any less broken than the current state of things.
> 
> Agreed.
> 
> I actually would be happy with a warning in the commit message that
> this code is not sufficient to make use of Linux PHY drivers, because
> of the hardware polling. You can then leave fixing that to whoever
> needs Linux PHY drivers.

OK, will update for v3.

>> AFAICT the polling hardware only pokes the device address that the
>> driver stores in 'hw->phy.mdio.prtad', so the PHY polling unit would
>> never see the switch, if it's even polling at all.  Some of the MAC
>> configurations will store MDIO_PRTAD_NONE, in which case I wouldn't
>> expect the polling unit to be active.  It's up to the board designer to
>> ensure there's no address conflicts on the bus.
> 
> Well, the 6390 does use address 0-10 for its port registers, and there
> is something which looks like a PHYID in register 3. So for your use
> case of DSA, it would be good to ensure it really is disabled.

You can actually strap the 6390 and friends for a multi-chip mode where
they claim only a single address, instead of one per port, plus a couple
more for global registers.  It vastly slows things down because of the
extra indirection, but it allows the switch to play nicely with other
MDIO devs.

>> Then in the ioctl code, in addition to checking the mii_bus is
>> available, also check that the requested address is one that phy_mask
>> says mii_bus owns, otherwise we fall through to the old code.
> 
> I'm not too bothered with the ioctl. It is there so you can shoot
> yourself in the foot. The hardware polling unit just adds more
> interesting weapons you can use to shoot yourself in the foot.

Hooray for enhanced anti-foot artillery :)
