From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed, 13 Apr 2016 14:31:15 -0700
Subject: [Intel-wired-lan] [PATCH v1 04/13] i40e/i40evf: fix I40E_MASK
	signed shift overflow warnings
In-Reply-To: <1460583084-16900-1-git-send-email-jacob.e.keller@intel.com>
References: <1460583084-16900-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <1460583084-16900-5-git-send-email-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

GCC 6 has a new warning which will display when you attempt to left
shift a signed value beyond the storage size of the type. I40E_MASK
generates a mask value for 32bit registers. Properly typecast the mask
value and place the values in parenthesis to prevent macro expansion
issues.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_type.h   | 2 +-
 drivers/net/ethernet/intel/i40evf/i40e_type.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_type.h b/drivers/net/ethernet/intel/i40e/i40e_type.h
index 8aa14aacdd35..bd5f13bef83c 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_type.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_type.h
@@ -36,7 +36,7 @@
 #include "i40e_devids.h"
 
 /* I40E_MASK is a macro used on 32 bit registers */
-#define I40E_MASK(mask, shift) (mask << shift)
+#define I40E_MASK(mask, shift) ((u32)(mask) << (shift))
 
 #define I40E_MAX_VSI_QP			16
 #define I40E_MAX_VF_VSI			3
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_type.h b/drivers/net/ethernet/intel/i40evf/i40e_type.h
index bfc97c2f22bb..97f96e0d9c4c 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_type.h
+++ b/drivers/net/ethernet/intel/i40evf/i40e_type.h
@@ -36,7 +36,7 @@
 #include "i40e_devids.h"
 
 /* I40E_MASK is a macro used on 32 bit registers */
-#define I40E_MASK(mask, shift) (mask << shift)
+#define I40E_MASK(mask, shift) ((u32)(mask) << (shift))
 
 #define I40E_MAX_VSI_QP			16
 #define I40E_MAX_VF_VSI			3
-- 
2.8.1.102.ga49ec4a

