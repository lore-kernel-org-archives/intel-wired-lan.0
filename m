From: Alice Michael <alice.michael@intel.com>
Date: Fri, 29 Dec 2017 08:50:20 -0500
Subject: [Intel-wired-lan] [next PATCH S85-V1 07/14] i40e: Warn when setting
 link-down-on-close while in MFP
Message-ID: <20171229135020.14457-1-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Pawe? Jab?o?ski <pawel.jablonski@intel.com>

This patch adds a warning message when the link-down-on-close flag is
setting on. The warning is printed only on MFP devices

Signed-off-by: Pawe? Jab?o?ski <pawel.jablonski@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index f829a7a..7267a93 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -4479,6 +4479,12 @@ static int i40e_set_priv_flags(struct net_device *dev, u32 flags)
 		}
 	}
 
+	if ((changed_flags & pf->flags &
+	     I40E_FLAG_LINK_DOWN_ON_CLOSE_ENABLED) &&
+	    (pf->flags & I40E_FLAG_MFP_ENABLED))
+		dev_warn(&pf->pdev->dev,
+			 "Turning on link-down-on-close flag may affect other partitions\n");
+
 	if (changed_flags & I40E_FLAG_DISABLE_FW_LLDP) {
 		if (pf->flags & I40E_FLAG_DISABLE_FW_LLDP) {
 			struct i40e_dcbx_config *dcbcfg;
-- 
2.9.5

