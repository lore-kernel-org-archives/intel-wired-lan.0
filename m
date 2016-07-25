From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Mon, 25 Jul 2016 16:15:52 -0700
Subject: [Intel-wired-lan] [next PATCH S40 10/13] i40e: fix lookup table
	when RSS disabled/enabled
In-Reply-To: <1469488555-28187-1-git-send-email-bimmy.pujari@intel.com>
References: <1469488555-28187-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1469488555-28187-11-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: "Alan, Brady" <alan.brady@intel.com>

This patch fixes the bug which causes RSS to continue to work
after being disabled.  After disabling RSS, traffic would continue
to be assigned to different queues instead of falling back to a
single queue. Without this patch, attempting to disable RSS would
not work as expected. This patch fixes the bug by clearing the
lookup table used by RSS such that all traffic is assigned to a
single queue.  This patch also addresses the issue of reinstating
 the lookup table should RSS then be re-enabled.

Signed-off-by: Alan Brady <alan.brady@intel.com>
Change-ID: Ib20c7c6a7e9f1f772bb787370f8a8c664796b141
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index c130149..a33e902 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -8658,6 +8658,28 @@ bool i40e_set_ntuple(struct i40e_pf *pf, netdev_features_t features)
 }
 
 /**
+ * i40e_clear_rss_lut - clear the rx hash lookup table
+ * @vsi: the VSI being configured
+ **/
+static void i40e_clear_rss_lut(struct i40e_vsi *vsi)
+{
+	struct i40e_pf *pf = vsi->back;
+	struct i40e_hw *hw = &pf->hw;
+	u16 vf_id = vsi->vf_id;
+	u8 i;
+
+	if (vsi->type == I40E_VSI_MAIN) {
+		for (i = 0; i <= I40E_PFQF_HLUT_MAX_INDEX; i++)
+			wr32(hw, I40E_PFQF_HLUT(i), 0);
+	} else if (vsi->type == I40E_VSI_SRIOV) {
+		for (i = 0; i <= I40E_VFQF_HLUT_MAX_INDEX; i++)
+			i40e_write_rx_ctl(hw, I40E_VFQF_HLUT1(i, vf_id), 0);
+	} else {
+		dev_err(&pf->pdev->dev, "Cannot set RSS LUT - invalid VSI type\n");
+	}
+}
+
+/**
  * i40e_set_features - set the netdev feature flags
  * @netdev: ptr to the netdev being adjusted
  * @features: the feature set that the stack is suggesting
@@ -8670,6 +8692,12 @@ static int i40e_set_features(struct net_device *netdev,
 	struct i40e_pf *pf = vsi->back;
 	bool need_reset;
 
+	if (features & NETIF_F_RXHASH && !(netdev->features & NETIF_F_RXHASH))
+		i40e_pf_config_rss(pf);
+	else if (!(features & NETIF_F_RXHASH) &&
+		 netdev->features & NETIF_F_RXHASH)
+		i40e_clear_rss_lut(vsi);
+
 	if (features & NETIF_F_HW_VLAN_CTAG_RX)
 		i40e_vlan_stripping_enable(vsi);
 	else
-- 
2.4.11

