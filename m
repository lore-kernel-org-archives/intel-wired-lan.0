From: Alice Michael <alice.michael@intel.com>
Date: Thu, 13 Apr 2017 04:45:50 -0400
Subject: [Intel-wired-lan] [next PATCH S70 07/12] i40e: remove
	I40E_FLAG_IN_NETPOLL entirely
In-Reply-To: <20170413084555.6962-1-alice.michael@intel.com>
References: <20170413084555.6962-1-alice.michael@intel.com>
Message-ID: <20170413084555.6962-7-alice.michael@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

This flag was originally intended to be used to let some
driver code know when we were running from netpoll.
Ultimately this was not necessary and we never used it.
Let's remove it

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Change-ID: I43b72483d91c1638071d2a7f389ab171ec5b796a
---
 drivers/net/ethernet/intel/i40evf/i40evf.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf.h b/drivers/net/ethernet/intel/i40evf/i40evf.h
index 7bbd11a..40f56e2 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf.h
+++ b/drivers/net/ethernet/intel/i40evf/i40evf.h
@@ -202,7 +202,6 @@ struct i40evf_adapter {
 
 	u32 flags;
 #define I40EVF_FLAG_RX_CSUM_ENABLED		BIT(0)
-#define I40EVF_FLAG_IN_NETPOLL			BIT(4)
 #define I40EVF_FLAG_IMIR_ENABLED		BIT(5)
 #define I40EVF_FLAG_MQ_CAPABLE			BIT(6)
 #define I40EVF_FLAG_PF_COMMS_FAILED		BIT(8)
@@ -221,7 +220,6 @@ struct i40evf_adapter {
 /* duplicates for common code */
 #define I40E_FLAG_FDIR_ATR_ENABLED		0
 #define I40E_FLAG_DCB_ENABLED			0
-#define I40E_FLAG_IN_NETPOLL			I40EVF_FLAG_IN_NETPOLL
 #define I40E_FLAG_RX_CSUM_ENABLED		I40EVF_FLAG_RX_CSUM_ENABLED
 #define I40E_FLAG_WB_ON_ITR_CAPABLE		I40EVF_FLAG_WB_ON_ITR_CAPABLE
 #define I40E_FLAG_OUTER_UDP_CSUM_CAPABLE	I40EVF_FLAG_OUTER_UDP_CSUM_CAPABLE
-- 
2.9.3

