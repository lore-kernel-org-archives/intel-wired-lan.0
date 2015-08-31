From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Mon, 31 Aug 2015 19:54:41 -0400
Subject: [Intel-wired-lan] [next PATCH S14 01/15] i40e/i40evf: Add new link
	status defines
In-Reply-To: <1441065295-234333-1-git-send-email-catherine.sullivan@intel.com>
References: <1441065295-234333-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1441065295-234333-2-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Shannon Nelson <shannon.nelson@intel.com>

Add the new Port link status bit and rename the link status to function
link status.

Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
Change-ID: I71289327ae62638ce967b6ad40114caf998b6dab
---
 drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h   | 4 +++-
 drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h b/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
index 785b3db..02d5225 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
@@ -1722,11 +1722,13 @@ struct i40e_aqc_get_link_status {
 	u8	phy_type;    /* i40e_aq_phy_type   */
 	u8	link_speed;  /* i40e_aq_link_speed */
 	u8	link_info;
-#define I40E_AQ_LINK_UP			0x01
+#define I40E_AQ_LINK_UP			0x01    /* obsolete */
+#define I40E_AQ_LINK_UP_FUNCTION	0x01
 #define I40E_AQ_LINK_FAULT		0x02
 #define I40E_AQ_LINK_FAULT_TX		0x04
 #define I40E_AQ_LINK_FAULT_RX		0x08
 #define I40E_AQ_LINK_FAULT_REMOTE	0x10
+#define I40E_AQ_LINK_UP_PORT		0x20
 #define I40E_AQ_MEDIA_AVAILABLE		0x40
 #define I40E_AQ_SIGNAL_DETECT		0x80
 	u8	an_info;
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h b/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h
index c802209..fcb9ef3 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h
@@ -1719,11 +1719,13 @@ struct i40e_aqc_get_link_status {
 	u8	phy_type;    /* i40e_aq_phy_type   */
 	u8	link_speed;  /* i40e_aq_link_speed */
 	u8	link_info;
-#define I40E_AQ_LINK_UP			0x01
+#define I40E_AQ_LINK_UP			0x01    /* obsolete */
+#define I40E_AQ_LINK_UP_FUNCTION	0x01
 #define I40E_AQ_LINK_FAULT		0x02
 #define I40E_AQ_LINK_FAULT_TX		0x04
 #define I40E_AQ_LINK_FAULT_RX		0x08
 #define I40E_AQ_LINK_FAULT_REMOTE	0x10
+#define I40E_AQ_LINK_UP_PORT		0x20
 #define I40E_AQ_MEDIA_AVAILABLE		0x40
 #define I40E_AQ_SIGNAL_DETECT		0x80
 	u8	an_info;
-- 
1.9.3

