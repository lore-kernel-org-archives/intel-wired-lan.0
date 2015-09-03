From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Thu,  3 Sep 2015 17:18:57 -0400
Subject: [Intel-wired-lan] [next PATCH S15 10/15] i40e/i40evf: remove
	redundant declarations of a variable and a function
In-Reply-To: <1441315142-173025-1-git-send-email-catherine.sullivan@intel.com>
References: <1441315142-173025-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1441315142-173025-11-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Shannon Nelson <shannon.nelson@intel.com>

Remove a variable declaration inside an if block hiding an existing
declaration at the start of the function.

Also remove a forward function declaration that is no longer needed due
to code re-organization.

Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
Change-ID: I12954668b722718074949c93d74cd20eaacd93e4
---
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c  | 3 ---
 drivers/net/ethernet/intel/i40evf/i40evf_main.c | 2 +-
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index a22f1d9..d6b0788 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -90,9 +90,6 @@ static const struct i40e_stats i40e_gstrings_misc_stats[] = {
 	I40E_VSI_STAT("tx_linearize", tx_linearize),
 };
 
-static int i40e_add_fdir_ethtool(struct i40e_vsi *vsi,
-				 struct ethtool_rxnfc *cmd);
-
 /* These PF_STATs might look like duplicates of some NETDEV_STATs,
  * but they are separate.  This device supports Virtualization, and
  * as such might have several netdevs supporting VMDq and FCoE going
diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index feb9ad5..f156226 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -1628,7 +1628,7 @@ static void i40evf_reset_task(struct work_struct *work)
 	/* extra wait to make sure minimum wait is met */
 	msleep(I40EVF_RESET_WAIT_MS);
 	if (i == I40EVF_RESET_WAIT_COUNT) {
-		struct i40evf_mac_filter *f, *ftmp;
+		struct i40evf_mac_filter *ftmp;
 		struct i40evf_vlan_filter *fv, *fvtmp;
 
 		/* reset never finished */
-- 
1.9.3

