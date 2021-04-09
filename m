From: Kubalewski, Arkadiusz <arkadiusz.kubalewski@intel.com>
Date: Fri, 9 Apr 2021 18:12:35 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: The state of phy may not be
 correct during power-on
In-Reply-To: <tencent_A3F0B1FAA65495EB2220B5B72EB6E5AF1B07@qq.com>
References: <tencent_A3F0B1FAA65495EB2220B5B72EB6E5AF1B07@qq.com>
Message-ID: <DM6PR11MB4657EB5A8040E7D5A9CB155E9B739@DM6PR11MB4657.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

>-----Original Message-----
>From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of xiao33522 at qq.com
>Sent: pi?tek, 9 kwietnia 2021 11:18
>To: Brandeburg, Jesse <jesse.brandeburg@intel.com>; Nguyen, Anthony L <anthony.l.nguyen@intel.com>
>Cc: netdev at vger.kernel.org; xiaolinkui <xiaolinkui@kylinos.cn>; linux-kernel at vger.kernel.org; intel-wired-lan at lists.osuosl.org; kuba at kernel.org; davem at davemloft.net
>Subject: [Intel-wired-lan] [PATCH] i40e: The state of phy may not be correct during power-on
>
>From: xiaolinkui <xiaolinkui@kylinos.cn>
>
>Sometimes the power on state of the x710 network card indicator is not right, and the indicator shows orange. At this time, the network card speed is Gigabit.

By "power on state" you mean that it happens after power-up of the server?

>
>After entering the system, check the network card status through the ethtool command as follows:
>
>[root at localhost ~]# ethtool enp132s0f0
>Settings for enp132s0f0:
>	Supported ports: [ FIBRE ]
>	Supported link modes:   1000baseX/Full
>	                        10000baseSR/Full
>	Supported pause frame use: Symmetric
>	Supports auto-negotiation: Yes
>	Supported FEC modes: Not reported
>	Advertised link modes:  1000baseX/Full
>	                        10000baseSR/Full
>	Advertised pause frame use: No
>	Advertised auto-negotiation: Yes
>	Advertised FEC modes: Not reported
>	Speed: 1000Mb/s
>	Duplex: Full
>	Port: FIBRE
>	PHYAD: 0
>	Transceiver: internal
>	Auto-negotiation: off
>	Supports Wake-on: d
>	Wake-on: d
>	Current message level: 0x00000007 (7)
>			       drv probe link
>	Link detected: yes
>
>We can see that the speed is 1000Mb/s.
>
>If you unplug and plug in the optical cable, it can be restored to 10g.
>After this operation, the rate is as follows:
>
>[root at localhost ~]# ethtool enp132s0f0
>Settings for enp132s0f0:
>        Supported ports: [ FIBRE ]
>        Supported link modes:   1000baseX/Full
>                                10000baseSR/Full
>        Supported pause frame use: Symmetric
>        Supports auto-negotiation: Yes
>        Supported FEC modes: Not reported
>        Advertised link modes:  1000baseX/Full
>                                10000baseSR/Full
>        Advertised pause frame use: No
>        Advertised auto-negotiation: Yes
>        Advertised FEC modes: Not reported
>        Speed: 10000Mb/s
>        Duplex: Full
>        Port: FIBRE
>        PHYAD: 0
>        Transceiver: internal
>        Auto-negotiation: off
>        Supports Wake-on: d
>        Wake-on: d
>        Current message level: 0x00000007 (7)
>                               drv probe link
>        Link detected: yes
>
>Calling i40e_aq_set_link_restart_an can also achieve this function.
>So we need to do a reset operation for the network card when the network card status is abnormal.

Can't say much about the root cause of the issue right now,
but I don't think it is good idea for the fix.
This leads to braking existing link each time 
i40e_aq_get_link_info is called on 1 Gigabit PHY.
For example 'ethtool -m <dev>' does that.

Have you tried reloading the driver?
Thanks!

>
>Signed-off-by: xiaolinkui <xiaolinkui@kylinos.cn>
>---
> drivers/net/ethernet/intel/i40e/i40e_common.c | 4 ++++
> 1 file changed, 4 insertions(+)
>
>diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
>index ec19e18305ec..dde0224776ac 100644
>--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
>+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
>@@ -1866,6 +1866,10 @@ i40e_status i40e_aq_get_link_info(struct i40e_hw *hw,
> 	hw_link_info->max_frame_size = le16_to_cpu(resp->max_frame_size);
> 	hw_link_info->pacing = resp->config & I40E_AQ_CONFIG_PACING_MASK;
> 
>+	if (hw_link_info->phy_type == I40E_PHY_TYPE_1000BASE_SX &&
>+	    hw->mac.type == I40E_MAC_XL710)
>+		i40e_aq_set_link_restart_an(hw, true, NULL);
>+
> 	/* update fc info */
> 	tx_pause = !!(resp->an_info & I40E_AQ_LINK_PAUSE_TX);
> 	rx_pause = !!(resp->an_info & I40E_AQ_LINK_PAUSE_RX);
>--
>2.17.1
>
>_______________________________________________
>Intel-wired-lan mailing list
>Intel-wired-lan at osuosl.org
>https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
>
