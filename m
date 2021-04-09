From: xiao33522@qq.com <xiao33522@qq.com>
Date: Fri,  9 Apr 2021 17:17:47 +0800
Subject: [Intel-wired-lan] [PATCH] i40e: The state of phy may not be correct
 during power-on
Message-ID: <tencent_A3F0B1FAA65495EB2220B5B72EB6E5AF1B07@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: xiaolinkui <xiaolinkui@kylinos.cn>

Sometimes the power on state of the x710 network card indicator is not right,
and the indicator shows orange. At this time, the network card speed is Gigabit.

After entering the system, check the network card status through the ethtool
command as follows:

[root at localhost ~]# ethtool enp132s0f0
Settings for enp132s0f0:
	Supported ports: [ FIBRE ]
	Supported link modes:   1000baseX/Full
	                        10000baseSR/Full
	Supported pause frame use: Symmetric
	Supports auto-negotiation: Yes
	Supported FEC modes: Not reported
	Advertised link modes:  1000baseX/Full
	                        10000baseSR/Full
	Advertised pause frame use: No
	Advertised auto-negotiation: Yes
	Advertised FEC modes: Not reported
	Speed: 1000Mb/s
	Duplex: Full
	Port: FIBRE
	PHYAD: 0
	Transceiver: internal
	Auto-negotiation: off
	Supports Wake-on: d
	Wake-on: d
	Current message level: 0x00000007 (7)
			       drv probe link
	Link detected: yes

We can see that the speed is 1000Mb/s.

If you unplug and plug in the optical cable, it can be restored to 10g.
After this operation, the rate is as follows:

[root at localhost ~]# ethtool enp132s0f0
Settings for enp132s0f0:
        Supported ports: [ FIBRE ]
        Supported link modes:   1000baseX/Full
                                10000baseSR/Full
        Supported pause frame use: Symmetric
        Supports auto-negotiation: Yes
        Supported FEC modes: Not reported
        Advertised link modes:  1000baseX/Full
                                10000baseSR/Full
        Advertised pause frame use: No
        Advertised auto-negotiation: Yes
        Advertised FEC modes: Not reported
        Speed: 10000Mb/s
        Duplex: Full
        Port: FIBRE
        PHYAD: 0
        Transceiver: internal
        Auto-negotiation: off
        Supports Wake-on: d
        Wake-on: d
        Current message level: 0x00000007 (7)
                               drv probe link
        Link detected: yes

Calling i40e_aq_set_link_restart_an can also achieve this function.
So we need to do a reset operation for the network card when the network card
status is abnormal.

Signed-off-by: xiaolinkui <xiaolinkui@kylinos.cn>
---
 drivers/net/ethernet/intel/i40e/i40e_common.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index ec19e18305ec..dde0224776ac 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -1866,6 +1866,10 @@ i40e_status i40e_aq_get_link_info(struct i40e_hw *hw,
 	hw_link_info->max_frame_size = le16_to_cpu(resp->max_frame_size);
 	hw_link_info->pacing = resp->config & I40E_AQ_CONFIG_PACING_MASK;
 
+	if (hw_link_info->phy_type == I40E_PHY_TYPE_1000BASE_SX &&
+	    hw->mac.type == I40E_MAC_XL710)
+		i40e_aq_set_link_restart_an(hw, true, NULL);
+
 	/* update fc info */
 	tx_pause = !!(resp->an_info & I40E_AQ_LINK_PAUSE_TX);
 	rx_pause = !!(resp->an_info & I40E_AQ_LINK_PAUSE_RX);
-- 
2.17.1

