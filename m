From: Alice Michael <alice.michael@intel.com>
Date: Tue, 31 Jul 2018 03:41:43 -0700
Subject: [Intel-wired-lan] [next PATCH S93 06/11] i40e: Write access
 protected registers through AQC
In-Reply-To: <20180731104148.11896-1-alice.michael@intel.com>
References: <20180731104148.11896-1-alice.michael@intel.com>
Message-ID: <20180731104148.11896-6-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Piotr Azarewicz <piotr.azarewicz@intel.com>

Write access protected registers (GLGEN_RTRIG and GLGEN_RSTCTL) through
AQC.

Signed-off-by: Piotr Azarewicz <piotr.azarewicz@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_common.c   | 4 ++++
 drivers/net/ethernet/intel/i40evf/i40e_common.c | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index eb2d153..ad710b2 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -6,6 +6,10 @@
 #include "i40e_prototype.h"
 #include <linux/avf/virtchnl.h>
 
+/* For 32-bit AQ writes. */
+#define wraq32(base_addr, reg, value) i40e_aq_debug_write_register( \
+					(base_addr), (reg), (value), NULL)
+
 /**
  * i40e_set_mac_type - Sets MAC type
  * @hw: pointer to the HW structure
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_common.c b/drivers/net/ethernet/intel/i40evf/i40e_common.c
index eea280ba..04c6c6b 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40evf/i40e_common.c
@@ -6,6 +6,10 @@
 #include "i40e_prototype.h"
 #include <linux/avf/virtchnl.h>
 
+/* For 32-bit AQ writes. */
+#define wraq32(base_addr, reg, value) i40e_aq_debug_write_register( \
+					(base_addr), (reg), (value), NULL)
+
 /**
  * i40e_set_mac_type - Sets MAC type
  * @hw: pointer to the HW structure
-- 
2.9.5

