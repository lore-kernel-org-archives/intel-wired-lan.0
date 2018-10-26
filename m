From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Fri, 26 Oct 2018 10:41:05 -0700
Subject: [Intel-wired-lan] [PATCH S8 16/16] ice: Fix NVM mask defines
In-Reply-To: <20181026174105.11628-1-anirudh.venkataramanan@intel.com>
References: <20181026174105.11628-1-anirudh.venkataramanan@intel.com>
Message-ID: <20181026174105.11628-17-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Lev Faerman <lev.faerman@intel.com>

Fixes bad masks that would break compilation when evaluated.

Signed-off-by: Lev Faerman <lev.faerman@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_adminq_cmd.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
index 602f02a0a2d1..4078070881ce 100644
--- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
@@ -1066,10 +1066,10 @@ struct ice_aqc_nvm {
 #define ICE_AQC_NVM_LAST_CMD		BIT(0)
 #define ICE_AQC_NVM_PCIR_REQ		BIT(0)	/* Used by NVM Update reply */
 #define ICE_AQC_NVM_PRESERVATION_S	1
-#define ICE_AQC_NVM_PRESERVATION_M	(3 << CSR_AQ_NVM_PRESERVATION_S)
-#define ICE_AQC_NVM_NO_PRESERVATION	(0 << CSR_AQ_NVM_PRESERVATION_S)
+#define ICE_AQC_NVM_PRESERVATION_M	(3 << ICE_AQC_NVM_PRESERVATION_S)
+#define ICE_AQC_NVM_NO_PRESERVATION	(0 << ICE_AQC_NVM_PRESERVATION_S)
 #define ICE_AQC_NVM_PRESERVE_ALL	BIT(1)
-#define ICE_AQC_NVM_PRESERVE_SELECTED	(3 << CSR_AQ_NVM_PRESERVATION_S)
+#define ICE_AQC_NVM_PRESERVE_SELECTED	(3 << ICE_AQC_NVM_PRESERVATION_S)
 #define ICE_AQC_NVM_FLASH_ONLY		BIT(7)
 	__le16 module_typeid;
 	__le16 length;
-- 
2.14.3

