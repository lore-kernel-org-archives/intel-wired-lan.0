From: Andre Guedes <andre.guedes@intel.com>
Date: Thu, 21 May 2020 11:09:07 -0700
Subject: [Intel-wired-lan] [PATCH v2 1/1] igc: Add initial EEE support
In-Reply-To: <20200521051033.30813-1-sasha.neftin@intel.com>
References: <20200521051033.30813-1-sasha.neftin@intel.com>
Message-ID: <159008454769.70366.11413367573186547439@swaranku-mobl2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Sasha,

Quoting Sasha Neftin (2020-05-20 22:10:33)
> diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
> index 2214a5d3a259..3035d3a96621 100644
> --- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
> +++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
[...]
> +static int igc_ethtool_set_eee(struct net_device *netdev,
> +                              struct ethtool_eee *edata)
> +{
> +       struct igc_adapter *adapter = netdev_priv(netdev);
> +       struct igc_hw *hw = &adapter->hw;
> +       struct ethtool_eee eee_curr;
> +       s32 ret_val;
> +
> +       memset(&eee_curr, 0, sizeof(struct ethtool_eee));
> +
> +       ret_val = igc_ethtool_get_eee(netdev, &eee_curr);
> +       if (ret_val)
> +               return ret_val;
> +
> +       if (eee_curr.eee_enabled) {
> +               if (eee_curr.tx_lpi_enabled != edata->tx_lpi_enabled) {
> +                       netdev_err(netdev,
> +                                  "Setting EEE tx-lpi is not supported\n");
> +                       return -EINVAL;
> +               }
> +
> +               /* Tx LPI timer is not implemented currently */
> +               if (edata->tx_lpi_timer) {
> +                       netdev_err(netdev,
> +                                  "Setting EEE Tx LPI timer is not supported\n");
> +                       return -EINVAL;
> +               }
> +       } else if (!edata->eee_enabled) {
> +               netdev_err(netdev,
> +                          "Setting EEE options are not supported with EEE disabled\n");
> +               return -EINVAL;
> +       }
> +
> +       adapter->eee_advert = ethtool_adv_to_mmd_eee_adv_t(edata->advertised);
> +       if (hw->dev_spec._base.eee_enable != edata->eee_enabled) {
> +               hw->dev_spec._base.eee_enable = edata->eee_enabled;
> +               adapter->flags |= IGC_FLAG_EEE;
> +
> +               /* reset link */
> +               if (netif_running(netdev))
> +                       igc_reinit_locked(adapter);
> +               else
> +                       igc_reset(adapter);
> +       }
> +
> +       if (ret_val) {
> +               netdev_err(netdev,
> +                          "Problem setting EEE advertisement options\n");
> +               return -EINVAL;
> +       }

'ret_val' is already checked in the beginning of this function, and it is not
set afterwards. So it seems this check is pointless.

> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index c4df7129f930..6110093c6ad9 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
[...]
> @@ -5190,6 +5202,10 @@ static int igc_probe(struct pci_dev *pdev,
>         netdev_info(netdev, "MAC: %pM", netdev->dev_addr);
>  
>         dev_pm_set_driver_flags(&pdev->dev, DPM_FLAG_NEVER_SKIP);
> +       /* Disable EEE for internal copper PHY devices */
> +       hw->dev_spec._base.eee_enable = false;
> +       adapter->flags &= ~IGC_FLAG_EEE;
> +       igc_set_eee_i225(hw, false, false, false);

Could you please clarify if EEE is expected to be enabled or disabled by
default? IIUC this code, EEE is disabled by default. But in IGB it is enabled
by default.

In addition to that, the comment above mentions it disables EEE for copper
devices, but there is no check for such device. Is the comment indeed
applicable here?

Regards,

Andre
