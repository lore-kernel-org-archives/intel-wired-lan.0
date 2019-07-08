From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon,  8 Jul 2019 16:12:29 -0700
Subject: [Intel-wired-lan] [PATCH 12/19] fm10k: remove unnecessary variable
 initializer
In-Reply-To: <20190708231236.20516-1-jacob.e.keller@intel.com>
References: <20190708231236.20516-1-jacob.e.keller@intel.com>
Message-ID: <20190708231236.20516-13-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The err variable in the fm10k_tlv_attr_parse function is initialized
with zero. However, the function never reads err without first assigning
it from a function call. Remove this unnecessary initialization.

This was detected by cppcheck and resolves the following warning
produced by that tool:

[fm10k_tlv.c:498]: (style) Variable 'err' is assigned a value that is
never used.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_tlv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_tlv.c b/drivers/net/ethernet/intel/fm10k/fm10k_tlv.c
index 2a7a40bf2b1c..f4c42a40f934 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_tlv.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_tlv.c
@@ -472,7 +472,7 @@ static s32 fm10k_tlv_attr_parse(u32 *attr, u32 **results,
 				const struct fm10k_tlv_attr *tlv_attr)
 {
 	u32 i, attr_id, offset = 0;
-	s32 err = 0;
+	s32 err;
 	u16 len;
 
 	/* verify pointers are not NULL */
-- 
2.22.0.214.g8dca754b1e87

