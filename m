From: Alice Michael <alice.michael@intel.com>
Date: Wed, 19 Apr 2017 09:25:58 -0400
Subject: [Intel-wired-lan] [next PATCH S71 09/10] i40evf: remove
	I40E_FLAG_FDIR_ATR_ENABLED
In-Reply-To: <20170419132559.20459-1-alice.michael@intel.com>
References: <20170419132559.20459-1-alice.michael@intel.com>
Message-ID: <20170419132559.20459-9-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

The flag used by the common code and PF code is I40E_FLAG_FD_ATR_ENABLED,
not *FDIR*. It turns out none of the txrx code actually shared with the
VF driver actually checks the ATR flag. This is made even more obvious
by the typo in the VF header file.

Let's just remove the flag from the VF driver since it's not needed.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40evf/i40evf.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf.h b/drivers/net/ethernet/intel/i40evf/i40evf.h
index 4681c63..b8ada6d 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf.h
+++ b/drivers/net/ethernet/intel/i40evf/i40evf.h
@@ -223,7 +223,6 @@ struct i40evf_adapter {
 #define I40EVF_FLAG_ALLMULTI_ON			BIT(19)
 #define I40EVF_FLAG_LEGACY_RX			BIT(20)
 /* duplicates for common code */
-#define I40E_FLAG_FDIR_ATR_ENABLED		0
 #define I40E_FLAG_DCB_ENABLED			0
 #define I40E_FLAG_RX_CSUM_ENABLED		I40EVF_FLAG_RX_CSUM_ENABLED
 #define I40E_FLAG_WB_ON_ITR_CAPABLE		I40EVF_FLAG_WB_ON_ITR_CAPABLE
-- 
2.9.3

