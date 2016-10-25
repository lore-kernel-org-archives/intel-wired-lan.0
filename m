From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Tue, 25 Oct 2016 15:18:03 -0700
Subject: [Intel-wired-lan] [next PATCH S51 9/9] i40e: Add protocols over
	MCTP to i40e_aq_discover_capabilities
In-Reply-To: <1477433883-3248-1-git-send-email-bimmy.pujari@intel.com>
References: <1477433883-3248-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1477433883-3248-10-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Piotr Raczynski <piotr.raczynski@intel.com>

Add logical_id to I40E_AQ_CAP_ID_MNG_MODE capability starting from major
version 2.

Signed-off-by: Piotr Raczynski <piotr.raczynski@intel.com>
Change-ID: Idb29214b172ea5c70cbd45a99e6745c0215af7e4
---
 drivers/net/ethernet/intel/i40e/i40e_common.c | 8 ++++++++
 drivers/net/ethernet/intel/i40e/i40e_type.h   | 4 ++++
 drivers/net/ethernet/intel/i40evf/i40e_type.h | 4 ++++
 3 files changed, 16 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index fb72fb3..e75cc1c 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -3181,6 +3181,14 @@ static void i40e_parse_discover_capabilities(struct i40e_hw *hw, void *buff,
 			break;
 		case I40E_AQ_CAP_ID_MNG_MODE:
 			p->management_mode = number;
+			if (major_rev > 1) {
+				p->mng_protocols_over_mctp = logical_id;
+				i40e_debug(hw, I40E_DEBUG_INIT,
+					   "HW Capability: Protocols over MCTP = %d\n",
+					   p->mng_protocols_over_mctp);
+			} else {
+				p->mng_protocols_over_mctp = 0;
+			}
 			break;
 		case I40E_AQ_CAP_ID_NPAR_ACTIVE:
 			p->npar_enable = number;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_type.h b/drivers/net/ethernet/intel/i40e/i40e_type.h
index bffe1e3..20ad389 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_type.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_type.h
@@ -263,6 +263,10 @@ struct i40e_hw_capabilities {
 #define I40E_NVM_IMAGE_TYPE_UDP_CLOUD	0x3
 
 	u32  management_mode;
+	u32  mng_protocols_over_mctp;
+#define I40E_MNG_PROTOCOL_PLDM		0x2
+#define I40E_MNG_PROTOCOL_OEM_COMMANDS	0x4
+#define I40E_MNG_PROTOCOL_NCSI		0x8
 	u32  npar_enable;
 	u32  os2bmc;
 	u32  valid_functions;
diff --git a/drivers/net/ethernet/intel/i40evf/i40e_type.h b/drivers/net/ethernet/intel/i40evf/i40e_type.h
index dfa2446..f3b6716 100644
--- a/drivers/net/ethernet/intel/i40evf/i40e_type.h
+++ b/drivers/net/ethernet/intel/i40evf/i40e_type.h
@@ -237,6 +237,10 @@ struct i40e_hw_capabilities {
 #define I40E_NVM_IMAGE_TYPE_UDP_CLOUD	0x3
 
 	u32  management_mode;
+	u32  mng_protocols_over_mctp;
+#define I40E_MNG_PROTOCOL_PLDM		0x2
+#define I40E_MNG_PROTOCOL_OEM_COMMANDS	0x4
+#define I40E_MNG_PROTOCOL_NCSI		0x8
 	u32  npar_enable;
 	u32  os2bmc;
 	u32  valid_functions;
-- 
2.4.11

