From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Mon, 23 Jul 2018 15:05:10 -0700
Subject: [Intel-wired-lan] [PATCH v2 03/13] ice: Fix missing shift
In-Reply-To: <20180723220520.16678-1-anirudh.venkataramanan@intel.com>
References: <20180723220520.16678-1-anirudh.venkataramanan@intel.com>
Message-ID: <20180723220520.16678-4-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bruce Allan <bruce.w.allan@intel.com>

The ITR index of the interrupt cause for OICR and FW interrupts is not
being shifted correctly so when masked with PFINT_*_CTL_ITR_INDX_M it
will always be zero.  Luckily, ICE_RX_ITR is zero anyway so the end result
is the same, but the shift should be fixed in case the value of ICE_RX_ITR
ever changes or it is substituted with another value that needs to be
shifted properly.

Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
[Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> cleaned up commit message]
---
 drivers/net/ethernet/intel/ice/ice_main.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 78756853ade1..450911345144 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -2058,15 +2058,17 @@ static int ice_req_irq_msix_misc(struct ice_pf *pf)
 skip_req_irq:
 	ice_ena_misc_vector(pf);
 
-	val = (pf->oicr_idx & PFINT_OICR_CTL_MSIX_INDX_M) |
-	      (ICE_RX_ITR & PFINT_OICR_CTL_ITR_INDX_M) |
-	      PFINT_OICR_CTL_CAUSE_ENA_M;
+	val = ((pf->oicr_idx & PFINT_OICR_CTL_MSIX_INDX_M) |
+	       ((ICE_RX_ITR << PFINT_OICR_CTL_ITR_INDX_S) &
+		PFINT_OICR_CTL_ITR_INDX_M) |
+	       PFINT_OICR_CTL_CAUSE_ENA_M);
 	wr32(hw, PFINT_OICR_CTL, val);
 
 	/* This enables Admin queue Interrupt causes */
-	val = (pf->oicr_idx & PFINT_FW_CTL_MSIX_INDX_M) |
-	      (ICE_RX_ITR & PFINT_FW_CTL_ITR_INDX_M) |
-	      PFINT_FW_CTL_CAUSE_ENA_M;
+	val = ((pf->oicr_idx & PFINT_FW_CTL_MSIX_INDX_M) |
+	       ((ICE_RX_ITR << PFINT_FW_CTL_ITR_INDX_S) &
+		PFINT_FW_CTL_ITR_INDX_M) |
+	       PFINT_FW_CTL_CAUSE_ENA_M);
 	wr32(hw, PFINT_FW_CTL, val);
 
 	itr_gran = hw->itr_gran_200;
-- 
2.14.3

