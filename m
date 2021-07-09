From: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
Date: Sat, 10 Jul 2021 07:40:17 +0800
Subject: [Intel-wired-lan] [PATCH v1] igc: Set QBVCYCLET_S to 0 for TSN
 Basic Scheduling
Message-ID: <20210709234017.22817-1-muhammad.husaini.zulkifli@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

According to datasheet section 8.12.19, when there's no TSN offloading
Shadow_QbvCycle bit[29:0] must be set to zero for basic scheduling.

Signed-off-by: Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_tsn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.c b/drivers/net/ethernet/intel/igc/igc_tsn.c
index 174103c4bea6..4dbbb8a32ce9 100644
--- a/drivers/net/ethernet/intel/igc/igc_tsn.c
+++ b/drivers/net/ethernet/intel/igc/igc_tsn.c
@@ -52,7 +52,7 @@ static int igc_tsn_disable_offload(struct igc_adapter *adapter)
 		wr32(IGC_ENDQT(i), NSEC_PER_SEC);
 	}
 
-	wr32(IGC_QBVCYCLET_S, NSEC_PER_SEC);
+	wr32(IGC_QBVCYCLET_S, 0);
 	wr32(IGC_QBVCYCLET, NSEC_PER_SEC);
 
 	adapter->flags &= ~IGC_FLAG_TSN_QBV_ENABLED;
-- 
2.17.1

