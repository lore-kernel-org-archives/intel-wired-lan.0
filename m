From: Steve Douthit <stephend@silicom-usa.com>
Date: Mon, 3 Dec 2018 17:02:40 +0000
Subject: [Intel-wired-lan] [PATCH net-next v2 1/2] ixgbe: register a
 mdiobus
In-Reply-To: <20181203165445.GI25748@lunn.ch>
References: <20181203163227.5107-1-stephend@silicom-usa.com>
 <20181203163227.5107-2-stephend@silicom-usa.com>
 <20181203165445.GI25748@lunn.ch>
Message-ID: <70350444-f05f-c57f-d4d8-0e059b4d896c@silicom-usa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 12/3/18 11:54 AM, Andrew Lunn wrote:
>> +static s32 ixgbe_x550em_a_mii_bus_read(struct mii_bus *bus, int addr,
>> +				       int regnum)
>> +{
>> +	struct ixgbe_adapter *adapter = (struct ixgbe_adapter *)bus->priv;
>> +	struct ixgbe_hw *hw = &adapter->hw;
>> +	u32 gssr = hw->phy.phy_semaphore_mask | IXGBE_GSSR_TOKEN_SM;
>> +
>> +	if (hw->bus.lan_id)
>> +		gssr |= IXGBE_GSSR_PHY1_SM;
>> +	else
>> +		gssr |= IXGBE_GSSR_PHY0_SM;
> 
> Hi Steve
> 
> If you only have one bus, do you still need this? One semaphore is all
> you need. And i'm not even sure you need that. The MDIO layer will
> perform locking, assuming everything goes through the MDIO layer.

AFAIK I still need part of it.  There's a PHY polling unit in the card
that we need to sync with independent of the locking in the MDIO layer.
I can drop the hw->bus.lan_id check though and unconditionally OR in the
IXGBE_GSSR_PHY0_SM since we always register on function 0 now.
