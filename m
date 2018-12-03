From: Andrew Lunn <andrew@lunn.ch>
Date: Mon, 3 Dec 2018 18:21:16 +0100
Subject: [Intel-wired-lan] [PATCH net-next v2 1/2] ixgbe: register a
 mdiobus
In-Reply-To: <70350444-f05f-c57f-d4d8-0e059b4d896c@silicom-usa.com>
References: <20181203163227.5107-1-stephend@silicom-usa.com>
 <20181203163227.5107-2-stephend@silicom-usa.com>
 <20181203165445.GI25748@lunn.ch>
 <70350444-f05f-c57f-d4d8-0e059b4d896c@silicom-usa.com>
Message-ID: <20181203172116.GJ25748@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Dec 03, 2018 at 05:02:40PM +0000, Steve Douthit wrote:
> On 12/3/18 11:54 AM, Andrew Lunn wrote:
> >> +static s32 ixgbe_x550em_a_mii_bus_read(struct mii_bus *bus, int addr,
> >> +				       int regnum)
> >> +{
> >> +	struct ixgbe_adapter *adapter = (struct ixgbe_adapter *)bus->priv;
> >> +	struct ixgbe_hw *hw = &adapter->hw;
> >> +	u32 gssr = hw->phy.phy_semaphore_mask | IXGBE_GSSR_TOKEN_SM;
> >> +
> >> +	if (hw->bus.lan_id)
> >> +		gssr |= IXGBE_GSSR_PHY1_SM;
> >> +	else
> >> +		gssr |= IXGBE_GSSR_PHY0_SM;
> > 
> > Hi Steve
> > 
> > If you only have one bus, do you still need this? One semaphore is all
> > you need. And i'm not even sure you need that. The MDIO layer will
> > perform locking, assuming everything goes through the MDIO layer.
> 
> AFAIK I still need part of it.  There's a PHY polling unit in the card
> that we need to sync with independent of the locking in the MDIO layer.
> I can drop the hw->bus.lan_id check though and unconditionally OR in the
> IXGBE_GSSR_PHY0_SM since we always register on function 0 now.

Hi Steve

In general, this is not enough to make a PHY polling unit safe. At
least not with C22 devices. They often have a register which can be
used to select a different page. The software driver can do a write to
swap the page at any time, e.g. to select the page with the
temperature sensor. After it releases the semaphore for that write
changing the page, the hardware could then poll the PHY, and read a
temperature sensor register instead of the link status, and then bad
things happen.

When using Intel's PHY drivers embedded within the Intel MAC driver,
this is not a problem. They can avoid swapping to different
pages. However, you are on the path to allow the Linux PHY drivers to
be used, and some of them will change the page. And with the embedded
SOC you are working on, i would not be too surprised to see somebody
build a system using a different PHY which the Intel PHY drivers don't
support, but does have a Linux PHY driver.

You also need to watch out for your use case of Marvell
mv88e6390. Polling that makes no sense. Does the hardware actually
recognise it is not a PHY?

	  Andrew

