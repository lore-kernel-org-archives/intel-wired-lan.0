From: Rami Rosen <rami.rosen@intel.com>
Date: Sat, 19 Aug 2017 00:20:31 +0300
Subject: [Intel-wired-lan] [PATCH net-next] i40e: fix a typo in i40e_pf
	documentation.
Message-ID: <1503091231-5869-1-git-send-email-rami.rosen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch fixes a typo in i40e_pf object documentation; num_req_vfs 
refers to the number of VFs requested for the PF.

Signed-off-by: Rami Rosen <rami.rosen@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index d616f69..cadbbec 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -348,7 +348,7 @@ struct i40e_pf {
 	u16 num_vmdq_vsis;         /* num vmdq vsis this PF has set up */
 	u16 num_vmdq_qps;          /* num queue pairs per vmdq pool */
 	u16 num_vmdq_msix;         /* num queue vectors per vmdq pool */
-	u16 num_req_vfs;           /* num VFs requested for this VF */
+	u16 num_req_vfs;           /* num VFs requested for this PF */
 	u16 num_vf_qps;            /* num queue pairs per VF */
 	u16 num_lan_qps;           /* num lan queues this PF has set up */
 	u16 num_lan_msix;          /* num queue vectors for the base PF vsi */
-- 
1.9.1

