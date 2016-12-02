From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Fri,  2 Dec 2016 12:33:01 -0800
Subject: [Intel-wired-lan] [next PATCH S56 7/8] i40e: Save more link
	abilities when using ethtool
In-Reply-To: <1480710782-9195-1-git-send-email-bimmy.pujari@intel.com>
References: <1480710782-9195-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1480710782-9195-8-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Henry Tieman <henry.w.tieman@intel.com>

Ethtool support needs to save more PHY information. The
added information includes FEC capabilities and 25G link
types. Without this change it is possible to lose 25G or
FEC settings by using ethtool.

Signed-off-by: Henry Tieman <henry.w.tieman@intel.com>
Change-ID: Ie42255b1e901ffbf9583b8c46466a54894114280
---
Testing Hints: Found by code inspection. Test by changing
link speed from 25G to 10G and back to 25G using ethtool.

 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index f9f71fb..dece0d6 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -803,9 +803,12 @@ static int i40e_set_settings(struct net_device *netdev,
 	if (change || (abilities.link_speed != config.link_speed)) {
 		/* copy over the rest of the abilities */
 		config.phy_type = abilities.phy_type;
+		config.phy_type_ext = abilities.phy_type_ext;
 		config.eee_capability = abilities.eee_capability;
 		config.eeer = abilities.eeer_val;
 		config.low_power_ctrl = abilities.d3_lpan;
+		config.fec_config = abilities.fec_cfg_curr_mod_ext_info &
+				    I40E_AQ_PHY_FEC_CONFIG_MASK;
 
 		/* save the requested speeds */
 		hw->phy.link_info.requested_speeds = config.link_speed;
-- 
2.4.11

