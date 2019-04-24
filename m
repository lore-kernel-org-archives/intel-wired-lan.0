From: Alice Michael <alice.michael@intel.com>
Date: Wed, 24 Apr 2019 05:20:52 -0700
Subject: [Intel-wired-lan] [next PATCH S5 07/10] i40e: Missing response
 checks in driver when starting/stopping FW LLDP
In-Reply-To: <20190424122055.27896-1-alice.michael@intel.com>
References: <20190424122055.27896-1-alice.michael@intel.com>
Message-ID: <20190424122055.27896-7-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Piotr Marczak <piotr.marczak@intel.com>

Driver did not check response on LLDP flag change and always returned
SUCCESS.

This patch now checks for an error and returns an error code and has
additional information in the log.

Signed-off-by: Piotr Marczak <piotr.marczak@intel.com>
---
 .../net/ethernet/intel/i40e/i40e_ethtool.c    | 27 +++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 7f7d04ab1515..0837c6b3e15e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -4852,9 +4852,11 @@ static u32 i40e_get_priv_flags(struct net_device *dev)
 static int i40e_set_priv_flags(struct net_device *dev, u32 flags)
 {
 	struct i40e_netdev_priv *np = netdev_priv(dev);
+	u64 orig_flags, new_flags, changed_flags;
+	enum i40e_admin_queue_err adq_err;
 	struct i40e_vsi *vsi = np->vsi;
 	struct i40e_pf *pf = vsi->back;
-	u64 orig_flags, new_flags, changed_flags;
+	i40e_status status;
 	u32 i, j;
 
 	orig_flags = READ_ONCE(pf->flags);
@@ -5013,7 +5015,28 @@ static int i40e_set_priv_flags(struct net_device *dev, u32 flags)
 			dcbcfg->pfc.willing = 1;
 			dcbcfg->pfc.pfccap = I40E_MAX_TRAFFIC_CLASS;
 		} else {
-			i40e_aq_start_lldp(&pf->hw, false, NULL);
+			status = i40e_aq_start_lldp(&pf->hw, false, NULL);
+			if (status) {
+				adq_err = pf->hw.aq.asq_last_status;
+				switch (adq_err) {
+				case I40E_AQ_RC_EEXIST:
+					dev_warn(&pf->pdev->dev,
+						 "FW LLDP agent is already running\n");
+					return 0;
+				case I40E_AQ_RC_EPERM:
+					dev_warn(&pf->pdev->dev,
+						 "Device configuration forbids SW from starting the LLDP agent.\n");
+					return (-EINVAL);
+				default:
+					dev_warn(&pf->pdev->dev,
+						 "Starting FW LLDP agent failed: error: %s, %s\n",
+						 i40e_stat_str(&pf->hw,
+							       status),
+						 i40e_aq_str(&pf->hw,
+							     adq_err));
+					return (-EINVAL);
+				}
+			}
 		}
 	}
 
-- 
2.19.2

