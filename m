From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
Date: Thu, 28 Feb 2019 15:25:54 -0800
Subject: [Intel-wired-lan] [PATCH S17 08/17] ice: Add 52 byte RSS hash key
 support
In-Reply-To: <20190228232603.32156-1-anirudh.venkataramanan@intel.com>
References: <20190228232603.32156-1-anirudh.venkataramanan@intel.com>
Message-ID: <20190228232603.32156-9-anirudh.venkataramanan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Paul Greenwalt <paul.greenwalt@intel.com>

Add support to set 52 byte RSS hash key.

Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
Signed-off-by: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_adminq_cmd.h |  3 +++
 drivers/net/ethernet/intel/ice/ice_lib.c        | 12 +++++-------
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
index 583f92d4db4c..6ef083002f5b 100644
--- a/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/ice/ice_adminq_cmd.h
@@ -1291,6 +1291,9 @@ struct ice_aqc_get_set_rss_key {
 
 #define ICE_AQC_GET_SET_RSS_KEY_DATA_RSS_KEY_SIZE	0x28
 #define ICE_AQC_GET_SET_RSS_KEY_DATA_HASH_KEY_SIZE	0xC
+#define ICE_GET_SET_RSS_KEY_EXTEND_KEY_SIZE \
+				(ICE_AQC_GET_SET_RSS_KEY_DATA_RSS_KEY_SIZE + \
+				 ICE_AQC_GET_SET_RSS_KEY_DATA_HASH_KEY_SIZE)
 
 struct ice_aqc_get_set_rss_keys {
 	u8 standard_rss_key[ICE_AQC_GET_SET_RSS_KEY_DATA_RSS_KEY_SIZE];
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index e75d8c4fadc6..982a3a9e9b8d 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -1394,7 +1394,6 @@ int ice_vsi_manage_rss_lut(struct ice_vsi *vsi, bool ena)
  */
 static int ice_vsi_cfg_rss_lut_key(struct ice_vsi *vsi)
 {
-	u8 seed[ICE_AQC_GET_SET_RSS_KEY_DATA_RSS_KEY_SIZE];
 	struct ice_aqc_get_set_rss_keys *key;
 	struct ice_pf *pf = vsi->back;
 	enum ice_status status;
@@ -1429,13 +1428,12 @@ static int ice_vsi_cfg_rss_lut_key(struct ice_vsi *vsi)
 	}
 
 	if (vsi->rss_hkey_user)
-		memcpy(seed, vsi->rss_hkey_user,
-		       ICE_AQC_GET_SET_RSS_KEY_DATA_RSS_KEY_SIZE);
+		memcpy(key,
+		       (struct ice_aqc_get_set_rss_keys *)vsi->rss_hkey_user,
+		       ICE_GET_SET_RSS_KEY_EXTEND_KEY_SIZE);
 	else
-		netdev_rss_key_fill((void *)seed,
-				    ICE_AQC_GET_SET_RSS_KEY_DATA_RSS_KEY_SIZE);
-	memcpy(&key->standard_rss_key, seed,
-	       ICE_AQC_GET_SET_RSS_KEY_DATA_RSS_KEY_SIZE);
+		netdev_rss_key_fill((void *)key,
+				    ICE_GET_SET_RSS_KEY_EXTEND_KEY_SIZE);
 
 	status = ice_aq_set_rss_key(&pf->hw, vsi->idx, key);
 
-- 
2.14.5

