From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Fri,  5 Jun 2015 12:20:26 -0400
Subject: [Intel-wired-lan] [intel-wired-lan][net-next PATCH S07 02/10]
	i40e/i40evf: Add flags for X722 capabilities
In-Reply-To: <1433521234-33355-1-git-send-email-catherine.sullivan@intel.com>
References: <1433521234-33355-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1433521234-33355-3-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Anjali Singhai Jain <anjali.singhai@intel.com>

Add capapbilities flags specific to X722.

Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
Signed-off-by: Catherine Sullivan <catherine.sullivan@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h      | 7 +++++++
 drivers/net/ethernet/intel/i40e/i40e_main.c | 8 ++++++++
 drivers/net/ethernet/intel/i40evf/i40evf.h  | 5 +++++
 3 files changed, 20 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index 8b4dec9..7bfb471 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -298,6 +298,7 @@ struct i40e_pf {
 #define I40E_FLAG_VMDQ_ENABLED                 BIT_ULL(7)
 #define I40E_FLAG_FDIR_REQUIRES_REINIT         BIT_ULL(8)
 #define I40E_FLAG_NEED_LINK_UPDATE             BIT_ULL(9)
+#define I40E_FLAG_IWARP_ENABLED                BIT_ULL(10)
 #ifdef I40E_FCOE
 #define I40E_FLAG_FCOE_ENABLED                 BIT_ULL(11)
 #endif /* I40E_FCOE */
@@ -318,6 +319,12 @@ struct i40e_pf {
 #endif
 #define I40E_FLAG_PORT_ID_VALID                BIT_ULL(28)
 #define I40E_FLAG_DCB_CAPABLE                  BIT_ULL(29)
+#define I40E_FLAG_RSS_AQ_CAPABLE               BIT_ULL(31)
+#define I40E_FLAG_HW_ATR_EVICT_CAPABLE         BIT_ULL(32)
+#define I40E_FLAG_OUTER_UDP_CSUM_CAPABLE       BIT_ULL(33)
+#define I40E_FLAG_128_QP_RSS_CAPABLE           BIT_ULL(34)
+#define I40E_FLAG_WB_ON_ITR_CAPABLE            BIT_ULL(35)
+#define I40E_FLAG_MULTIPLE_TCP_UDP_RSS_PCTYPE  BIT_ULL(38)
 
 	/* tracks features that get auto disabled by errors */
 	u64 auto_disable_flags;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index fdf4bd5..bb454cc 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -7781,6 +7781,14 @@ static int i40e_sw_init(struct i40e_pf *pf)
 					I40E_MAX_VF_COUNT);
 	}
 #endif /* CONFIG_PCI_IOV */
+	if (pf->hw.mac.type == I40E_MAC_X722) {
+		pf->flags |= I40E_FLAG_RSS_AQ_CAPABLE |
+			     I40E_FLAG_128_QP_RSS_CAPABLE |
+			     I40E_FLAG_HW_ATR_EVICT_CAPABLE |
+			     I40E_FLAG_OUTER_UDP_CSUM_CAPABLE |
+			     I40E_FLAG_WB_ON_ITR_CAPABLE |
+			     I40E_FLAG_MULTIPLE_TCP_UDP_RSS_PCTYPE;
+	}
 	pf->eeprom_version = 0xDEAD;
 	pf->lan_veb = I40E_NO_VEB;
 	pf->lan_vsi = I40E_NO_VSI;
diff --git a/drivers/net/ethernet/intel/i40evf/i40evf.h b/drivers/net/ethernet/intel/i40evf/i40evf.h
index b2f899c..a12f80e2 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf.h
+++ b/drivers/net/ethernet/intel/i40evf/i40evf.h
@@ -218,11 +218,15 @@ struct i40evf_adapter {
 #define I40EVF_FLAG_PF_COMMS_FAILED              BIT(8)
 #define I40EVF_FLAG_RESET_PENDING                BIT(9)
 #define I40EVF_FLAG_RESET_NEEDED                 BIT(10)
+#define I40EVF_FLAG_WB_ON_ITR_CAPABLE            BIT(11)
+#define I40EVF_FLAG_OUTER_UDP_CSUM_CAPABLE       BIT(12)
 /* duplcates for common code */
 #define I40E_FLAG_FDIR_ATR_ENABLED		 0
 #define I40E_FLAG_DCB_ENABLED			 0
 #define I40E_FLAG_IN_NETPOLL			 I40EVF_FLAG_IN_NETPOLL
 #define I40E_FLAG_RX_CSUM_ENABLED                I40EVF_FLAG_RX_CSUM_ENABLED
+#define I40E_FLAG_WB_ON_ITR_CAPABLE           I40EVF_FLAG_WB_ON_ITR_CAPABLE
+#define I40E_FLAG_OUTER_UDP_CSUM_CAPABLE      I40EVF_FLAG_OUTER_UDP_CSUM_CAPABLE
 	/* flags for admin queue service task */
 	u32 aq_required;
 #define I40EVF_FLAG_AQ_ENABLE_QUEUES		BIT(0)
@@ -234,6 +238,7 @@ struct i40evf_adapter {
 #define I40EVF_FLAG_AQ_CONFIGURE_QUEUES		BIT(6)
 #define I40EVF_FLAG_AQ_MAP_VECTORS		BIT(7)
 #define I40EVF_FLAG_AQ_HANDLE_RESET		BIT(8)
+#define I40EVF_FLAG_AQ_CONFIGURE_RSS		BIT(9)
 #define I40EVF_FLAG_AQ_GET_CONFIG		BIT(10)
 
 	/* OS defined structs */
-- 
1.9.3

