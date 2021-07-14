From: Sasha Neftin <sasha.neftin@intel.com>
Date: Wed, 14 Jul 2021 10:04:26 +0300
Subject: [Intel-wired-lan] [PATCH v1 3/3] e1000e: Additional PHY power
 saving in s0ix
In-Reply-To: <fab23c51-cfcd-2a20-0558-346ade1199b5@molgen.mpg.de>
References: <20210624081908.568757-1-sasha.neftin@intel.com>
 <b144efbc-9dbd-dd7c-b8df-a504a757bded@molgen.mpg.de>
 <3de72f51-8f3d-29c9-dc74-b016c13c5b08@intel.com>
 <fab23c51-cfcd-2a20-0558-346ade1199b5@molgen.mpg.de>
Message-ID: <183fbfd4-5523-593c-0eb6-814eb6a1e03e@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 7/14/2021 09:09, Paul Menzel wrote:
> Dear Sasha,
> 
> 
> Am 13.07.21 um 18:40 schrieb Sasha Neftin:
>> On 7/13/2021 10:12, Paul Menzel wrote:
> 
>>> Am 24.06.21 um 10:19 schrieb Sasha Neftin:
>>>
>>> Could you please use a statement in the commit message summary? Maybe:
>>>
>>>> Disable additional PHY features(?) in S0ix
>>>
>>>> After transferring the MAC-PHY interface to the SMBus the PHY
>>>> will save power in S0ix low power idle mode.
>>>
>>> I do not understand this. Please rewrite, and mention the three PHY 
>>> features(?) you change.
>>>
>>> Please document how you tested this, and exactly how much power is 
>>> saved.
> 
>> The PHY will save 47-85mW in s0ix. It is tested (by our electrical 
>> validation team) on a sense resistor on a specific external board over 
>> the TGL platform.
>>
>> This measurement could variate from platform to platform and depends 
>> on the specific platform design.
> 
> Thank you for sharing the data. Please add it to the commit message in v2.
Paul, I will work on this with our HW architect. We will process 
specification updates. I will let you know and share since it will ready.
> 
>>>> Suggested-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
>>>> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
>>>> ---
>>>> ? drivers/net/ethernet/intel/e1000e/netdev.c | 6 ++++++
>>>> ? 1 file changed, 6 insertions(+)
>>>>
>>>> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c 
>>>> b/drivers/net/ethernet/intel/e1000e/netdev.c
>>>> index 6e6e2e685e9d..c4f3e5ca7294 100644
>>>> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
>>>> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
>>>> @@ -6380,10 +6380,16 @@ static void e1000e_s0ix_entry_flow(struct 
>>>> e1000_adapter *adapter)
>>>> ????????? ew32(CTRL_EXT, mac_data);
>>>> ? ????????? /* DFT control: PHY bit: page769_20[0] = 1
>>>> +???????? * page769_20[7] - PHY PLL stop
>>>> +???????? * page769_20[8] - PHY go to the electrical idle
>>>> +???????? * page769_20[9] - PHY serdes disable
>>>> ?????????? * Gate PPW via EXTCNF_CTRL - set 0x0F00[7] = 1
>>>> ?????????? */
>>>> ????????? e1e_rphy(hw, I82579_DFT_CTRL, &phy_data);
>>>> ????????? phy_data |= BIT(0);
>>>> +??????? phy_data |= BIT(7);
>>>> +??????? phy_data |= BIT(8);
>>>> +??????? phy_data |= BIT(9);
>>>> ????????? e1e_wphy(hw, I82579_DFT_CTRL, phy_data);
>>>> ? ????????? mac_data = er32(EXTCNF_CTRL);
>>>>
> 
> 
> Kind regards,
> 
> Paul
Sasha
