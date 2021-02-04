From: Dvora Fuxbrumer <dvorax.fuxbrumer@linux.intel.com>
Date: Thu, 4 Feb 2021 12:05:37 +0200
Subject: [Intel-wired-lan] igc: fix link speed advertising
In-Reply-To: <79cb04f0-1a93-f463-3131-ad7772eab202@intel.com>
References: <20210127092421.GS4393@calimero.vinschen.de>
 <79cb04f0-1a93-f463-3131-ad7772eab202@intel.com>
Message-ID: <e955280d-305a-70a4-f74a-8cf9b2a07e1f@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> 
> 
> 
> -------- Forwarded Message --------
> Subject: Re: [Fwd: igc: fix link speed advertising]
> Date: Wed, 27 Jan 2021 10:24:21 +0100
> From: Corinna Vinschen <vinschen@redhat.com>
> To: Yang, Lihong <lihong.yang@intel.com>
> CC: Pathi, Pragyansri <pragyansri.pathi@intel.com>, Don Bayly 
> <dbayly@redhat.com>, Neftin, Sasha <sasha.neftin@intel.com>, Nguyen, 
> Anthony L <anthony.l.nguyen@intel.com>
> 
> Hi Lihong,
> Hi Tony,
> 
> 
> Thanks a lot to both of you!
> 
> 
> Corinna
> 
> 
> On Jan 26 23:58, Yang, Lihong wrote:
>> Hi Corinna,
>>
>> A quick update. Your patch[1] was just sent by Tony to net as part of 
>> the bug-fix series. Hopefully it will be accepted soon.
>> Thanks,
>> Lihong
>>
>> [1] 
>> https://patchwork.kernel.org/project/netdevbpf/patch/20210126221035.658124-8-anthony.l.nguyen at intel.com/ 
>>
>>
>>
>> > -----Original Message-----
>> > From: Yang, Lihong
>> > Sent: Tuesday, January 26, 2021 11:02 AM
>> > To: Corinna Vinschen <vinschen@redhat.com>
>> > Cc: Pathi, Pragyansri <pragyansri.pathi@intel.com>; Don Bayly
>> > <dbayly@redhat.com>; Neftin, Sasha <sasha.neftin@intel.com>; Nguyen,
>> > Anthony L <anthony.l.nguyen@intel.com>
>> > Subject: RE: [Fwd: igc: fix link speed advertising]
>> > > Hi Corinna,
>> > > From the info I gathered, the reason your patch has not been sent 
>> Linux
>> > upstream is because it has not been validated from Intel side. Once 
>> it is
>> > tagged with a Tested-by, it should be ready to go up.
>> > > I am adding Sasha from the igc driver team to be aware of your 
>> inquiry,
>> > and Tony our Networking maintainer as an FYI.
>> > > Thanks,
>> > Lihong
>> > > > -----Original Message-----
>> > > From: Corinna Vinschen <vinschen@redhat.com>
>> > > Sent: Tuesday, January 26, 2021 02:37 AM
>> > > To: Yang, Lihong <lihong.yang@intel.com>
>> > > Subject: [Fwd: igc: fix link speed advertising]
>> > >
>> > > Hi Lihong,
>> > >
>> > > I sent this patch to the Intel-wired-lan and netdev mailing lists
>> > > in November already.? I got no reply but it looked like it had been
>> > > included into the test runs from the "kernel test robot" output.
>> > >
>> > > So I expected this is going upstream for the next kernel version, 
>> but it
>> > > didn't make it into net-next yet.? I was hoping this can go into RHEL
>> > > 8.4, but it's getting really late now.
>> > >
>> > > I pinged the mailing lists again, but, would you mind to check
>> > > internally, if there's some reason not to include it?
>> > >
>> > >
>> > > Thanks a lot!
>> > > Corinna
>> > >
>> > >
>> > > ----- Forwarded message from Corinna Vinschen 
>> <vinschen@redhat.com> ----
>> > -
>> > >
>> > > > Date: Tue, 17 Nov 2020 20:50:40 +0100
>> > > > From: Corinna Vinschen <vinschen@redhat.com>
>> > > > To: intel-wired-lan at lists.osuosl.org, netdev at vger.kernel.org
>> > > > Subject: [Intel-wired-lan] igc: fix link speed advertising
>> > > >
>> > > > Link speed advertising in igc has two problems:
>> > > >
>> > > > - When setting the advertisement via ethtool, the link speed is
>> > > converted
>> > > >?? to the legacy 32 bit representation for the intel PHY code.
>> > > >?? This inadvertently drops ETHTOOL_LINK_MODE_2500baseT_Full_BIT 
>> (being
>> > > >?? beyond bit 31).? As a result, any call to `ethtool -s ...' 
>> drops the
>> > > >?? 2500Mbit/s link speed from the PHY settings.? Only reloading the
>> > > driver
>> > > >?? alleviates that problem.
>> > > >
>> > > >?? Fix this by converting the 
>> ETHTOOL_LINK_MODE_2500baseT_Full_BIT to
>> > the
>> > > >?? Intel PHY ADVERTISE_2500_FULL bit explicitely.
>> > > >
>> > > > - Rather than checking the actual PHY setting, the 
>> .get_link_ksettings
>> > > >?? function always fills link_modes.advertising with all link speeds
>> > > >?? the device is capable of.
>> > > >
>> > > >?? Fix this by checking the PHY autoneg_advertised settings and 
>> report
>> > > >?? only the actually advertised speeds up to ethtool.
>> > > >
>> > > > Signed-off-by: Corinna Vinschen <vinschen@redhat.com>
>> > > > ---
>> > > >? drivers/net/ethernet/intel/igc/igc_ethtool.c | 24 
>> +++++++++++++++----
>> > -
>> > > >? 1 file changed, 18 insertions(+), 6 deletions(-)
>> > > >
>> > > > diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c
>> > > b/drivers/net/ethernet/intel/igc/igc_ethtool.c
>> > > > index 61d331ce38cd..75cb4ca36bac 100644
>> > > > --- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
>> > > > +++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
>> > > > @@ -1675,12 +1675,18 @@ static int
>> > igc_ethtool_get_link_ksettings(struct
>> > > net_device *netdev,
>> > > >????? cmd->base.phy_address = hw->phy.addr;
>> > > >
>> > > >????? /* advertising link modes */
>> > > > -??? ethtool_link_ksettings_add_link_mode(cmd, advertising, 
>> 10baseT_Half);
>> > > > -??? ethtool_link_ksettings_add_link_mode(cmd, advertising, 
>> 10baseT_Full);
>> > > > -??? ethtool_link_ksettings_add_link_mode(cmd, advertising,
>> > > 100baseT_Half);
>> > > > -??? ethtool_link_ksettings_add_link_mode(cmd, advertising,
>> > > 100baseT_Full);
>> > > > -??? ethtool_link_ksettings_add_link_mode(cmd, advertising,
>> > > 1000baseT_Full);
>> > > > -??? ethtool_link_ksettings_add_link_mode(cmd, advertising,
>> > > 2500baseT_Full);
>> > > > +??? if (hw->phy.autoneg_advertised & ADVERTISE_10_HALF)
>> > > > +??????? ethtool_link_ksettings_add_link_mode(cmd, advertising,
>> > > 10baseT_Half);
>> > > > +??? if (hw->phy.autoneg_advertised & ADVERTISE_10_FULL)
>> > > > +??????? ethtool_link_ksettings_add_link_mode(cmd, advertising,
>> > > 10baseT_Full);
>> > > > +??? if (hw->phy.autoneg_advertised & ADVERTISE_100_HALF)
>> > > > +??????? ethtool_link_ksettings_add_link_mode(cmd, advertising,
>> > > 100baseT_Half);
>> > > > +??? if (hw->phy.autoneg_advertised & ADVERTISE_100_FULL)
>> > > > +??????? ethtool_link_ksettings_add_link_mode(cmd, advertising,
>> > > 100baseT_Full);
>> > > > +??? if (hw->phy.autoneg_advertised & ADVERTISE_1000_FULL)
>> > > > +??????? ethtool_link_ksettings_add_link_mode(cmd, advertising,
>> > > 1000baseT_Full);
>> > > > +??? if (hw->phy.autoneg_advertised & ADVERTISE_2500_FULL)
>> > > > +??????? ethtool_link_ksettings_add_link_mode(cmd, advertising,
>> > > 2500baseT_Full);
>> > > >
>> > > >????? /* set autoneg settings */
>> > > >????? if (hw->mac.autoneg == 1) {
>> > > > @@ -1792,6 +1798,12 @@ igc_ethtool_set_link_ksettings(struct
>> > net_device
>> > > *netdev,
>> > > >
>> > > >????? ethtool_convert_link_mode_to_legacy_u32(&advertising,
>> > > >????????????????????????? cmd->link_modes.advertising);
>> > > > +??? /* Converting to legacy u32 drops
>> > > ETHTOOL_LINK_MODE_2500baseT_Full_BIT.
>> > > > +???? * We have to check this and convert it to ADVERTISE_2500_FULL
>> > > > +???? * (aka ETHTOOL_LINK_MODE_2500baseX_Full_BIT) explicitely.
>> > > > +???? */
>> > > > +??? if (ethtool_link_ksettings_test_link_mode(cmd, advertising,
>> > > 2500baseT_Full))
>> > > > +??????? advertising |= ADVERTISE_2500_FULL;
>> > > >
>> > > >????? if (cmd->base.autoneg == AUTONEG_ENABLE) {
>> > > >????????? hw->mac.autoneg = 1;
>> > > > --
>> > > > 2.27.0
>> > > >
>> > > > _______________________________________________
>> > > > Intel-wired-lan mailing list
>> > > > Intel-wired-lan at osuosl.org
>> > > > https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
>> > >
>> > > ----- End forwarded message -----
>>
> 
Tested-by: Dvora Fuxbrumer <dvorax.fuxbrumer@linux.intel.com>
