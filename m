From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon,  6 Feb 2017 14:38:38 -0800
Subject: [Intel-wired-lan] [FIXUP PATCH 1/2] fixup! i40e: Introduce VF Port
	Representator(VFPR) netdevs
In-Reply-To: <20170206223840.30938-1-jacob.e.keller@intel.com>
References: <20170206223840.30938-1-jacob.e.keller@intel.com>
Message-ID: <20170206223840.30938-2-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This fixes a warning in commit 6dc77d828f1a ("i40e: Introduce VF Port
Representator(VFPR) netdevs", 2017-01-31).

Jeff please squash this fix into the mentioned patch, or have the
original author re-roll the patch.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index a970ba3a86b1..9efecff9c535 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -1204,7 +1204,7 @@ static const struct switchdev_ops i40e_vfpr_switchdev_ops = {
  *
  * add/delete VFs broadcast filter
  **/
-void i40e_update_vf_broadcast_filter(struct i40e_vf *vf, bool enable)
+static void i40e_update_vf_broadcast_filter(struct i40e_vf *vf, bool enable)
 {
 	struct i40e_pf *pf = vf->pf;
 	struct i40e_vsi *vsi = pf->vsi[vf->lan_vsi_idx];
-- 
2.12.0.rc0.151.g8a5726c42288

