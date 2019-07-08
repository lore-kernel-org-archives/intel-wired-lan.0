From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon,  8 Jul 2019 16:12:36 -0700
Subject: [Intel-wired-lan] [PATCH 19/19] fm10k: fix fm10k_get_fault_pf to
 read correct address
In-Reply-To: <20190708231236.20516-1-jacob.e.keller@intel.com>
References: <20190708231236.20516-1-jacob.e.keller@intel.com>
Message-ID: <20190708231236.20516-20-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Fix assignment of the FM10K_FAULT_ADDR_LO register into fault->address
by using a bit-wise |= operation. Without this, the low address is
completely overwriting the high potion of the address. This caused the
fault to incorrectly return only the lower 32 bits of the fault address.

This issue was detected by cppcheck and resolves the following warnings
produced by that tool:

[fm10k_pf.c:1668] -> [fm10k_pf.c:1670]: (style) Variable
'fault->address' is reassigned a value before the old one has been used.

[fm10k_pf.c:1669] -> [fm10k_pf.c:1670]: (style) Variable
'fault->address' is reassigned a value before the old one has been used.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_pf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pf.c b/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
index 095c5b0e4096..be07bfdb0bb4 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
@@ -1565,7 +1565,7 @@ static s32 fm10k_get_fault_pf(struct fm10k_hw *hw, int type,
 	/* read remaining fields */
 	fault->address = fm10k_read_reg(hw, type + FM10K_FAULT_ADDR_HI);
 	fault->address <<= 32;
-	fault->address = fm10k_read_reg(hw, type + FM10K_FAULT_ADDR_LO);
+	fault->address |= fm10k_read_reg(hw, type + FM10K_FAULT_ADDR_LO);
 	fault->specinfo = fm10k_read_reg(hw, type + FM10K_FAULT_SPECINFO);
 
 	/* clear valid bit to allow for next error */
-- 
2.22.0.214.g8dca754b1e87

