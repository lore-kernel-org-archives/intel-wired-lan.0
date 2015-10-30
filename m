From: Benjamin Poirier <bpoirier@suse.com>
Date: Fri, 30 Oct 2015 10:31:01 -0700
Subject: [Intel-wired-lan] [PATCH v2 1/4] e1000e: Remove unreachable code
In-Reply-To: <1446226264-29660-1-git-send-email-bpoirier@suse.com>
References: <1446226264-29660-1-git-send-email-bpoirier@suse.com>
Message-ID: <1446226264-29660-2-git-send-email-bpoirier@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

msi-x interrupts are not shared so there's no need to check if the
interrupt was really from this adapter.

Signed-off-by: Benjamin Poirier <bpoirier@suse.com>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 0a854a4..a228167 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -1907,12 +1907,6 @@ static irqreturn_t e1000_msix_other(int __always_unused irq, void *data)
 	struct e1000_hw *hw = &adapter->hw;
 	u32 icr = er32(ICR);
 
-	if (!(icr & E1000_ICR_INT_ASSERTED)) {
-		if (!test_bit(__E1000_DOWN, &adapter->state))
-			ew32(IMS, E1000_IMS_OTHER);
-		return IRQ_NONE;
-	}
-
 	if (icr & adapter->eiac_mask)
 		ew32(ICS, (icr & adapter->eiac_mask));
 
-- 
2.6.0

