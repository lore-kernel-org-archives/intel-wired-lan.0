From: Emil Tantilov <emil.s.tantilov@intel.com>
Date: Mon, 16 Oct 2017 16:55:18 -0700
Subject: [Intel-wired-lan] [PATCH] ixgbe: remove unused enum latency_range
Message-ID: <20171016235518.4831.66585.stgit@localhost6.localdomain6>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This enum is no longer needed after
commit: b4ded8327fe ("ixgbe: Update adaptive ITR algorithm")

Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |    7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index fe29689..4085165 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -2515,13 +2515,6 @@ static void ixgbe_configure_msix(struct ixgbe_adapter *adapter)
 	IXGBE_WRITE_REG(&adapter->hw, IXGBE_EIAC, mask);
 }
 
-enum latency_range {
-	lowest_latency = 0,
-	low_latency = 1,
-	bulk_latency = 2,
-	latency_invalid = 255
-};
-
 /**
  * ixgbe_update_itr - update the dynamic ITR value based on statistics
  * @q_vector: structure containing interrupt and ring information

