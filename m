From: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
Date: Mon, 28 Mar 2016 04:17:24 -0700
Subject: [Intel-wired-lan] [next PATCH S32 13/14] i40e: Rename defines for
	input set mask
In-Reply-To: <1459163845-28035-1-git-send-email-harshitha.ramamurthy@intel.com>
References: <1459163845-28035-1-git-send-email-harshitha.ramamurthy@intel.com>
Message-ID: <1459163845-28035-14-git-send-email-harshitha.ramamurthy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Kiran Patil <kiran.patil@intel.com>

Rename defines related to INPUT set mask (which is meant to be used
for both: RSS and flow director).

Signed-off-by: Kiran Patil <kiran.patil@intel.com>
Change-ID: I9e4d9947543e6cc56265873e38114f39e253d56b
---
Testing Hints : This patch applies and compiles
cleanly.

 drivers/net/ethernet/intel/i40e/i40e_type.h   | 69 +++++++++++----------------
 drivers/net/ethernet/intel/i40evf/i40e_type.h | 69 +++++++++++----------------
 2 files changed, 56 insertions(+), 82 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_type.h b/drivers/net/ethernet/intel/i40e/i40e_type.h
index 3c99465..6778937 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_type.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_type.h
@@ -1534,45 +1534,32 @@ struct i40e_lldp_variables {
 /* RSS Hash Table Size */
 #define I40E_PFQF_CTL_0_HASHLUTSIZE_512	0x00010000
 
-/* INPUT SET MASK for RSS, flow director and flexible payload */
-#define I40E_FD_INSET_L3_SRC_SHIFT		47
-#define I40E_FD_INSET_L3_SRC_WORD_MASK		(0x3ULL << \
-						 I40E_FD_INSET_L3_SRC_SHIFT)
-#define I40E_FD_INSET_L3_DST_SHIFT		35
-#define I40E_FD_INSET_L3_DST_WORD_MASK		(0x3ULL << \
-						 I40E_FD_INSET_L3_DST_SHIFT)
-#define I40E_FD_INSET_L4_SRC_SHIFT		34
-#define I40E_FD_INSET_L4_SRC_WORD_MASK		(0x1ULL << \
-						 I40E_FD_INSET_L4_SRC_SHIFT)
-#define I40E_FD_INSET_L4_DST_SHIFT		33
-#define I40E_FD_INSET_L4_DST_WORD_MASK		(0x1ULL << \
-						 I40E_FD_INSET_L4_DST_SHIFT)
-#define I40E_FD_INSET_VERIFY_TAG_SHIFT		31
-#define I40E_FD_INSET_VERIFY_TAG_WORD_MASK	(0x3ULL << \
-						 I40E_FD_INSET_VERIFY_TAG_SHIFT)
-
-#define I40E_FD_INSET_FLEX_WORD50_SHIFT		17
-#define I40E_FD_INSET_FLEX_WORD50_MASK		(0x1ULL << \
-					I40E_FD_INSET_FLEX_WORD50_SHIFT)
-#define I40E_FD_INSET_FLEX_WORD51_SHIFT		16
-#define I40E_FD_INSET_FLEX_WORD51_MASK		(0x1ULL << \
-					I40E_FD_INSET_FLEX_WORD51_SHIFT)
-#define I40E_FD_INSET_FLEX_WORD52_SHIFT		15
-#define I40E_FD_INSET_FLEX_WORD52_MASK		(0x1ULL << \
-					I40E_FD_INSET_FLEX_WORD52_SHIFT)
-#define I40E_FD_INSET_FLEX_WORD53_SHIFT		14
-#define I40E_FD_INSET_FLEX_WORD53_MASK		(0x1ULL << \
-					I40E_FD_INSET_FLEX_WORD53_SHIFT)
-#define I40E_FD_INSET_FLEX_WORD54_SHIFT		13
-#define I40E_FD_INSET_FLEX_WORD54_MASK		(0x1ULL << \
-					I40E_FD_INSET_FLEX_WORD54_SHIFT)
-#define I40E_FD_INSET_FLEX_WORD55_SHIFT		12
-#define I40E_FD_INSET_FLEX_WORD55_MASK		(0x1ULL << \
-					I40E_FD_INSET_FLEX_WORD55_SHIFT)
-#define I40E_FD_INSET_FLEX_WORD56_SHIFT		11
-#define I40E_FD_INSET_FLEX_WORD56_MASK		(0x1ULL << \
-					I40E_FD_INSET_FLEX_WORD56_SHIFT)
-#define I40E_FD_INSET_FLEX_WORD57_SHIFT		10
-#define I40E_FD_INSET_FLEX_WORD57_MASK		(0x1ULL << \
-					I40E_FD_INSET_FLEX_WORD57_SHIFT)
+/* INPUT SET MASK for RSS, flow director, and flexible payload */
+#define I40E_L3_SRC_SHIFT		47
+#define I40E_L3_SRC_MASK		(0x3ULL << I40E_L3_SRC_SHIFT)
+#define I40E_L3_DST_SHIFT		35
+#define I40E_L3_DST_MASK		(0x3ULL << I40E_L3_DST_SHIFT)
+#define I40E_L4_SRC_SHIFT		34
+#define I40E_L4_SRC_MASK		(0x1ULL << I40E_L4_SRC_SHIFT)
+#define I40E_L4_DST_SHIFT		33
+#define I40E_L4_DST_MASK		(0x1ULL << I40E_L4_DST_SHIFT)
+#define I40E_VERIFY_TAG_SHIFT		31
+#define I40E_VERIFY_TAG_MASK		(0x3ULL << I40E_VERIFY_TAG_SHIFT)
+
+#define I40E_FLEX_50_SHIFT		17
+#define I40E_FLEX_50_MASK		(0x1ULL << I40E_FLEX_50_SHIFT)
+#define I40E_FLEX_51_SHIFT		16
+#define I40E_FLEX_51_MASK		(0x1ULL << I40E_FLEX_51_SHIFT)
+#define I40E_FLEX_52_SHIFT		15
+#define I40E_FLEX_52_MASK		(0x1ULL << I40E_FLEX_52_SHIFT)
+#define I40E_FLEX_53_SHIFT		14
+#define I40E_FLEX_53_MASK		(0x1ULL << I40E_FLEX_53_SHIFT)
+#define I40E_FLEX_54_SHIFT		13
+#define I40E_FLEX_54_MASK		(0x1ULL << I40E_FLEX_54_SHIFT)
+#define I40E_FLEX_55_SHIFT		12
+#define I40E_FLEX_55_MASK		(0x1ULL << I40E_FLEX_55_SHIFT)
+#define I40E_FLEX_56_SHIFT		11
+#define I40E_FLEX_56_MASK		(0x1ULL << I40E_FLEX_56_SHIFT)
+#define I40E_FLEX_57_SHIFT		10
+#define I40E_FLEX_57_MASK		(0x1ULL << I40E_FLEX_57_SHIFT)
 #endif /* _I40E_TYPE_H_ */
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_type.h b/drivers/net/ethernet/intel/i40evf/i40e_type.h
index 4a78c18..c109908 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_type.h
+++ b/drivers/net/ethernet/intel/i40evf/i40e_type.h
@@ -1331,45 +1331,32 @@ enum i40e_reset_type {
 /* RSS Hash Table Size */
 #define I40E_PFQF_CTL_0_HASHLUTSIZE_512	0x00010000
 
-/* INPUT SET MASK for RSS, flow director and flexible payload */
-#define I40E_FD_INSET_L3_SRC_SHIFT		47
-#define I40E_FD_INSET_L3_SRC_WORD_MASK		(0x3ULL << \
-						 I40E_FD_INSET_L3_SRC_SHIFT)
-#define I40E_FD_INSET_L3_DST_SHIFT		35
-#define I40E_FD_INSET_L3_DST_WORD_MASK		(0x3ULL << \
-						 I40E_FD_INSET_L3_DST_SHIFT)
-#define I40E_FD_INSET_L4_SRC_SHIFT		34
-#define I40E_FD_INSET_L4_SRC_WORD_MASK		(0x1ULL << \
-						 I40E_FD_INSET_L4_SRC_SHIFT)
-#define I40E_FD_INSET_L4_DST_SHIFT		33
-#define I40E_FD_INSET_L4_DST_WORD_MASK		(0x1ULL << \
-						 I40E_FD_INSET_L4_DST_SHIFT)
-#define I40E_FD_INSET_VERIFY_TAG_SHIFT		31
-#define I40E_FD_INSET_VERIFY_TAG_WORD_MASK	(0x3ULL << \
-						 I40E_FD_INSET_VERIFY_TAG_SHIFT)
-
-#define I40E_FD_INSET_FLEX_WORD50_SHIFT		17
-#define I40E_FD_INSET_FLEX_WORD50_MASK		(0x1ULL << \
-					I40E_FD_INSET_FLEX_WORD50_SHIFT)
-#define I40E_FD_INSET_FLEX_WORD51_SHIFT		16
-#define I40E_FD_INSET_FLEX_WORD51_MASK		(0x1ULL << \
-					I40E_FD_INSET_FLEX_WORD51_SHIFT)
-#define I40E_FD_INSET_FLEX_WORD52_SHIFT		15
-#define I40E_FD_INSET_FLEX_WORD52_MASK		(0x1ULL << \
-					I40E_FD_INSET_FLEX_WORD52_SHIFT)
-#define I40E_FD_INSET_FLEX_WORD53_SHIFT		14
-#define I40E_FD_INSET_FLEX_WORD53_MASK		(0x1ULL << \
-					I40E_FD_INSET_FLEX_WORD53_SHIFT)
-#define I40E_FD_INSET_FLEX_WORD54_SHIFT		13
-#define I40E_FD_INSET_FLEX_WORD54_MASK		(0x1ULL << \
-					I40E_FD_INSET_FLEX_WORD54_SHIFT)
-#define I40E_FD_INSET_FLEX_WORD55_SHIFT		12
-#define I40E_FD_INSET_FLEX_WORD55_MASK		(0x1ULL << \
-					I40E_FD_INSET_FLEX_WORD55_SHIFT)
-#define I40E_FD_INSET_FLEX_WORD56_SHIFT		11
-#define I40E_FD_INSET_FLEX_WORD56_MASK		(0x1ULL << \
-					I40E_FD_INSET_FLEX_WORD56_SHIFT)
-#define I40E_FD_INSET_FLEX_WORD57_SHIFT		10
-#define I40E_FD_INSET_FLEX_WORD57_MASK		(0x1ULL << \
-					I40E_FD_INSET_FLEX_WORD57_SHIFT)
+/* INPUT SET MASK for RSS, flow director, and flexible payload */
+#define I40E_L3_SRC_SHIFT		47
+#define I40E_L3_SRC_MASK		(0x3ULL << I40E_L3_SRC_SHIFT)
+#define I40E_L3_DST_SHIFT		35
+#define I40E_L3_DST_MASK		(0x3ULL << I40E_L3_DST_SHIFT)
+#define I40E_L4_SRC_SHIFT		34
+#define I40E_L4_SRC_MASK		(0x1ULL << I40E_L4_SRC_SHIFT)
+#define I40E_L4_DST_SHIFT		33
+#define I40E_L4_DST_MASK		(0x1ULL << I40E_L4_DST_SHIFT)
+#define I40E_VERIFY_TAG_SHIFT		31
+#define I40E_VERIFY_TAG_MASK		(0x3ULL << I40E_VERIFY_TAG_SHIFT)
+
+#define I40E_FLEX_50_SHIFT		17
+#define I40E_FLEX_50_MASK		(0x1ULL << I40E_FLEX_50_SHIFT)
+#define I40E_FLEX_51_SHIFT		16
+#define I40E_FLEX_51_MASK		(0x1ULL << I40E_FLEX_51_SHIFT)
+#define I40E_FLEX_52_SHIFT		15
+#define I40E_FLEX_52_MASK		(0x1ULL << I40E_FLEX_52_SHIFT)
+#define I40E_FLEX_53_SHIFT		14
+#define I40E_FLEX_53_MASK		(0x1ULL << I40E_FLEX_53_SHIFT)
+#define I40E_FLEX_54_SHIFT		13
+#define I40E_FLEX_54_MASK		(0x1ULL << I40E_FLEX_54_SHIFT)
+#define I40E_FLEX_55_SHIFT		12
+#define I40E_FLEX_55_MASK		(0x1ULL << I40E_FLEX_55_SHIFT)
+#define I40E_FLEX_56_SHIFT		11
+#define I40E_FLEX_56_MASK		(0x1ULL << I40E_FLEX_56_SHIFT)
+#define I40E_FLEX_57_SHIFT		10
+#define I40E_FLEX_57_MASK		(0x1ULL << I40E_FLEX_57_SHIFT)
 #endif /* _I40E_TYPE_H_ */
-- 
2.4.3

