From: Alice Michael <alice.michael@intel.com>
Date: Fri, 26 Oct 2018 14:33:32 -0700
Subject: [Intel-wired-lan] [next PATCH S98 5/6] i40e: Use correct shift for
 vlan priority
In-Reply-To: <20181026213333.51495-1-alice.michael@intel.com>
References: <20181026213333.51495-1-alice.michael@intel.com>
Message-ID: <20181026213333.51495-5-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Richard Rodriguez <richard.rodriguez@intel.com>

When using port VLAN, for VFs, and setting priority bits, the device
was sending out incorrect priority bits, and also setting the CFI
bit incorrectly.

To fix this, changed shift and mask bit definition for this function, to
use the correct ones.

Signed-off-by: Richard Rodriguez <richard.rodriguez@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
index bf67d62..f962102 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
@@ -13,9 +13,9 @@
 #define I40E_DEFAULT_NUM_MDD_EVENTS_ALLOWED	3
 #define I40E_DEFAULT_NUM_INVALID_MSGS_ALLOWED	10
 
-#define I40E_VLAN_PRIORITY_SHIFT	12
+#define I40E_VLAN_PRIORITY_SHIFT	13
 #define I40E_VLAN_MASK			0xFFF
-#define I40E_PRIORITY_MASK		0x7000
+#define I40E_PRIORITY_MASK		0xE000
 
 /* Various queue ctrls */
 enum i40e_queue_ctrl {
-- 
2.9.5

