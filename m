From: Babu Moger <babu.moger@oracle.com>
Date: Sat, 18 Jun 2016 17:40:47 -0700
Subject: [Intel-wired-lan] [PATCH] ixgbe: Fix minor typo while freeing irq
Message-ID: <1466296847-82299-1-git-send-email-babu.moger@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The array subscript increments after the execution of the statement.
So there is no issue here. However it helps to read the code better.

Signed-off-by: Babu Moger <babu.moger@oracle.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 569cb07..6f4fe66 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -3016,7 +3016,7 @@ static void ixgbe_free_irq(struct ixgbe_adapter *adapter)
 		free_irq(entry->vector, q_vector);
 	}
 
-	free_irq(adapter->msix_entries[vector++].vector, adapter);
+	free_irq(adapter->msix_entries[vector].vector, adapter);
 }
 
 /**
-- 
1.7.1

