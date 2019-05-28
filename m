From: Alice Michael <alice.michael@intel.com>
Date: Tue, 28 May 2019 10:59:15 -0700
Subject: [Intel-wired-lan] [next PATCH S6 1/7] i40e: fix 'Unknown bps' in
 dmesg for 2.5Gb/5Gb speeds
Message-ID: <20190528175921.30534-1-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

This patch fixes 'NIC Link is Up, Unknown bps' message in dmesg
for 2.5Gb/5Gb speeds. This problem is fixed by adding constants
for VIRTCHNL_LINK_SPEED_2_5GB and VIRTCHNL_LINK_SPEED_5GB cases
in the i40e_virtchnl_link_speed() function.

Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_prototype.h | 4 ++++
 include/linux/avf/virtchnl.h                     | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_prototype.h b/drivers/net/ethernet/intel/i40e/i40e_prototype.h
index 882627073dce..eac88bcc6c06 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_prototype.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_prototype.h
@@ -350,6 +350,10 @@ i40e_virtchnl_link_speed(enum i40e_aq_link_speed link_speed)
 		return VIRTCHNL_LINK_SPEED_100MB;
 	case I40E_LINK_SPEED_1GB:
 		return VIRTCHNL_LINK_SPEED_1GB;
+	case I40E_LINK_SPEED_2_5GB:
+		return VIRTCHNL_LINK_SPEED_2_5GB;
+	case I40E_LINK_SPEED_5GB:
+		return VIRTCHNL_LINK_SPEED_5GB;
 	case I40E_LINK_SPEED_10GB:
 		return VIRTCHNL_LINK_SPEED_10GB;
 	case I40E_LINK_SPEED_40GB:
diff --git a/include/linux/avf/virtchnl.h b/include/linux/avf/virtchnl.h
index 7605b5919c3a..1fd0ca9257fc 100644
--- a/include/linux/avf/virtchnl.h
+++ b/include/linux/avf/virtchnl.h
@@ -75,12 +75,14 @@ enum virtchnl_status_code {
 #define VIRTCHNL_ERR_PARAM VIRTCHNL_STATUS_ERR_PARAM
 #define VIRTCHNL_STATUS_NOT_SUPPORTED VIRTCHNL_STATUS_ERR_NOT_SUPPORTED
 
+#define VIRTCHNL_LINK_SPEED_2_5GB_SHIFT		0x0
 #define VIRTCHNL_LINK_SPEED_100MB_SHIFT		0x1
 #define VIRTCHNL_LINK_SPEED_1000MB_SHIFT	0x2
 #define VIRTCHNL_LINK_SPEED_10GB_SHIFT		0x3
 #define VIRTCHNL_LINK_SPEED_40GB_SHIFT		0x4
 #define VIRTCHNL_LINK_SPEED_20GB_SHIFT		0x5
 #define VIRTCHNL_LINK_SPEED_25GB_SHIFT		0x6
+#define VIRTCHNL_LINK_SPEED_5GB_SHIFT		0x7
 
 enum virtchnl_link_speed {
 	VIRTCHNL_LINK_SPEED_UNKNOWN	= 0,
@@ -90,6 +92,8 @@ enum virtchnl_link_speed {
 	VIRTCHNL_LINK_SPEED_40GB	= BIT(VIRTCHNL_LINK_SPEED_40GB_SHIFT),
 	VIRTCHNL_LINK_SPEED_20GB	= BIT(VIRTCHNL_LINK_SPEED_20GB_SHIFT),
 	VIRTCHNL_LINK_SPEED_25GB	= BIT(VIRTCHNL_LINK_SPEED_25GB_SHIFT),
+	VIRTCHNL_LINK_SPEED_2_5GB	= BIT(VIRTCHNL_LINK_SPEED_2_5GB_SHIFT),
+	VIRTCHNL_LINK_SPEED_5GB		= BIT(VIRTCHNL_LINK_SPEED_5GB_SHIFT),
 };
 
 /* for hsplit_0 field of Rx HMC context */
-- 
2.19.2

