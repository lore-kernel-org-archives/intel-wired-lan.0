From: Alice Michael <alice.michael@intel.com>
Date: Wed, 24 Apr 2019 05:20:46 -0700
Subject: [Intel-wired-lan] [next PATCH S5 01/10] i40e: let untrusted VF to
 create up to 16 VLANs
Message-ID: <20190424122055.27896-1-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Piotr Kwapulinski <piotr.kwapulinski@intel.com>

This patch lets untrusted VF to create up to 16 VLANs.
It was implemented by increasing I40E_VC_MAX_VLAN_PER_VF up to 16.
Without this patch untrusted VF could create only up to 8 VLANs.

Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 479bc60c8f71..8b07614ca568 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -2509,7 +2509,7 @@ static int i40e_vc_get_stats_msg(struct i40e_vf *vf, u8 *msg)
  * MAC filters: 16 for multicast, 1 for MAC, 1 for broadcast
  */
 #define I40E_VC_MAX_MAC_ADDR_PER_VF (16 + 1 + 1)
-#define I40E_VC_MAX_VLAN_PER_VF 8
+#define I40E_VC_MAX_VLAN_PER_VF 16
 
 /**
  * i40e_check_vf_permission
-- 
2.19.2

