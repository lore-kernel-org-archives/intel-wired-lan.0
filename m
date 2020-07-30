From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Wed, 29 Jul 2020 17:19:11 -0700
Subject: [Intel-wired-lan] [PATCH S51 02/13] ice: fix the vsi_id mask to be
 10 bit for set_rss_lut
In-Reply-To: <20200730001922.52568-1-anthony.l.nguyen@intel.com>
References: <20200730001922.52568-1-anthony.l.nguyen@intel.com>
Message-ID: <20200730001922.52568-2-anthony.l.nguyen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Kiran Patil <kiran.patil@intel.com>

set_rss_lut failed due to incorrect vsi_id mask. vsi_id is 10 bit
but mask was 0x1FF whereas it should be 0x3FF.

For vsi_num >= 512, FW set_rss_lut has been failing with return code
EACCESS (VSI ownership issue) because software was providing
incorrect vsi_num (dropping 10th bit due to incorrect mask) for
set_rss_lut admin command

Signed-off-by: Kiran Patil <kiran.patil@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_adminq_cmd.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
index 7fec9309d379..ba9375218fef 100644
--- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
@@ -1581,7 +1581,7 @@ struct ice_aqc_get_set_rss_keys {
 struct ice_aqc_get_set_rss_lut {
 #define ICE_AQC_GSET_RSS_LUT_VSI_VALID	BIT(15)
 #define ICE_AQC_GSET_RSS_LUT_VSI_ID_S	0
-#define ICE_AQC_GSET_RSS_LUT_VSI_ID_M	(0x1FF << ICE_AQC_GSET_RSS_LUT_VSI_ID_S)
+#define ICE_AQC_GSET_RSS_LUT_VSI_ID_M	(0x3FF << ICE_AQC_GSET_RSS_LUT_VSI_ID_S)
 	__le16 vsi_id;
 #define ICE_AQC_GSET_RSS_LUT_TABLE_TYPE_S	0
 #define ICE_AQC_GSET_RSS_LUT_TABLE_TYPE_M	\
-- 
2.20.1

