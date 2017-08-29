From: Alice Michael <alice.michael@intel.com>
Date: Tue, 29 Aug 2017 05:32:34 -0400
Subject: [Intel-wired-lan] [next PATCH S79-V2 05/13] i40e: fix incorrect
	register definition
In-Reply-To: <20170829093242.41026-1-alice.michael@intel.com>
References: <20170829093242.41026-1-alice.michael@intel.com>
Message-ID: <20170829093242.41026-5-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

This register was defined incorrectly. Fix the increment value to 8, and
replace the iterator with _i to make the definition consistent with
other statistics registers.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_register.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_register.h b/drivers/net/ethernet/intel/i40e/i40e_register.h
index 86ca27f..c234758 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_register.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_register.h
@@ -2794,7 +2794,7 @@
 #define I40E_GLV_RUPP_MAX_INDEX 383
 #define I40E_GLV_RUPP_RUPP_SHIFT 0
 #define I40E_GLV_RUPP_RUPP_MASK I40E_MASK(0xFFFFFFFF, I40E_GLV_RUPP_RUPP_SHIFT)
-#define I40E_GLV_TEPC(_VSI) (0x00344000 + ((_VSI) * 4)) /* _i=0...383 */ /* Reset: CORER */
+#define I40E_GLV_TEPC(_i) (0x00344000 + ((_i) * 8)) /* _i=0...383 */ /* Reset: CORER */
 #define I40E_GLV_TEPC_MAX_INDEX 383
 #define I40E_GLV_TEPC_TEPC_SHIFT 0
 #define I40E_GLV_TEPC_TEPC_MASK I40E_MASK(0xFFFFFFFF, I40E_GLV_TEPC_TEPC_SHIFT)
-- 
2.9.4

