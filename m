From: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
Date: Wed, 30 Mar 2016 03:49:47 -0700
Subject: [Intel-wired-lan] [v2 next PATCH S32 12/13] i40e: Input set mask
	constants for RSS, flow director, and flex bytes
In-Reply-To: <1459334988-19951-1-git-send-email-harshitha.ramamurthy@intel.com>
References: <1459334988-19951-1-git-send-email-harshitha.ramamurthy@intel.com>
Message-ID: <1459334988-19951-13-git-send-email-harshitha.ramamurthy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Kiran Patil <kiran.patil@intel.com>

Defines for input set mask (RSS, flow director, flex payload)

Signed-off-by: Kiran Patil <kiran.patil@intel.com>
Change-ID: Ie95ef7d0916a4d6ca011c194283f959774c8dce9
---
Testing Hints: This patch applies and compiles
cleanly. Preparation patch for implementing features such as changing
input set mask for RSS, and flow director.

 drivers/net/ethernet/intel/i40e/i40e_type.h   | 42 +++++++++++++++++++++++++++
 drivers/net/ethernet/intel/i40evf/i40e_type.h | 42 +++++++++++++++++++++++++++
 2 files changed, 84 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_type.h b/drivers/net/ethernet/intel/i40e/i40e_type.h
index bf693580..fd519f1 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_type.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_type.h
@@ -1534,4 +1534,46 @@ struct i40e_lldp_variables {
 
 /* RSS Hash Table Size */
 #define I40E_PFQF_CTL_0_HASHLUTSIZE_512	0x00010000
+
+/* INPUT SET MASK for RSS, flow director and flexible payload */
+#define I40E_FD_INSET_L3_SRC_SHIFT		47
+#define I40E_FD_INSET_L3_SRC_WORD_MASK		(0x3ULL << \
+						 I40E_FD_INSET_L3_SRC_SHIFT)
+#define I40E_FD_INSET_L3_DST_SHIFT		35
+#define I40E_FD_INSET_L3_DST_WORD_MASK		(0x3ULL << \
+						 I40E_FD_INSET_L3_DST_SHIFT)
+#define I40E_FD_INSET_L4_SRC_SHIFT		34
+#define I40E_FD_INSET_L4_SRC_WORD_MASK		(0x1ULL << \
+						 I40E_FD_INSET_L4_SRC_SHIFT)
+#define I40E_FD_INSET_L4_DST_SHIFT		33
+#define I40E_FD_INSET_L4_DST_WORD_MASK		(0x1ULL << \
+						 I40E_FD_INSET_L4_DST_SHIFT)
+#define I40E_FD_INSET_VERIFY_TAG_SHIFT		31
+#define I40E_FD_INSET_VERIFY_TAG_WORD_MASK	(0x3ULL << \
+						 I40E_FD_INSET_VERIFY_TAG_SHIFT)
+
+#define I40E_FD_INSET_FLEX_WORD50_SHIFT		17
+#define I40E_FD_INSET_FLEX_WORD50_MASK		(0x1ULL << \
+					I40E_FD_INSET_FLEX_WORD50_SHIFT)
+#define I40E_FD_INSET_FLEX_WORD51_SHIFT		16
+#define I40E_FD_INSET_FLEX_WORD51_MASK		(0x1ULL << \
+					I40E_FD_INSET_FLEX_WORD51_SHIFT)
+#define I40E_FD_INSET_FLEX_WORD52_SHIFT		15
+#define I40E_FD_INSET_FLEX_WORD52_MASK		(0x1ULL << \
+					I40E_FD_INSET_FLEX_WORD52_SHIFT)
+#define I40E_FD_INSET_FLEX_WORD53_SHIFT		14
+#define I40E_FD_INSET_FLEX_WORD53_MASK		(0x1ULL << \
+					I40E_FD_INSET_FLEX_WORD53_SHIFT)
+#define I40E_FD_INSET_FLEX_WORD54_SHIFT		13
+#define I40E_FD_INSET_FLEX_WORD54_MASK		(0x1ULL << \
+					I40E_FD_INSET_FLEX_WORD54_SHIFT)
+#define I40E_FD_INSET_FLEX_WORD55_SHIFT		12
+#define I40E_FD_INSET_FLEX_WORD55_MASK		(0x1ULL << \
+					I40E_FD_INSET_FLEX_WORD55_SHIFT)
+#define I40E_FD_INSET_FLEX_WORD56_SHIFT		11
+#define I40E_FD_INSET_FLEX_WORD56_MASK		(0x1ULL << \
+					I40E_FD_INSET_FLEX_WORD56_SHIFT)
+#define I40E_FD_INSET_FLEX_WORD57_SHIFT		10
+#define I40E_FD_INSET_FLEX_WORD57_MASK		(0x1ULL << \
+					I40E_FD_INSET_FLEX_WORD57_SHIFT)
 #endif /* _I40E_TYPE_H_ */
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_type.h b/drivers/net/ethernet/intel/i40evf/i40e_type.h
index d68e017..4a78c18 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_type.h
+++ b/drivers/net/ethernet/intel/i40evf/i40e_type.h
@@ -1330,4 +1330,46 @@ enum i40e_reset_type {
 
 /* RSS Hash Table Size */
 #define I40E_PFQF_CTL_0_HASHLUTSIZE_512	0x00010000
+
+/* INPUT SET MASK for RSS, flow director and flexible payload */
+#define I40E_FD_INSET_L3_SRC_SHIFT		47
+#define I40E_FD_INSET_L3_SRC_WORD_MASK		(0x3ULL << \
+						 I40E_FD_INSET_L3_SRC_SHIFT)
+#define I40E_FD_INSET_L3_DST_SHIFT		35
+#define I40E_FD_INSET_L3_DST_WORD_MASK		(0x3ULL << \
+						 I40E_FD_INSET_L3_DST_SHIFT)
+#define I40E_FD_INSET_L4_SRC_SHIFT		34
+#define I40E_FD_INSET_L4_SRC_WORD_MASK		(0x1ULL << \
+						 I40E_FD_INSET_L4_SRC_SHIFT)
+#define I40E_FD_INSET_L4_DST_SHIFT		33
+#define I40E_FD_INSET_L4_DST_WORD_MASK		(0x1ULL << \
+						 I40E_FD_INSET_L4_DST_SHIFT)
+#define I40E_FD_INSET_VERIFY_TAG_SHIFT		31
+#define I40E_FD_INSET_VERIFY_TAG_WORD_MASK	(0x3ULL << \
+						 I40E_FD_INSET_VERIFY_TAG_SHIFT)
+
+#define I40E_FD_INSET_FLEX_WORD50_SHIFT		17
+#define I40E_FD_INSET_FLEX_WORD50_MASK		(0x1ULL << \
+					I40E_FD_INSET_FLEX_WORD50_SHIFT)
+#define I40E_FD_INSET_FLEX_WORD51_SHIFT		16
+#define I40E_FD_INSET_FLEX_WORD51_MASK		(0x1ULL << \
+					I40E_FD_INSET_FLEX_WORD51_SHIFT)
+#define I40E_FD_INSET_FLEX_WORD52_SHIFT		15
+#define I40E_FD_INSET_FLEX_WORD52_MASK		(0x1ULL << \
+					I40E_FD_INSET_FLEX_WORD52_SHIFT)
+#define I40E_FD_INSET_FLEX_WORD53_SHIFT		14
+#define I40E_FD_INSET_FLEX_WORD53_MASK		(0x1ULL << \
+					I40E_FD_INSET_FLEX_WORD53_SHIFT)
+#define I40E_FD_INSET_FLEX_WORD54_SHIFT		13
+#define I40E_FD_INSET_FLEX_WORD54_MASK		(0x1ULL << \
+					I40E_FD_INSET_FLEX_WORD54_SHIFT)
+#define I40E_FD_INSET_FLEX_WORD55_SHIFT		12
+#define I40E_FD_INSET_FLEX_WORD55_MASK		(0x1ULL << \
+					I40E_FD_INSET_FLEX_WORD55_SHIFT)
+#define I40E_FD_INSET_FLEX_WORD56_SHIFT		11
+#define I40E_FD_INSET_FLEX_WORD56_MASK		(0x1ULL << \
+					I40E_FD_INSET_FLEX_WORD56_SHIFT)
+#define I40E_FD_INSET_FLEX_WORD57_SHIFT		10
+#define I40E_FD_INSET_FLEX_WORD57_MASK		(0x1ULL << \
+					I40E_FD_INSET_FLEX_WORD57_SHIFT)
 #endif /* _I40E_TYPE_H_ */
-- 
2.4.3

