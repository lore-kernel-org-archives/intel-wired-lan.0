From: Piotr Skajewski <piotrx.skajewski@intel.com>
Date: Fri, 26 Jun 2020 14:22:36 +0200
Subject: [Intel-wired-lan] [next-queue] ixgbe: Add ethtool support to enable
 2.5 and 5.0 Gbps support
In-Reply-To: <20200626050228.1287009-1-jeffrey.t.kirsher@intel.com>
References: <20200626050228.1287009-1-jeffrey.t.kirsher@intel.com>
Message-ID: <20200626122236.26118-1-piotrx.skajewski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

>> -----Original Message-----
>> 
>> From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
>> To: intel-wired-lan at lists.osuosl.org
>> Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>, Arthur F Mclean
>>     <arthur.f.mclean@intel.com>, Aleksandr Loktionov
>>     <aleksandr.loktionov@intel.com>
>> Subject: [Intel-wired-lan] [next-queue] ixgbe: Add ethtool support to
>>     enable 2.5 and 5.0 Gbps support
>> Message-ID: <20200626050228.1287009-1-jeffrey.t.kirsher@intel.com>
>> 
>> Update the ixgbe ethtool interface to support 2.5 and 5 GbE support by updated the getting and setting advertised and supported speed modes.
>> 
>> CC: Arthur F Mclean <arthur.f.mclean@intel.com>
>> CC: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>> Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
>> ---
>>  .../net/ethernet/intel/ixgbe/ixgbe_ethtool.c  | 234 ++++++++++++------
>>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   2 +
>>  2 files changed, 155 insertions(+), 81 deletions(-)
>> 
>> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
>> index 8ae2c8c2f6a1..c4e4aa33c91d 100644
>> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
>> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
>> @@ -149,28 +149,6 @@ static const char ixgbe_priv_flags_strings[][ETH_GSTRING_LEN] = {
>> 
...

>>     /* set the advertised speeds */
>>     if (hw->phy.autoneg_advertised) {
>> -		advertising = 0;
>> +		ethtool_link_ksettings_zero_link_mode(cmd, advertising);
>> 	if (hw->phy.autoneg_advertised & IXGBE_LINK_SPEED_10_FULL)
>> -			advertising |= ADVERTISED_10baseT_Full;
>> +			ethtool_link_ksettings_add_link_mode(cmd, advertising,
>> +							     10baseT_Full);
>> 	if (hw->phy.autoneg_advertised & IXGBE_LINK_SPEED_100_FULL)
>> -			advertising |= ADVERTISED_100baseT_Full;
>> +			ethtool_link_ksettings_add_link_mode(cmd, advertising,
>> +							     100baseT_Full);
>> 	if (hw->phy.autoneg_advertised & IXGBE_LINK_SPEED_10GB_FULL)
>> -			advertising |= supported & ADVRTSD_MSK_10G;

we need to add advertised for KX4 and KR modes which was previous in ADVRTSD_MSK_10G
and which are already zeroed

>> +			ethtool_link_ksettings_add_link_mode(cmd, advertising,
>> +							     10000baseT_Full);
>> 	if (hw->phy.autoneg_advertised & IXGBE_LINK_SPEED_1GB_FULL) {
 
...

>> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>> index 7515ed825fe2..0c7d208d9ab0 100644
>> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
>> @@ -5512,6 +5512,8 @@ static int ixgbe_non_sfp_link_config(struct ixgbe_hw *hw)
>>     if (ret)
>> 	return ret;
>>  
>> +	speed &= ~(IXGBE_LINK_SPEED_5GB_FULL | IXGBE_LINK_SPEED_2_5GB_FULL);

this should be inside
if (!speed && hw->mac.ops.get_link_capabilities)
if not, then after ifdown/ifup all advertised speed will be available again

>> +
>>     if (hw->mac.ops.setup_link)
>> 	ret = hw->mac.ops.setup_link(hw, speed, link_up);
>>  
>> --
>> 2.26.2

we've worked on this upstream patch before, we wanted to publish it today
after some inside tests. Patch is already ready to publish.
Now we are going to publish a new patch wihh you in cc.

Piotr
