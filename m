From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu,  4 May 2017 13:54:12 -0700
Subject: [Intel-wired-lan] [PATCH] i40e: fix incorrect assignment of
	I40E_FLAG_HW_ATR_EVICT_CAPABLE
Message-ID: <20170504205412.32375-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

When attempting to setup I40E_FLAG_HW_ATR_EVICT_ENABLED, we accidentally
broke all PF flags because we directly assigned the value of
I40E_FLAG_HW_ATR_EVICT_CAPABLE.

This is incorrect, but the obvious fix of changing the assignment to an
|= is not correct either, since I40E_FLAG_HW_ATR_EVICT_CAPABLE is
already set in the feature list.

Instead, we intended to set the I40E_FLAG_HW_ATR_EVICT_ENABLED flag, but
only if I40E_FLAG_HW_ATR_EVICT_CAPABLE had already been set.

Without this patch we will have many problems including disabling MSI-X
support, and not having HW ATR eviction actually enabled.

Fixes: 47994c119a36 ("i40e: remove hw_disabled_flags in favor of using separate flag bits", 2017-04-19)
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)


The fix provided by Sridhar fixes the major problem but would result in
us not actually having HW_ATR_EVICT_ENABLED properly set. The whole
process of this series got messed up when we sent upstream, and I am
working on sorting it out.

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index e4eb97832413..6200a9a55dc2 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -8822,11 +8822,12 @@ static int i40e_sw_init(struct i40e_pf *pf)
 		    (pf->hw.aq.api_min_ver > 4))) {
 		/* Supported in FW API version higher than 1.4 */
 		pf->flags |= I40E_FLAG_GENEVE_OFFLOAD_CAPABLE;
-		pf->flags = I40E_FLAG_HW_ATR_EVICT_CAPABLE;
-	} else {
-		pf->flags = I40E_FLAG_HW_ATR_EVICT_CAPABLE;
 	}
 
+	/* Enable HW ATR eviction if possible */
+	if (pf->flags & I40E_FLAG_HW_ATR_EVICT_CAPABLE)
+		pf->flags |= I40E_FLAG_HW_ATR_EVICT_ENABLED;
+
 	pf->eeprom_version = 0xDEAD;
 	pf->lan_veb = I40E_NO_VEB;
 	pf->lan_vsi = I40E_NO_VSI;
-- 
2.13.0.rc0.317.gcc792a6cad5a

