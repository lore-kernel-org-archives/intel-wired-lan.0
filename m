From: Florian Fainelli <f.fainelli@gmail.com>
Date: Mon, 3 Dec 2018 11:07:13 -0800
Subject: [Intel-wired-lan] [PATCH net-next v3 1/2] ixgbe: register a
 mdiobus
In-Reply-To: <20181203185454.6357-2-stephend@silicom-usa.com>
References: <20181203163227.5107-1-stephend@silicom-usa.com>
 <20181203185454.6357-1-stephend@silicom-usa.com>
 <20181203185454.6357-2-stephend@silicom-usa.com>
Message-ID: <b5de925d-bfef-0dff-61c7-63bd16113b1d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 12/3/18 10:55 AM, Steve Douthit wrote:
> Most dsa devices expect a 'struct mii_bus' pointer to talk to switches
> via the MII interface.
> 
> While this works for dsa devices, it will not work safely with Linux
> PHYs in all configurations since the firmware of the ixgbe device may
> be polling some PHY addresses in the background.
> 
> Signed-off-by: Stephen Douthit <stephend@silicom-usa.com>
> ---

[snip]

> +/**
> + *  ixgbe_mii_bus_write - Write a clause 22/45 register
> + *  @hw: pointer to hardware structure
> + *  @addr: address
> + *  @regnum: register number
> + *  @regnum: valueto write

This should be @val to match the function parameters

> + **/
> +static s32 ixgbe_mii_bus_write(struct mii_bus *bus, int addr, int regnum,
> +			       u16 val)
> +{
> +	struct ixgbe_adapter *adapter = (struct ixgbe_adapter *)bus->priv;

Nitpick: cast is not necessary since this is a void * pointer (for that
reason).

> +	struct ixgbe_hw *hw = &adapter->hw;
> +	u32 gssr = hw->phy.phy_semaphore_mask;
> +
> +	return ixgbe_mii_bus_write_generic(hw, addr, regnum, val, gssr);
> +}
> +
> +/**
> + *  ixgbe_x550em_a_mii_bus_read - Read a clause 22/45 register on x550em_a
> + *  @hw: pointer to hardware structure
> + *  @addr: address
> + *  @regnum: register number
> + **/
> +static s32 ixgbe_x550em_a_mii_bus_read(struct mii_bus *bus, int addr,
> +				       int regnum)
> +{
> +	struct ixgbe_adapter *adapter = (struct ixgbe_adapter *)bus->priv;

Likewise, the cast is not necessary.

Everything else looked fine, so with that fixed:

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
