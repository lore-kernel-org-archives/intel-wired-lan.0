From: Sasha Neftin <sasha.neftin@intel.com>
Date: Sun,  4 Jul 2021 10:11:41 +0300
Subject: [Intel-wired-lan] [PATCH v1 1/1] e1000e: Fix the max snoop/no-snoop
 latency for 10M
Message-ID: <20210704071141.1173032-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

We should decode the latency and the max_latency before directly compare.
The latency should be presented as lat_enc = scale x value:
lat_enc_d = (lat_enc & 0x0x3ff) x (1U << (5*((max_ltr_enc & 0x1c00)
>> 10)))

Suggested-by: Yee Li <seven.yi.lee@gmail.com>
Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/e1000e/ich8lan.c | 14 +++++++++++++-
 drivers/net/ethernet/intel/e1000e/ich8lan.h |  3 +++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c b/drivers/net/ethernet/intel/e1000e/ich8lan.c
index 0f6a0b1b433a..8c5dc72c3bd6 100644
--- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
+++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
@@ -1009,6 +1009,8 @@ static s32 e1000_platform_pm_pch_lpt(struct e1000_hw *hw, bool link)
 {
 	u32 reg = link << (E1000_LTRV_REQ_SHIFT + E1000_LTRV_NOSNOOP_SHIFT) |
 	    link << E1000_LTRV_REQ_SHIFT | E1000_LTRV_SEND;
+	u16 max_ltr_enc_d = 0;	/* maximum LTR decoded by platform */
+	u16 lat_enc_d = 0;	/* latency decoded */
 	u16 lat_enc = 0;	/* latency encoded */
 
 	if (link) {
@@ -1062,7 +1064,17 @@ static s32 e1000_platform_pm_pch_lpt(struct e1000_hw *hw, bool link)
 				     E1000_PCI_LTR_CAP_LPT + 2, &max_nosnoop);
 		max_ltr_enc = max_t(u16, max_snoop, max_nosnoop);
 
-		if (lat_enc > max_ltr_enc)
+		lat_enc_d = (lat_enc & E1000_LTRV_VALUE_MASK) *
+			     (1U << (E1000_LTRV_SCALE_FACTOR *
+			     ((lat_enc & E1000_LTRV_SCALE_MASK)
+			     >> E1000_LTRV_SCALE_SHIFT)));
+
+		max_ltr_enc_d = (max_ltr_enc & E1000_LTRV_VALUE_MASK) *
+				 (1U << (E1000_LTRV_SCALE_FACTOR *
+				 ((max_ltr_enc & E1000_LTRV_SCALE_MASK)
+				 >> E1000_LTRV_SCALE_SHIFT)));
+
+		if (lat_enc_d > max_ltr_enc_d)
 			lat_enc = max_ltr_enc;
 	}
 
diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.h b/drivers/net/ethernet/intel/e1000e/ich8lan.h
index 9b145f6248a8..d6a092e5ee74 100644
--- a/drivers/net/ethernet/intel/e1000e/ich8lan.h
+++ b/drivers/net/ethernet/intel/e1000e/ich8lan.h
@@ -277,8 +277,11 @@
 
 /* Latency Tolerance Reporting */
 #define E1000_LTRV			0x000F8
+#define E1000_LTRV_VALUE_MASK		0x000003FF
 #define E1000_LTRV_SCALE_MAX		5
 #define E1000_LTRV_SCALE_FACTOR		5
+#define E1000_LTRV_SCALE_SHIFT		10
+#define E1000_LTRV_SCALE_MASK		0x00001C00
 #define E1000_LTRV_REQ_SHIFT		15
 #define E1000_LTRV_NOSNOOP_SHIFT	16
 #define E1000_LTRV_SEND			(1 << 30)
-- 
2.25.1

