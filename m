From: Sasha Neftin <sasha.neftin@intel.com>
Date: Mon, 22 Jun 2020 10:20:30 +0300
Subject: [Intel-wired-lan] [PATCH v1 2/2] igc: Add Receive Descriptor
 Minimum Threshould Count
Message-ID: <20200622072030.31239-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This register counts the number of events where the number of
descriptors in one of the Rx queues was lower than the threshold
defined for this queue.

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_mac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/igc/igc_mac.c b/drivers/net/ethernet/intel/igc/igc_mac.c
index 2d9ca3e1bdde..3a618e69514e 100644
--- a/drivers/net/ethernet/intel/igc/igc_mac.c
+++ b/drivers/net/ethernet/intel/igc/igc_mac.c
@@ -308,6 +308,7 @@ void igc_clear_hw_cntrs_base(struct igc_hw *hw)
 	rd32(IGC_TLPIC);
 	rd32(IGC_RLPIC);
 	rd32(IGC_HGPTC);
+	rd32(IGC_RXDMTC);
 	rd32(IGC_HGORCL);
 	rd32(IGC_HGORCH);
 	rd32(IGC_HGOTCL);
-- 
2.11.0

