From: Alice Michael <alice.michael@intel.com>
Date: Mon, 26 Aug 2019 11:16:51 -0700
Subject: [Intel-wired-lan] [next PATCH S9 3/7] i40e: remove
 I40E_AQC_ADD_CLOUD_FILTER_OIP
In-Reply-To: <20190826181655.15106-1-alice.michael@intel.com>
References: <20190826181655.15106-1-alice.michael@intel.com>
Message-ID: <20190826181655.15106-3-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

The bit 0x0001 used in the cloud filters adminq command is reserved, and
is not actually a valid type.

The Linux driver has never used this type, and it's not clear if any
driver ever has.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h b/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
index 21cccec328e3..7ff768761659 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h
@@ -1382,7 +1382,7 @@ struct i40e_aqc_cloud_filters_element_data {
 #define I40E_AQC_ADD_CLOUD_FILTER_MASK	(0x3F << \
 					I40E_AQC_ADD_CLOUD_FILTER_SHIFT)
 /* 0x0000 reserved */
-#define I40E_AQC_ADD_CLOUD_FILTER_OIP			0x0001
+/* 0x0001 reserved */
 /* 0x0002 reserved */
 #define I40E_AQC_ADD_CLOUD_FILTER_IMAC_IVLAN		0x0003
 #define I40E_AQC_ADD_CLOUD_FILTER_IMAC_IVLAN_TEN_ID	0x0004
-- 
2.21.0

