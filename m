From: Rami Rosen <rami.rosen@intel.com>
Date: Sat, 16 Sep 2017 05:49:48 +0300
Subject: [Intel-wired-lan] [PATCH] i40e: fix a typo.
Message-ID: <1505530188-3220-1-git-send-email-rami.rosen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch fixes a typo in i40e_vsi_alloc_arrays() documentation.
The first parameter name should be "vsi" instead of "type".

Signed-off-by: Rami Rosen <rami.rosen@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 5ef392781de1..ef4e7ac7a29a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -8860,7 +8860,7 @@ static int i40e_set_num_rings_in_vsi(struct i40e_vsi *vsi)
 
 /**
  * i40e_vsi_alloc_arrays - Allocate queue and vector pointer arrays for the vsi
- * @type: VSI pointer
+ * @vsi: VSI pointer
  * @alloc_qvectors: a bool to specify if q_vectors need to be allocated.
  *
  * On error: returns error code (negative)
-- 
2.7.4

