From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Fri,  2 Aug 2019 01:25:30 -0700
Subject: [Intel-wired-lan] [PATCH S26 12/15] ice: update driver unloading
 field for Queue Shutdown AQ command
In-Reply-To: <20190802082533.23083-1-anthony.l.nguyen@intel.com>
References: <20190802082533.23083-1-anthony.l.nguyen@intel.com>
Message-ID: <20190802082533.23083-12-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Bruce Allan <bruce.w.allan@intel.com>

According to recent specification versions, the field in the Queue Shutdown
AdminQ command consisting of the "driver unloading" indication is not a 4
byte field (it is byte.bit 16.0).  Change it to a byte and remove the
unnecessary endian conversion.

Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_adminq_cmd.h | 4 ++--
 drivers/net/ethernet/intel/ice/ice_common.c     | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
index bf9aa533a7c6..8ebc695171b6 100644
--- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
@@ -35,9 +35,9 @@ struct ice_aqc_get_ver {
 
 /* Queue Shutdown (direct 0x0003) */
 struct ice_aqc_q_shutdown {
-	__le32 driver_unloading;
+	u8 driver_unloading;
 #define ICE_AQC_DRIVER_UNLOADING	BIT(0)
-	u8 reserved[12];
+	u8 reserved[15];
 };
 
 /* Request resource ownership (direct 0x0008)
diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 847ddd9a7449..0471698d9499 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -1259,7 +1259,7 @@ enum ice_status ice_aq_q_shutdown(struct ice_hw *hw, bool unloading)
 	ice_fill_dflt_direct_cmd_desc(&desc, ice_aqc_opc_q_shutdown);
 
 	if (unloading)
-		cmd->driver_unloading = cpu_to_le32(ICE_AQC_DRIVER_UNLOADING);
+		cmd->driver_unloading = ICE_AQC_DRIVER_UNLOADING;
 
 	return ice_aq_send_cmd(hw, &desc, NULL, 0, NULL);
 }
-- 
2.20.1

