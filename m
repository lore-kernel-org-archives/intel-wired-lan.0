From: Florian Fainelli <f.fainelli@gmail.com>
Date: Mon, 3 Dec 2018 11:45:18 -0800
Subject: [Intel-wired-lan] [PATCH net-next v3 1/2] ixgbe: register a
 mdiobus
In-Reply-To: <98205032-e218-7a6a-992f-65800e4f6351@silicom-usa.com>
References: <20181203163227.5107-1-stephend@silicom-usa.com>
 <20181203185454.6357-1-stephend@silicom-usa.com>
 <20181203185454.6357-2-stephend@silicom-usa.com>
 <b5de925d-bfef-0dff-61c7-63bd16113b1d@gmail.com>
 <98205032-e218-7a6a-992f-65800e4f6351@silicom-usa.com>
Message-ID: <4aad0a7b-38d6-e5f2-c948-87da3303dfe7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 12/3/18 11:44 AM, Steve Douthit wrote:
> On 12/3/18 2:07 PM, Florian Fainelli wrote:
>> On 12/3/18 10:55 AM, Steve Douthit wrote:
>>> Most dsa devices expect a 'struct mii_bus' pointer to talk to switches
>>> via the MII interface.
>>>
>>> While this works for dsa devices, it will not work safely with Linux
>>> PHYs in all configurations since the firmware of the ixgbe device may
>>> be polling some PHY addresses in the background.
>>>
>>> Signed-off-by: Stephen Douthit <stephend@silicom-usa.com>
>>> ---
>>
>> [snip]
>>
>>> +/**
>>> + *  ixgbe_mii_bus_write - Write a clause 22/45 register
>>> + *  @hw: pointer to hardware structure
>>> + *  @addr: address
>>> + *  @regnum: register number
>>> + *  @regnum: valueto write
>>
>> This should be @val to match the function parameters
> 
> OK
> 
>>> + **/
>>> +static s32 ixgbe_mii_bus_write(struct mii_bus *bus, int addr, int regnum,
>>> +			       u16 val)
>>> +{
>>> +	struct ixgbe_adapter *adapter = (struct ixgbe_adapter *)bus->priv;
>>
>> Nitpick: cast is not necessary since this is a void * pointer (for that
>> reason).
> 
> OK, I'll clean up this and other unnecessary casts.
> 
> I forgot Andrew's suggestion to squash the swfw semaphore masks from:
> 
> +	u32 gssr = hw->phy.phy_semaphore_mask | IXGBE_GSSR_TOKEN_SM;
> +
> +	if (hw->bus.lan_id)
> +		gssr |= IXGBE_GSSR_PHY1_SM;
> +	else
> +		gssr |= IXGBE_GSSR_PHY0_SM;
> 
> to
> 
> +	u32 gssr = hw->phy.phy_semaphore_mask;
> +	gssr |= IXGBE_GSSR_TOKEN_SM | IXGBE_GSSR_PHY0_SM;
> 
> Is it ok to collect both of your 'Reviewed-by:'s with that additional
> change for v4?

I'd think so.
-- 
Florian
