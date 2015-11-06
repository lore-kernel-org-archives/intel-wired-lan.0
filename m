From: Joshua Hay <joshua.a.hay@intel.com>
Date: Fri,  6 Nov 2015 15:26:00 -0800
Subject: [Intel-wired-lan] [next PATCH S21 02/14] i40evf: set real num queues
In-Reply-To: <1446852372-25480-1-git-send-email-joshua.a.hay@intel.com>
References: <1446852372-25480-1-git-send-email-joshua.a.hay@intel.com>
Message-ID: <1446852372-25480-3-git-send-email-joshua.a.hay@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

Use the helper function to set the real number of RX queues, and also
set the real number of TX queues.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Change-ID: I67982799de3f248fb4158ccdc9b1a74385f42ddd
---
 drivers/net/ethernet/intel/i40evf/i40evf_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index 74917ca..33a08f8 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -1205,7 +1205,8 @@ static int i40evf_set_interrupt_capability(struct i40evf_adapter *adapter)
 	err = i40evf_acquire_msix_vectors(adapter, v_budget);
 
 out:
-	adapter->netdev->real_num_tx_queues = pairs;
+	netif_set_real_num_rx_queues(adapter->netdev, pairs);
+	netif_set_real_num_tx_queues(adapter->netdev, pairs);
 	return err;
 }
 
-- 
2.1.0

