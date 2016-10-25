From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Tue, 25 Oct 2016 15:17:58 -0700
Subject: [Intel-wired-lan] [next PATCH S51 4/9] i40e: remove second check of
	VLAN_N_VID in i40e_vlan_rx_add_vid
In-Reply-To: <1477433883-3248-1-git-send-email-bimmy.pujari@intel.com>
References: <1477433883-3248-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1477433883-3248-5-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

Replace a check of magic number 4095 with VLAN_N_VID. This
makes it obvious that a later check against VLAN_N_VID is
always true and can be removed

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Change-ID: I28998f127a61a529480ce63d8a07e266f6c63b7b
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 3a759ea..ed71d4d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -2591,7 +2591,7 @@ static int i40e_vlan_rx_add_vid(struct net_device *netdev,
 	struct i40e_vsi *vsi = np->vsi;
 	int ret = 0;
 
-	if (vid > 4095)
+	if (vid >= VLAN_N_VID)
 		return -EINVAL;
 
 	/* If the network stack called us with vid = 0 then
@@ -2603,7 +2603,7 @@ static int i40e_vlan_rx_add_vid(struct net_device *netdev,
 	if (vid)
 		ret = i40e_vsi_add_vlan(vsi, vid);
 
-	if (!ret && (vid < VLAN_N_VID))
+	if (!ret)
 		set_bit(vid, vsi->active_vlans);
 
 	return ret;
-- 
2.4.11

