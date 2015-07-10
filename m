From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Fri, 10 Jul 2015 19:36:01 -0400
Subject: [Intel-wired-lan] [intel-wired-lan][next PATCH S8 06/15] i40e: Fix
	ethtool offline diagnostic with netqueues
In-Reply-To: <1436571370-103673-1-git-send-email-catherine.sullivan@intel.com>
References: <1436571370-103673-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1436571370-103673-6-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Greg Rose <gregory.v.rose@intel.com>

Treat netqueues the same way we do virtual functions when someone wants to
run the ethtool offline diagnostic test.

Signed-off-by: Greg Rose <gregory.v.rose@intel.com>
Change-ID: Id48d2b933f1fd0db7be06305a93c6ebe3dc821f5
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index d6c7eb7..230d127 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -1559,6 +1559,21 @@ static inline bool i40e_active_vfs(struct i40e_pf *pf)
 	return false;
 }
 
+static inline bool i40e_active_vmdqs(struct i40e_pf *pf)
+{
+	struct i40e_vsi **vsi = pf->vsi;
+	int i;
+
+	for (i = 0; i < pf->num_alloc_vsi; i++) {
+		if (!vsi[i])
+			continue;
+		if (vsi[i]->type == I40E_VSI_VMDQ2)
+			return true;
+	}
+
+	return false;
+}
+
 static void i40e_diag_test(struct net_device *netdev,
 			   struct ethtool_test *eth_test, u64 *data)
 {
@@ -1572,9 +1587,9 @@ static void i40e_diag_test(struct net_device *netdev,
 
 		set_bit(__I40E_TESTING, &pf->state);
 
-		if (i40e_active_vfs(pf)) {
+		if (i40e_active_vfs(pf) || i40e_active_vmdqs(pf)) {
 			dev_warn(&pf->pdev->dev,
-				 "Please take active VFS offline and restart the adapter before running NIC diagnostics\n");
+				 "Please take active VFs and Netqueues offline and restart the adapter before running NIC diagnostics\n");
 			data[I40E_ETH_TEST_REG]		= 1;
 			data[I40E_ETH_TEST_EEPROM]	= 1;
 			data[I40E_ETH_TEST_INTR]	= 1;
-- 
1.9.3

