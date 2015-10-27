From: Alexander Duyck <aduyck@mirantis.com>
Date: Tue, 27 Oct 2015 16:59:37 -0700
Subject: [Intel-wired-lan] [next PATCH 5/5] igb: Fix unused variable warning
In-Reply-To: <20151027235341.30048.46286.stgit@localhost.localdomain>
References: <20151027235341.30048.46286.stgit@localhost.localdomain>
Message-ID: <20151027235937.30048.88092.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

I ran into an unused variable warning when building dev-queue.  It turns
out that hw isn't used anymore when setting up the q_vectors since we
switch from hw->hw_addr to adapter->io_addr in igb_request_irq.  As such
the variable can be dropped.

Fixes: 0b3659ca297fc ("igb: improve handling of disconnected adapters")
Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 1dcf3ab5fe87..3d4b502b1ecf 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -946,7 +946,6 @@ static void igb_configure_msix(struct igb_adapter *adapter)
 static int igb_request_msix(struct igb_adapter *adapter)
 {
 	struct net_device *netdev = adapter->netdev;
-	struct e1000_hw *hw = &adapter->hw;
 	int i, err = 0, vector = 0, free_vector = 0;
 
 	err = request_irq(adapter->msix_entries[vector].vector,

