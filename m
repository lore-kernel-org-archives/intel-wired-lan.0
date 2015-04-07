From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Tue,  7 Apr 2015 19:45:38 -0400
Subject: [Intel-wired-lan] [net-next S3 09/13] i40e/i40evf: Save WR_CSR_PROT
	field from DEV/FUNC capabilities
In-Reply-To: <1428450342-48517-1-git-send-email-catherine.sullivan@intel.com>
References: <1428450342-48517-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1428450342-48517-9-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Kevin Scott <kevin.c.scott@intel.com>

Store the 8 bytes of the WR_CSR_PROT field returned as part of the get
device/function capabilities AQ command.

Signed-off-by: Kevin Scott <kevin.c.scott@intel.com>
Change-ID: Ifcaeea2ff29885fa769e4f384c7db88a25e8afd0
---
 drivers/net/ethernet/intel/i40e/i40e_common.c | 5 +++++
 drivers/net/ethernet/intel/i40e/i40e_type.h   | 1 +
 drivers/net/ethernet/intel/i40evf/i40e_type.h | 1 +
 3 files changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index ce522d7..0bae22d 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -2397,6 +2397,7 @@ i40e_aq_erase_nvm_exit:
 #define I40E_DEV_FUNC_CAP_LED		0x61
 #define I40E_DEV_FUNC_CAP_SDP		0x62
 #define I40E_DEV_FUNC_CAP_MDIO		0x63
+#define I40E_DEV_FUNC_CAP_WR_CSR_PROT	0x64
 
 /**
  * i40e_parse_discover_capabilities
@@ -2541,6 +2542,10 @@ static void i40e_parse_discover_capabilities(struct i40e_hw *hw, void *buff,
 			p->fd_filters_guaranteed = number;
 			p->fd_filters_best_effort = logical_id;
 			break;
+		case I40E_DEV_FUNC_CAP_WR_CSR_PROT:
+			p->wr_csr_prot = (u64)number;
+			p->wr_csr_prot |= (u64)logical_id << 32;
+			break;
 		default:
 			break;
 		}
diff --git a/drivers/net/ethernet/intel/i40e/i40e_type.h b/drivers/net/ethernet/intel/i40e/i40e_type.h
index 67c7bc9e9..568e855 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_type.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_type.h
@@ -242,6 +242,7 @@ struct i40e_hw_capabilities {
 	u8 rx_buf_chain_len;
 	u32 enabled_tcmap;
 	u32 maxtc;
+	u64 wr_csr_prot;
 };
 
 struct i40e_mac_info {
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_type.h b/drivers/net/ethernet/intel/i40evf/i40e_type.h
index 9c79cb6..ec9d83a 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_type.h
+++ b/drivers/net/ethernet/intel/i40evf/i40e_type.h
@@ -242,6 +242,7 @@ struct i40e_hw_capabilities {
 	u8 rx_buf_chain_len;
 	u32 enabled_tcmap;
 	u32 maxtc;
+	u64 wr_csr_prot;
 };
 
 struct i40e_mac_info {
-- 
1.9.3

