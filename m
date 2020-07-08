From: Neftin, Sasha <sasha.neftin@intel.com>
Date: Wed, 8 Jul 2020 15:22:57 +0300
Subject: [Intel-wired-lan] [bug report] igc: Add initial LTR support
In-Reply-To: <20200708114751.GA11509@mwanda>
References: <20200708114751.GA11509@mwanda>
Message-ID: <ee80dbd3-0042-0c1f-de92-9df65e376ee0@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 7/8/2020 14:47, dan.carpenter at oracle.com wrote:
> Hello Sasha Neftin,
> 
> The patch 707abf069548: "igc: Add initial LTR support" from Jun 2,
> 2020, leads to the following static checker warning:
> 
> 	drivers/net/ethernet/intel/igc/igc_mac.c:424 igc_check_for_copper_link()
> 	error: uninitialized symbol 'link'.
> 
> drivers/net/ethernet/intel/igc/igc_mac.c
>     363  s32 igc_check_for_copper_link(struct igc_hw *hw)
>     364  {
>     365          struct igc_mac_info *mac = &hw->mac;
>     366          s32 ret_val;
>     367          bool link;
>                  ^^^^^^^^^
I will release patch to fix this static checker warning.
> 
>     368
>     369          /* We only want to go out to the PHY registers to see if Auto-Neg
>     370           * has completed and/or if our link status has changed.  The
>     371           * get_link_status flag is set upon receiving a Link Status
>     372           * Change or Rx Sequence Error interrupt.
>     373           */
>     374          if (!mac->get_link_status) {
>     375                  ret_val = 0;
>     376                  goto out;
>                          ^^^^^^^^
> 
>     377          }
>     378
>     379          /* First we want to see if the MII Status Register reports
>     380           * link.  If so, then we want to get the current speed/duplex
>     381           * of the PHY.
>     382           */
>     383          ret_val = igc_phy_has_link(hw, 1, 0, &link);
>     384          if (ret_val)
>     385                  goto out;
>     386
>     387          if (!link)
>     388                  goto out; /* No link detected */
>     389
>     390          mac->get_link_status = false;
>     391
>     392          /* Check if there was DownShift, must be checked
>     393           * immediately after link-up
>     394           */
>     395          igc_check_downshift(hw);
>     396
>     397          /* If we are forcing speed/duplex, then we simply return since
>     398           * we have already determined whether we have link or not.
>     399           */
>     400          if (!mac->autoneg) {
>     401                  ret_val = -IGC_ERR_CONFIG;
>     402                  goto out;
>     403          }
>     404
>     405          /* Auto-Neg is enabled.  Auto Speed Detection takes care
>     406           * of MAC speed/duplex configuration.  So we only need to
>     407           * configure Collision Distance in the MAC.
>     408           */
>     409          igc_config_collision_dist(hw);
>     410
>     411          /* Configure Flow Control now that Auto-Neg has completed.
>     412           * First, we need to restore the desired flow control
>     413           * settings because we may have had to re-autoneg with a
>     414           * different link partner.
>     415           */
>     416          ret_val = igc_config_fc_after_link_up(hw);
>     417          if (ret_val)
>     418                  hw_dbg("Error configuring flow control\n");
>     419
>     420  out:
>     421          /* Now that we are aware of our link settings, we can set the LTR
>     422           * thresholds.
>     423           */
>     424          ret_val = igc_set_ltr_i225(hw, link);
>                                                 ^^^^
> Uninitialized.
> 
>     425
>     426          return ret_val;
>     427  }
> 
> regards,
> dan carpenter
> 
Thanks Dan for point us on this problem. This patch discover legacy code 
problem. I will process another patch to fix that.
