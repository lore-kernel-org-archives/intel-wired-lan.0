From: Anjali Singhai Jain <anjali.singhai@intel.com>
Date: Wed,  6 Jan 2016 11:49:28 -0800
Subject: [Intel-wired-lan] [PATCH] i40e: Enable Geneve offload for FW API
	ver > 1.4 for XL710/X710 devices
Message-ID: <1452109768-89575-1-git-send-email-anjali.singhai@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch makes sure we check the GENEVE offload capable flag before
we attempt offload.
It also enables the Capability for XL710/X710 devices with FW API
version higher than 1.4

Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 5375d3e..2332fa1 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -5352,7 +5352,8 @@ int i40e_open(struct net_device *netdev)
 	vxlan_get_rx_port(netdev);
 #endif
 #ifdef CONFIG_I40E_GENEVE
-	geneve_get_rx_port(netdev);
+	if (pf->flags & I40E_FLAG_GENEVE_OFFLOAD_CAPABLE)
+		geneve_get_rx_port(netdev);
 #endif
 
 	return 0;
@@ -8458,7 +8459,13 @@ static int i40e_sw_init(struct i40e_pf *pf)
 			     I40E_FLAG_MULTIPLE_TCP_UDP_RSS_PCTYPE |
 			     I40E_FLAG_100M_SGMII_CAPABLE |
 			     I40E_FLAG_GENEVE_OFFLOAD_CAPABLE;
+	} else if ((pf->hw.aq.api_maj_ver > 1) ||
+		   ((pf->hw.aq.api_maj_ver == 1) &&
+		    (pf->hw.aq.api_min_ver > 4))) {
+		/* Supported in FW API version higher than 1.4 */
+		pf->flags |= I40E_FLAG_GENEVE_OFFLOAD_CAPABLE;
 	}
+
 	pf->eeprom_version = 0xDEAD;
 	pf->lan_veb = I40E_NO_VEB;
 	pf->lan_vsi = I40E_NO_VSI;
@@ -8673,6 +8680,9 @@ static void i40e_add_geneve_port(struct net_device *netdev,
 	u8 next_idx;
 	u8 idx;
 
+	if (!(pf->flags & I40E_FLAG_GENEVE_OFFLOAD_CAPABLE))
+		return;
+
 	if (sa_family == AF_INET6)
 		return;
 
@@ -8722,6 +8732,9 @@ static void i40e_del_geneve_port(struct net_device *netdev,
 	if (sa_family == AF_INET6)
 		return;
 
+	if (!(pf->flags & I40E_FLAG_GENEVE_OFFLOAD_CAPABLE))
+		return;
+
 	idx = i40e_get_udp_port_idx(pf, port);
 
 	/* Check if port already exists */
-- 
1.8.1.4

