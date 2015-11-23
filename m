From: Vasu Dev <vasu.dev@intel.com>
Date: Mon, 23 Nov 2015 10:30:51 -0800
Subject: [Intel-wired-lan] [PATCH] ixgbe: Fill at least min credits to a TC
	credit refills
Message-ID: <20151123183051.17677.32713.stgit@lin-nd1-054.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Currently credit_refill and credit_max could be zero for a TC and that
is causing Tx hang for CEE mode configuration, so to fix that have at
min credit assigned to a TC and that is as what IEEE mode already does.

Signed-off-by: Vasu Dev <vasu.dev@intel.com>
Change-ID: If652c133093a21e530f4e9eab09097976f57fb12
---

 drivers/net/ethernet/intel/ixgbe/ixgbe_dcb.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_dcb.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_dcb.c
index a507a6f..02c7333 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_dcb.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_dcb.c
@@ -139,6 +139,11 @@ s32 ixgbe_dcb_calculate_tc_credits(struct ixgbe_hw *hw,
 		/* Calculate credit refill ratio using multiplier */
 		credit_refill = min(link_percentage * min_multiplier,
 				    MAX_CREDIT_REFILL);
+
+		/* Refill at least minimum credit */
+		if (credit_refill < min_credit)
+			credit_refill = min_credit;
+
 		p->data_credits_refill = (u16)credit_refill;
 
 		/* Calculate maximum credit for the TC */
@@ -149,7 +154,7 @@ s32 ixgbe_dcb_calculate_tc_credits(struct ixgbe_hw *hw,
 		 * of a TC is too small, the maximum credit may not be
 		 * enough to send out a jumbo frame in data plane arbitration.
 		 */
-		if (credit_max && (credit_max < min_credit))
+		if (credit_max < min_credit)
 			credit_max = min_credit;
 
 		if (direction == DCB_TX_CONFIG) {

