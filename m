From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Fri,  7 May 2021 11:56:25 -0700
Subject: [Intel-wired-lan] [PATCH net v1] i40e: fix PTP on 5Gb links
Message-ID: <20210507185625.2651538-1-jesse.brandeburg@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

As reported by Alex Sergeev, the i40e driver is incremening the PTP
clock at 10Gb speeds when linked at 5Gb. Fix this bug by making
sure that the right multiplier is selected when linked at 5Gb.

Fixes: 3dbdd6c2f70a ("i40e: Add support for 5Gbps cards")
Reported-by: Alex Sergeev <asergeev@carbonrobotics.com>
Suggested-by: Alex Sergeev <asergeev@carbonrobotics.com>
Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_ptp.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_ptp.c b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
index f1f6fc3744e9..7b971b205d36 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
@@ -11,13 +11,14 @@
  * operate with the nanosecond field directly without fear of overflow.
  *
  * Much like the 82599, the update period is dependent upon the link speed:
- * At 40Gb link or no link, the period is 1.6ns.
- * At 10Gb link, the period is multiplied by 2. (3.2ns)
+ * At 40Gb, 25Gb, or no link, the period is 1.6ns.
+ * At 10Gb or 5Gb link, the period is multiplied by 2. (3.2ns)
  * At 1Gb link, the period is multiplied by 20. (32ns)
  * 1588 functionality is not supported at 100Mbps.
  */
 #define I40E_PTP_40GB_INCVAL		0x0199999999ULL
 #define I40E_PTP_10GB_INCVAL_MULT	2
+#define I40E_PTP_5GB_INCVAL_MULT	2
 #define I40E_PTP_1GB_INCVAL_MULT	20
 
 #define I40E_PRTTSYN_CTL1_TSYNTYPE_V1  BIT(I40E_PRTTSYN_CTL1_TSYNTYPE_SHIFT)
@@ -465,6 +466,9 @@ void i40e_ptp_set_increment(struct i40e_pf *pf)
 	case I40E_LINK_SPEED_10GB:
 		mult = I40E_PTP_10GB_INCVAL_MULT;
 		break;
+	case I40E_LINK_SPEED_5GB:
+		mult = I40E_PTP_5GB_INCVAL_MULT;
+		break;
 	case I40E_LINK_SPEED_1GB:
 		mult = I40E_PTP_1GB_INCVAL_MULT;
 		break;

base-commit: a6f8ee58a8e35f7e4380a5efce312e2a5bc27497
-- 
2.30.2

