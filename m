From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Tue, 16 Apr 2019 10:34:59 -0700
Subject: [Intel-wired-lan] [PATCH S21 10/14] ice: Move define for
 ICE_AQC_DRIVER_UNLOADING
In-Reply-To: <20190416173503.29847-1-anirudh.venkataramanan@intel.com>
References: <20190416173503.29847-1-anirudh.venkataramanan@intel.com>
Message-ID: <20190416173503.29847-11-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The define describing the bits for the struct field should be below
the field itself.

Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_adminq_cmd.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
index b1efe55e4d7e..7a9da5320e96 100644
--- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
@@ -35,8 +35,8 @@ struct ice_aqc_get_ver {
 
 /* Queue Shutdown (direct 0x0003) */
 struct ice_aqc_q_shutdown {
-#define ICE_AQC_DRIVER_UNLOADING	BIT(0)
 	__le32 driver_unloading;
+#define ICE_AQC_DRIVER_UNLOADING	BIT(0)
 	u8 reserved[12];
 };
 
-- 
2.20.1

