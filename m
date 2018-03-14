From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Wed, 14 Mar 2018 11:19:17 -0700
Subject: [Intel-wired-lan] [PATCH S88 7/8] i40evf: remove flags that are
 never used
In-Reply-To: <20180314181918.21582-1-jeffrey.t.kirsher@intel.com>
References: <20180314181918.21582-1-jeffrey.t.kirsher@intel.com>
Message-ID: <20180314181918.21582-7-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

These flags were defined, but there is no use within the driver code, so
we don't need to keep them.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/i40evf/i40evf.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf.h b/drivers/net/ethernet/intel/i40evf/i40evf.h
index 8550f78fad79..d8fe200f89f4 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf.h
+++ b/drivers/net/ethernet/intel/i40evf/i40evf.h
@@ -281,13 +281,10 @@ struct i40evf_adapter {
 
 	u32 flags;
 #define I40EVF_FLAG_RX_CSUM_ENABLED		BIT(0)
-#define I40EVF_FLAG_IMIR_ENABLED		BIT(1)
-#define I40EVF_FLAG_MQ_CAPABLE			BIT(2)
 #define I40EVF_FLAG_PF_COMMS_FAILED		BIT(3)
 #define I40EVF_FLAG_RESET_PENDING		BIT(4)
 #define I40EVF_FLAG_RESET_NEEDED		BIT(5)
 #define I40EVF_FLAG_WB_ON_ITR_CAPABLE		BIT(6)
-#define I40EVF_FLAG_OUTER_UDP_CSUM_CAPABLE	BIT(7)
 #define I40EVF_FLAG_ADDR_SET_BY_PF		BIT(8)
 #define I40EVF_FLAG_SERVICE_CLIENT_REQUESTED	BIT(9)
 #define I40EVF_FLAG_CLIENT_NEEDS_OPEN		BIT(10)
-- 
2.14.3

