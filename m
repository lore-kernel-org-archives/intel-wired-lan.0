From: Avivi, Amir <amir.avivi@linux.intel.com>
Date: Thu, 28 May 2020 11:50:22 +0300
Subject: [Intel-wired-lan] Intel-wired-lan Digest, Vol 268, Issue 43
In-Reply-To: <SN6PR11MB3424D891CB5ACD6DC8347560978E0@SN6PR11MB3424.namprd11.prod.outlook.com>
References: <mailman.9577.1590117676.59095.intel-wired-lan@osuosl.org>
 <SN6PR11MB3424D891CB5ACD6DC8347560978E0@SN6PR11MB3424.namprd11.prod.outlook.com>
Message-ID: <c4d14894-d0dd-1a5c-2ff5-2f9da23dbc75@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> ------------------------------------------------------------------------
>
> *From:*Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> on behalf 
> of intel-wired-lan-request at osuosl.org <intel-wired-lan-request@osuosl.org>
> *Sent:* Friday, 22 May 2020 06:21
> *To:* intel-wired-lan at osuosl.org <intel-wired-lan@osuosl.org>
> *Subject:* Intel-wired-lan Digest, Vol 268, Issue 43
>
> Send Intel-wired-lan mailing list submissions to
> ??????? intel-wired-lan at osuosl.org
>
> To subscribe or unsubscribe via the World Wide Web, visit
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
> or, via email, send a message with subject or body 'help' to
> ??????? intel-wired-lan-request at osuosl.org
>
> You can reach the person managing the list at
> ??????? intel-wired-lan-owner at osuosl.org
>
> When replying, please edit your Subject line so it is more specific
> than "Re: Contents of Intel-wired-lan digest..."
>
>
> Today's Topics:
>
> ?? 1. Re: [PATCH v2 1/1] igc: Add initial EEE support (Andre Guedes)
> ?? 2. Re: [PATCH 2/2] e1000e: Make WOL info in ethtool consistent
> ????? with device wake up ability (Michal Kubecek)
> ?? 3. [PATCH 0/2] Make WOL of e1000e consistent with sysfs device
> ????? wakeup (Chen Yu)
> ?? 4. [PATCH 1/2] e1000e: Do not wake up the system via WOL if
> ????? device wakeup is disabled (Chen Yu)
> ?? 5. [PATCH 2/2] e1000e: Make WOL info in ethtool consistent with
> ????? device wake up ability (Chen Yu)
> ?? 6. Re: [PATCH] e1000e: Relax condition to trigger reset for ME
> ????? workaround (Punit Agrawal)
>
>
> ----------------------------------------------------------------------
>
> Message: 1
> Date: Thu, 21 May 2020 11:09:07 -0700
> From: Andre Guedes <andre.guedes@intel.com>
> To: Sasha Neftin <sasha.neftin@intel.com>,
> ??????? intel-wired-lan at lists.osuosl.org
> Subject: Re: [Intel-wired-lan] [PATCH v2 1/1] igc: Add initial EEE
> ??????? support
> Message-ID:
> <159008454769.70366.11413367573186547439@swaranku-mobl2.amr.corp.intel.com>
>
> Content-Type: text/plain; charset="utf-8"
>
> Hi Sasha,
>
> Quoting Sasha Neftin (2020-05-20 22:10:33)
> > diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c 
> b/drivers/net/ethernet/intel/igc/igc_ethtool.c
> > index 2214a5d3a259..3035d3a96621 100644
> > --- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
> > +++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
> [...]
> > +static int igc_ethtool_set_eee(struct net_device *netdev,
> > +????????????????????????????? struct ethtool_eee *edata)
> > +{
> > +?????? struct igc_adapter *adapter = netdev_priv(netdev);
> > +?????? struct igc_hw *hw = &adapter->hw;
> > +?????? struct ethtool_eee eee_curr;
> > +?????? s32 ret_val;
> > +
> > +?????? memset(&eee_curr, 0, sizeof(struct ethtool_eee));
> > +
> > +?????? ret_val = igc_ethtool_get_eee(netdev, &eee_curr);
> > +?????? if (ret_val)
> > +?????????????? return ret_val;
> > +
> > +?????? if (eee_curr.eee_enabled) {
> > +?????????????? if (eee_curr.tx_lpi_enabled != edata->tx_lpi_enabled) {
> > +?????????????????????? netdev_err(netdev,
> > +????????????????????????????????? "Setting EEE tx-lpi is not 
> supported\n");
> > +?????????????????????? return -EINVAL;
> > +?????????????? }
> > +
> > +?????????????? /* Tx LPI timer is not implemented currently */
> > +?????????????? if (edata->tx_lpi_timer) {
> > +?????????????????????? netdev_err(netdev,
> > +????????????????????????????????? "Setting EEE Tx LPI timer is not 
> supported\n");
> > +?????????????????????? return -EINVAL;
> > +?????????????? }
> > +?????? } else if (!edata->eee_enabled) {
> > +?????????????? netdev_err(netdev,
> > +????????????????????????? "Setting EEE options are not supported 
> with EEE disabled\n");
> > +?????????????? return -EINVAL;
> > +?????? }
> > +
> > +?????? adapter->eee_advert = 
> ethtool_adv_to_mmd_eee_adv_t(edata->advertised);
> > +?????? if (hw->dev_spec._base.eee_enable != edata->eee_enabled) {
> > +?????????????? hw->dev_spec._base.eee_enable = edata->eee_enabled;
> > +?????????????? adapter->flags |= IGC_FLAG_EEE;
> > +
> > +?????????????? /* reset link */
> > +?????????????? if (netif_running(netdev))
> > +?????????????????????? igc_reinit_locked(adapter);
> > +?????????????? else
> > +?????????????????????? igc_reset(adapter);
> > +?????? }
> > +
> > +?????? if (ret_val) {
> > +?????????????? netdev_err(netdev,
> > +????????????????????????? "Problem setting EEE advertisement 
> options\n");
> > +?????????????? return -EINVAL;
> > +?????? }
>
> 'ret_val' is already checked in the beginning of this function, and it 
> is not
> set afterwards. So it seems this check is pointless.
>
> > diff --git a/drivers/net/ethernet/intel/igc/igc_main.c 
> b/drivers/net/ethernet/intel/igc/igc_main.c
> > index c4df7129f930..6110093c6ad9 100644
> > --- a/drivers/net/ethernet/intel/igc/igc_main.c
> > +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> [...]
> > @@ -5190,6 +5202,10 @@ static int igc_probe(struct pci_dev *pdev,
> >???????? netdev_info(netdev, "MAC: %pM", netdev->dev_addr);
> >
> >???????? dev_pm_set_driver_flags(&pdev->dev, DPM_FLAG_NEVER_SKIP);
> > +?????? /* Disable EEE for internal copper PHY devices */
> > +?????? hw->dev_spec._base.eee_enable = false;
> > +?????? adapter->flags &= ~IGC_FLAG_EEE;
> > +?????? igc_set_eee_i225(hw, false, false, false);
>
> Could you please clarify if EEE is expected to be enabled or disabled by
> default? IIUC this code, EEE is disabled by default. But in IGB it is 
> enabled
> by default.
>
> In addition to that, the comment above mentions it disables EEE for copper
> devices, but there is no check for such device. Is the comment indeed
> applicable here?
>
> Regards,
>
> Andre
>
>
> ------------------------------
>
> Message: 2
> Date: Thu, 21 May 2020 21:23:42 +0200
> From: Michal Kubecek <mkubecek@suse.cz>
> To: netdev at vger.kernel.org
> Cc: Chen Yu <yu.c.chen@intel.com>, Jeff Kirsher
> ??????? <jeffrey.t.kirsher@intel.com>, "David S. Miller"
> ??????? <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Auke Kok
> ??????? <auke-jan.h.kok@intel.com>, Jeff Garzik <jeff@garzik.org>,
> ??????? intel-wired-lan at lists.osuosl.org, 
> linux-kernel at vger.kernel.org, Len
> ??????? Brown <len.brown@intel.com>, "Rafael J. Wysocki" 
> <rjw@rjwysocki.net>,
> ??????? "Shevchenko, Andriy" <andriy.shevchenko@intel.com>, "Neftin, 
> Sasha"
> ??????? <sasha.neftin@intel.com>, "Lifshits, Vitaly"
> ??????? <vitaly.lifshits@intel.com>, Stable at vger.kernel.org
> Subject: Re: [Intel-wired-lan] [PATCH 2/2] e1000e: Make WOL info in
> ??????? ethtool consistent with device wake up ability
> Message-ID: <20200521192342.GE8771@lion.mk-sys.cz>
> Content-Type: text/plain; charset=us-ascii
>
> On Fri, May 22, 2020 at 01:59:13AM +0800, Chen Yu wrote:
> > Currently the ethtool shows that WOL(Wake On Lan) is enabled
> > even if the device wakeup ability has been disabled via sysfs:
> >?? cat /sys/devices/pci0000:00/0000:00:1f.6/power/wakeup
> >??? disabled
> >
> >?? ethtool eno1
> >?? ...
> >?? Wake-on: g
> >
> > Fix this in ethtool to check if the user has explicitly disabled the
> > wake up ability for this device.
>
> Wouldn't this lead to rather unexpected and inconsistent behaviour when
> the wakeup is disabled? As you don't touch the set_wol handler, I assume
> it will still allow setting enabled modes as usual so that you get e.g.
>
> ? ethtool -s eth0 wol g?? # no error or warning, returns 0
> ? ethtool eth0??????????? # reports no modes enabled
>
> The first command would set the enabled wol modes but that would be
> hidden from user and even the netlink notification would claim something
> different. Another exampe (with kernel and ethtool >= 5.6):
>
> ? ethtool -s eth0 wol g
> ? ethtool -s eth0 wol +m
>
> resulting in "mg" if device wakeup is enabled but "m" when it's disabled
> (but the latter would be hidden from user and only revealed when you
> enable the device wakeup).
>
> This is a general problem discussed recently for EEE and pause
> autonegotiation: if setting A can be effectively used only when B is
> enabled, should we hide actual setting of A from userspace when B is
> disabled or even reset the value of A whenever B gets toggled or rather
> allow setting A and B independently? AFAICS the consensus seemed to be
> that A should be allowed to be set and queried independently of the
> value of B.
>
> Michal
>
> > Fixes: 6ff68026f475 ("e1000e: Use device_set_wakeup_enable")
> > Reported-by: Len Brown <len.brown@intel.com>
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Cc: <Stable@vger.kernel.org>
> > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > ---
> >? drivers/net/ethernet/intel/e1000e/ethtool.c | 2 +-
> >? 1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/intel/e1000e/ethtool.c 
> b/drivers/net/ethernet/intel/e1000e/ethtool.c
> > index 1d47e2503072..0cccd823ff24 100644
> > --- a/drivers/net/ethernet/intel/e1000e/ethtool.c
> > +++ b/drivers/net/ethernet/intel/e1000e/ethtool.c
> > @@ -1891,7 +1891,7 @@ static void e1000_get_wol(struct net_device 
> *netdev,
> >??????? wol->wolopts = 0;
> >
> >??????? if (!(adapter->flags & FLAG_HAS_WOL) ||
> > - !device_can_wakeup(&adapter->pdev->dev))
> > + !device_may_wakeup(&adapter->pdev->dev))
> >??????????????? return;
> >
> >??????? wol->supported = WAKE_UCAST | WAKE_MCAST |
> > --
> > 2.17.1
> >
>
>
> ------------------------------
>
> Message: 3
> Date: Fri, 22 May 2020 01:58:02 +0800
> From: Chen Yu <yu.c.chen@intel.com>
> To: Jeff Kirsher <jeffrey.t.kirsher@intel.com>, "David S. Miller"
> ??????? <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Auke Kok
> ??????? <auke-jan.h.kok@intel.com>, Jeff Garzik <jeff@garzik.org>
> Cc: intel-wired-lan at lists.osuosl.org, netdev at vger.kernel.org,
> ??????? linux-kernel at vger.kernel.org, Len Brown <len.brown@intel.com>, 
> "Rafael
> ??????? J. Wysocki" <rjw@rjwysocki.net>, "Shevchenko, Andriy"
> ??????? <andriy.shevchenko@intel.com>, "Neftin, Sasha"
> ??????? <sasha.neftin@intel.com>, "Lifshits, Vitaly"
> ??????? <vitaly.lifshits@intel.com>, Chen Yu <yu.c.chen@intel.com>
> Subject: [Intel-wired-lan] [PATCH 0/2] Make WOL of e1000e consistent
> ??????? with sysfs device wakeup
> Message-ID: <cover.1590081982.git.yu.c.chen@intel.com>
>
> Currently the WOL(Wake On Lan) bahavior of e1000e is not consistent 
> with its corresponding
> device wake up ability.
> Fix this by:
> 1. Do not wake up the system via WOL if device wakeup is disabled
> 2. Make WOL display info from ethtool consistent with device wake up
> ?? settings in sysfs
>
> Chen Yu (2):
> ? e1000e: Do not wake up the system via WOL if device wakeup is disabled
> ? e1000e: Make WOL info in ethtool consistent with device wake up
> ??? ability
>
> ?drivers/net/ethernet/intel/e1000e/ethtool.c |? 2 +-
> ?drivers/net/ethernet/intel/e1000e/netdev.c? | 14 ++++++++++----
> ?2 files changed, 11 insertions(+), 5 deletions(-)
>
> -- 
> 2.17.1
>
>
>
> ------------------------------
>
> Message: 4
> Date: Fri, 22 May 2020 01:59:00 +0800
> From: Chen Yu <yu.c.chen@intel.com>
> To: Jeff Kirsher <jeffrey.t.kirsher@intel.com>, "David S. Miller"
> ??????? <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Auke Kok
> ??????? <auke-jan.h.kok@intel.com>, Jeff Garzik <jeff@garzik.org>
> Cc: intel-wired-lan at lists.osuosl.org, netdev at vger.kernel.org,
> ??????? linux-kernel at vger.kernel.org, Len Brown <len.brown@intel.com>, 
> "Rafael
> ??????? J. Wysocki" <rjw@rjwysocki.net>, "Shevchenko, Andriy"
> ??????? <andriy.shevchenko@intel.com>, "Neftin, Sasha"
> ??????? <sasha.neftin@intel.com>, "Lifshits, Vitaly"
> ??????? <vitaly.lifshits@intel.com>, Chen Yu <yu.c.chen@intel.com>,
> ??????? Stable at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH 1/2] e1000e: Do not wake up the
> ??????? system via WOL if device wakeup is disabled
> Message-ID:
> <9f7ede2e2e8152704258fc11ba3755ae93f50741.1590081982.git.yu.c.chen@intel.com>
>
>
> Currently the system will be woken up via WOL(Wake On Lan) even if the
> device wakeup ability has been disabled via sysfs:
> ?cat /sys/devices/pci0000:00/0000:00:1f.6/power/wakeup
> ?disabled
>
> The system should not be woken up if the user has explicitly
> disabled the wake up ability for this device.
>
> This patch clears the WOL ability of this network device if the
> user has disabled the wake up ability in sysfs.
>
> Fixes: bc7f75fa9788 ("[E1000E]: New pci-express e1000 driver")
> Reported-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: <Stable@vger.kernel.org>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
> ?drivers/net/ethernet/intel/e1000e/netdev.c | 14 ++++++++++----
> ?1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c 
> b/drivers/net/ethernet/intel/e1000e/netdev.c
> index 177c6da80c57..f6f730388705 100644
> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> @@ -6516,11 +6516,17 @@ static int __e1000_shutdown(struct pci_dev 
> *pdev, bool runtime)
> ???????? struct net_device *netdev = pci_get_drvdata(pdev);
> ???????? struct e1000_adapter *adapter = netdev_priv(netdev);
> ???????? struct e1000_hw *hw = &adapter->hw;
> -?????? u32 ctrl, ctrl_ext, rctl, status;
> -?????? /* Runtime suspend should only enable wakeup for link changes */
> -?????? u32 wufc = runtime ? E1000_WUFC_LNKC : adapter->wol;
> +?????? u32 ctrl, ctrl_ext, rctl, status, wufc;
> ???????? int retval = 0;
>
> +?????? /* Runtime suspend should only enable wakeup for link changes */
> +?????? if (runtime)
> +?????????????? wufc = E1000_WUFC_LNKC;
> +?????? else if (device_may_wakeup(&pdev->dev))
> +?????????????? wufc = adapter->wol;
> +?????? else
> +?????????????? wufc = 0;
> +
> ???????? status = er32(STATUS);
> ???????? if (status & E1000_STATUS_LU)
> ???????????????? wufc &= ~E1000_WUFC_LNKC;
> @@ -6577,7 +6583,7 @@ static int __e1000_shutdown(struct pci_dev 
> *pdev, bool runtime)
> ???????? if (adapter->hw.phy.type == e1000_phy_igp_3) {
> e1000e_igp3_phy_powerdown_workaround_ich8lan(&adapter->hw);
> ???????? } else if (hw->mac.type >= e1000_pch_lpt) {
> -?????????????? if (!(wufc & (E1000_WUFC_EX | E1000_WUFC_MC | 
> E1000_WUFC_BC)))
> +?????????????? if (wufc && !(wufc & (E1000_WUFC_EX | E1000_WUFC_MC | 
> E1000_WUFC_BC)))
> ???????????????????????? /* ULP does not support wake from unicast, 
> multicast
> ????????????????????????? * or broadcast.
> ????????????????????????? */
> -- 
> 2.17.1
>
>
>
> ------------------------------
>
> Message: 5
> Date: Fri, 22 May 2020 01:59:13 +0800
> From: Chen Yu <yu.c.chen@intel.com>
> To: Jeff Kirsher <jeffrey.t.kirsher@intel.com>, "David S. Miller"
> ??????? <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Auke Kok
> ??????? <auke-jan.h.kok@intel.com>, Jeff Garzik <jeff@garzik.org>
> Cc: intel-wired-lan at lists.osuosl.org, netdev at vger.kernel.org,
> ??????? linux-kernel at vger.kernel.org, Len Brown <len.brown@intel.com>, 
> "Rafael
> ??????? J. Wysocki" <rjw@rjwysocki.net>, "Shevchenko, Andriy"
> ??????? <andriy.shevchenko@intel.com>, "Neftin, Sasha"
> ??????? <sasha.neftin@intel.com>, "Lifshits, Vitaly"
> ??????? <vitaly.lifshits@intel.com>, Chen Yu <yu.c.chen@intel.com>,
> ??????? Stable at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH 2/2] e1000e: Make WOL info in
> ??????? ethtool consistent with device wake up ability
> Message-ID:
> <725bad2f3ce7f7b7f1667d53b6527dc059f9e419.1590081982.git.yu.c.chen@intel.com>
>
>
> Currently the ethtool shows that WOL(Wake On Lan) is enabled
> even if the device wakeup ability has been disabled via sysfs:
> ? cat /sys/devices/pci0000:00/0000:00:1f.6/power/wakeup
> ?? disabled
>
> ? ethtool eno1
> ? ...
> ? Wake-on: g
>
> Fix this in ethtool to check if the user has explicitly disabled the
> wake up ability for this device.
>
> Fixes: 6ff68026f475 ("e1000e: Use device_set_wakeup_enable")
> Reported-by: Len Brown <len.brown@intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: <Stable@vger.kernel.org>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> ---
> ?drivers/net/ethernet/intel/e1000e/ethtool.c | 2 +-
> ?1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/intel/e1000e/ethtool.c 
> b/drivers/net/ethernet/intel/e1000e/ethtool.c
> index 1d47e2503072..0cccd823ff24 100644
> --- a/drivers/net/ethernet/intel/e1000e/ethtool.c
> +++ b/drivers/net/ethernet/intel/e1000e/ethtool.c
> @@ -1891,7 +1891,7 @@ static void e1000_get_wol(struct net_device *netdev,
> ???????? wol->wolopts = 0;
>
> ???????? if (!(adapter->flags & FLAG_HAS_WOL) ||
> - !device_can_wakeup(&adapter->pdev->dev))
> + !device_may_wakeup(&adapter->pdev->dev))
> ???????????????? return;
>
> ???????? wol->supported = WAKE_UCAST | WAKE_MCAST |
> -- 
> 2.17.1
>
>
>
> ------------------------------
>
> Message: 6
> Date: Fri, 22 May 2020 12:20:57 +0900
> From: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
> To: "Brown\, Aaron F" <aaron.f.brown@intel.com>
> Cc: "Kirsher\, Jeffrey T" <jeffrey.t.kirsher@intel.com>,
> ??????? "daniel.sangorrin\@toshiba.co.jp" 
> <daniel.sangorrin@toshiba.co.jp>,
> ??????? Alexander Duyck <alexander.h.duyck@linux.intel.com>, "David S. 
> Miller"
> ??????? <davem@davemloft.net>, "intel-wired-lan\@lists.osuosl.org"
> ??????? <intel-wired-lan@lists.osuosl.org>, "netdev\@vger.kernel.org"
> ??????? <netdev@vger.kernel.org>, "linux-kernel\@vger.kernel.org"
> ??????? <linux-kernel@vger.kernel.org>
> Subject: Re: [Intel-wired-lan] [PATCH] e1000e: Relax condition to
> ??????? trigger reset for ME workaround
> Message-ID: <87367sac4m.fsf@kokedama.swc.toshiba.co.jp>
> Content-Type: text/plain
>
> Hi Aaron,
>
> "Brown, Aaron F" <aaron.f.brown@intel.com> writes:
>
> >> From: netdev-owner at vger.kernel.org <netdev-owner@vger.kernel.org> On
> >> Behalf Of Punit Agrawal
> >> Sent: Thursday, May 14, 2020 9:31 PM
> >> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
> >> Cc: daniel.sangorrin at toshiba.co.jp; Punit Agrawal
> >> <punit1.agrawal@toshiba.co.jp>; Alexander Duyck
> >> <alexander.h.duyck@linux.intel.com>; David S. Miller 
> <davem@davemloft.net>;
> >> intel-wired-lan at lists.osuosl.org; netdev at vger.kernel.org; linux-
> >> kernel at vger.kernel.org
> >> Subject: [PATCH] e1000e: Relax condition to trigger reset for ME 
> workaround
> >>
> >> It's an error if the value of the RX/TX tail descriptor does not match
> >> what was written. The error condition is true regardless the duration
> >> of the interference from ME. But the driver only performs the reset if
> >> E1000_ICH_FWSM_PCIM2PCI_COUNT (2000) iterations of 50us delay have
> >> transpired. The extra condition can lead to inconsistency between the
> >> state of hardware as expected by the driver.
> >>
> >> Fix this by dropping the check for number of delay iterations.
> >>
> >> While at it, also make __ew32_prepare() static as it's not used
> >> anywhere else.
> >>
> >> Signed-off-by: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
> >> Reviewed-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> >> Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> >> Cc: "David S. Miller" <davem@davemloft.net>
> >> Cc: intel-wired-lan at lists.osuosl.org
> >> Cc: netdev at vger.kernel.org
> >> Cc: linux-kernel at vger.kernel.org
> >> ---
> >> Hi Jeff,
> >>
> >> If there are no further comments please consider merging the patch.
> >>
> >> Also, should it be marked for backport to stable?
> >>
> >> Thanks,
> >> Punit
> >>
> >> RFC[0] -> v1:
> >> * Dropped return value for __ew32_prepare() as it's not used
> >> * Made __ew32_prepare() static
> >> * Added tags
> >>
> >> [0] https://lkml.org/lkml/2020/5/12/20
> >>
> >>? drivers/net/ethernet/intel/e1000e/e1000.h? |? 1 -
> >>? drivers/net/ethernet/intel/e1000e/netdev.c | 12 +++++-------
> >>? 2 files changed, 5 insertions(+), 8 deletions(-)
> >>
> > Tested-by: Aaron Brown <aaron.f.brown@intel.com>
>
> Thanks for taking the patch for a spin.
>
> Jeff, let me know if you're okay to apply the tag or want me to send a
> new version.
>
>
> Thanks,
> Punit
>
Hi Punit,

This patch appears to be effecting some legacy code effecting old hardware.
We tried applying it but we could not get the driver to run the changed 
code lines.
Please provide some test hints(What platforms did you check it on? What 
tests did you run?) regarding this patch.

Thanks,
Amir
>
>
>
>
> ------------------------------
>
> Subject: Digest Footer
>
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
>
>
> ------------------------------
>
> End of Intel-wired-lan Digest, Vol 268, Issue 43
> ************************************************
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20200528/87724f33/attachment-0001.html>
