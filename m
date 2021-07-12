From: Paul Greenwalt <paul.greenwalt@intel.com>
Date: Mon, 12 Jul 2021 07:54:25 -0400
Subject: [Intel-wired-lan] [PATCH] ice: rearm other interrupt cause register
 after enabling VFs
Message-ID: <20210712115425.214965-1-paul.greenwalt@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The other interrupt cause register (OICR), global interrupt 0, is
disabled when enabling VFs to prevent handling VFLR. If the OICR is
not rearmed then the VF cannot communicate with the PF.

Rearm the OICR after enabling VFs.

Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
index 501331b6f70b..0a2e0b2c9227 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
@@ -1952,6 +1952,10 @@ static int ice_ena_vfs(struct ice_pf *pf, u16 num_vfs)
 	if (ice_eswitch_configure(pf))
 		goto err_unroll_sriov;
 
+	/* rearm global interrupts */
+	if (test_and_clear_bit(ICE_OICR_INTR_DIS, pf->state))
+		ice_irq_dynamic_ena(hw, NULL, NULL);
+
 	return 0;
 
 err_unroll_sriov:
-- 
2.30.2

