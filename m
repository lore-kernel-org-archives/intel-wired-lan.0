From: Neftin, Sasha <sasha.neftin@intel.com>
Date: Wed, 20 May 2020 09:34:34 +0300
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Add initial EEE support
In-Reply-To: <158993395587.38317.17024118281100869909@twxiong-mobl.amr.corp.intel.com>
References: <20200519101644.8246-1-sasha.neftin@intel.com>
 <158993395587.38317.17024118281100869909@twxiong-mobl.amr.corp.intel.com>
Message-ID: <c586b0ab-f652-65b9-3d6b-f3697464631b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 5/20/2020 03:19, Andre Guedes wrote:
> Hi Sasha,
> 
>> +static int igc_ethtool_get_eee(struct net_device *netdev,
>> +                              struct ethtool_eee *edata)
>> +{
>> +       struct igc_adapter *adapter = netdev_priv(netdev);
>> +       struct igc_hw *hw = &adapter->hw;
>> +       u32 eeer;
>> +
>> +       if (!hw->dev_spec._base.eee_disable)
>> +               edata->advertised =
>> +                       mmd_eee_adv_to_ethtool_adv_t(adapter->eee_advert);
>> +
>> +       *edata = adapter->eee;
>> +       edata->supported = (SUPPORTED_Autoneg);
> 
> Nitpicking: The surrounding parentheses here looks pointless.
> 
I will fix it in v2
>> +       netdev_info(netdev,
>> +                   "Supported EEE link modes: 100baseT/Full, 1000baseT/Full, 2500baseT/Full");
> 
> Although the '\n' is automatically added to this message, from the discussion
> in [1], the preference is that we keep putting it at the end of our logging
> messages.
> 
> This comment applies to all other log messages in this patch.
> 
yeah... we will need do that for all rest code where we removed "\n". I 
will take care for code relvant to this patch only. Other netdev_* 
should be changed too.
>> +static int igc_ethtool_set_eee(struct net_device *netdev,
>> +                              struct ethtool_eee *edata)
>> +{
>> +       struct igc_adapter *adapter = netdev_priv(netdev);
>> +       struct igc_hw *hw = &adapter->hw;
>> +       struct ethtool_eee eee_curr;
>> +       s32 ret_val;
>> +
>> +       if (hw->phy.media_type != igc_media_type_copper)
>> +               return -EOPNOTSUPP;
> 
> It looks 'igc_media_type_copper' is the only media_type supported by the
> driver, at least up till now. I'm wondering if we could get rid of it and
> simplify the code.
> 
Will fix in v2.
>> +
>> +       memset(&eee_curr, 0, sizeof(struct ethtool_eee));
>> +
>> +       ret_val = igc_ethtool_get_eee(netdev, &eee_curr);
>> +       if (ret_val)
>> +               return ret_val;
>> +
>> +       if (eee_curr.eee_enabled) {
>> +               if (eee_curr.tx_lpi_enabled != edata->tx_lpi_enabled) {
>> +                       netdev_err(netdev,
>> +                                  "Setting EEE tx-lpi is not supported");
>> +                       return -EINVAL;
>> +               }
>> +
>> +               /* Tx LPI timer is not implemented currently */
>> +               if (edata->tx_lpi_timer) {
>> +                       netdev_err(netdev,
>> +                                  "Setting EEE Tx LPI timer is not supported");
>> +                       return -EINVAL;
>> +               }
>> +
> 
> It seems we have an empty line here by mistake.
> 
Will fix in v2.
>> +       } else if (!edata->eee_enabled) {
>> +               netdev_err(netdev,
>> +                          "Setting EEE options are not supported with EEE disabled");
>> +               return -EINVAL;
>> +       }
>> +
>> +       adapter->eee_advert = ethtool_adv_to_mmd_eee_adv_t(edata->advertised);
>> +       if (hw->dev_spec._base.eee_disable != !edata->eee_enabled) {
> 
> In every occurrence of _base.eee_disable we use the '!' operator like in the
> line above. I think the code would be more readable if we inverted the logic
> and had _base.eee_enable instead.
> 
I agree. Actually all Intel drivers used inverted logic. Indeed will be 
more readable. Will fix in v2.
>> +s32 igc_set_eee_i225(struct igc_hw *hw, bool adv2p5G, bool adv1G,
>> +                    bool adv100M)
>> +{
>> +       u32 ipcnfg, eeer;
>> +
>> +       if (hw->mac.type != igc_i225 ||
>> +           hw->phy.media_type != igc_media_type_copper)
> 
> The same comment I made above about checking for 'igc_media_type_copper'
> applies here too.
> 
Will fix in v2.
> It looks 'igc_i225' is the only hw->mac.type supported by the driver, at least
> up till now. I'm wondering if we could get rid of it and simplify the code.
> 
Right, mac_type and media_type is only one for i225 part. I think we 
will clean up it in separated patches.
> Regards,
> 
> Andre
> 
> [1] https://lore.kernel.org/netdev/20200421.153221.2089591404052111123.davem at davemloft.net/
> 
Hello Andre, thanks for review
