From: Alice Michael <alice.michael@intel.com>
Date: Mon, 26 Aug 2019 11:16:52 -0700
Subject: [Intel-wired-lan] [next PATCH S9 4/7] i40e: mark additional missing
 bits as reserved
In-Reply-To: <20190826181655.15106-1-alice.michael@intel.com>
References: <20190826181655.15106-1-alice.michael@intel.com>
Message-ID: <20190826181655.15106-4-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

Mark bits 0xD through 0xF for the command flags of a cloud filter as
reserved. These bits are not yet defined and are considered as reserved
in the data sheet.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h b/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
index 7ff768761659..530613f31527 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
@@ -1394,6 +1394,9 @@ struct i40e_aqc_cloud_filters_element_data {
 #define I40E_AQC_ADD_CLOUD_FILTER_IMAC			0x000A
 #define I40E_AQC_ADD_CLOUD_FILTER_OMAC_TEN_ID_IMAC	0x000B
 #define I40E_AQC_ADD_CLOUD_FILTER_IIP			0x000C
+/* 0x000D reserved */
+/* 0x000E reserved */
+/* 0x000F reserved */
 /* 0x0010 to 0x0017 is for custom filters */
 #define I40E_AQC_ADD_CLOUD_FILTER_IP_PORT		0x0010 /* Dest IP + L4 Port */
 #define I40E_AQC_ADD_CLOUD_FILTER_MAC_PORT		0x0011 /* Dest MAC + L4 Port */
-- 
2.21.0

