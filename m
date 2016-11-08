From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Tue,  8 Nov 2016 13:05:08 -0800
Subject: [Intel-wired-lan] [next PATCH S52-V2 04/15] i40evf: protect against
	NULL msix_entries and q_vectors pointers
In-Reply-To: <1478639119-14656-1-git-send-email-bimmy.pujari@intel.com>
References: <1478639119-14656-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1478639119-14656-5-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>

Update the functions which free msix_entries and q_vectors so that they
are safe against NULL values. This allows calling code to not care
whether these have already been freed when disabling and freeing them.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Change-ID: I31bfd1c0da18023d971b618edc6fb049721f3298
---
 drivers/net/ethernet/intel/i40evf/i40evf_main.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index 420e545..ca85021 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -207,6 +207,9 @@ static void i40evf_misc_irq_disable(struct i40evf_adapter *adapter)
 {
 	struct i40e_hw *hw = &adapter->hw;
 
+	if (!adapter->msix_entries)
+		return;
+
 	wr32(hw, I40E_VFINT_DYN_CTL01, 0);
 
 	/* read flush */
@@ -654,6 +657,9 @@ static void i40evf_free_misc_irq(struct i40evf_adapter *adapter)
 {
 	struct net_device *netdev = adapter->netdev;
 
+	if (!adapter->msix_entries)
+		return;
+
 	free_irq(adapter->msix_entries[0].vector, netdev);
 }
 
@@ -1428,6 +1434,9 @@ static void i40evf_free_q_vectors(struct i40evf_adapter *adapter)
 	int q_idx, num_q_vectors;
 	int napi_vectors;
 
+	if (!adapter->q_vectors)
+		return;
+
 	num_q_vectors = adapter->num_msix_vectors - NONQ_VECS;
 	napi_vectors = adapter->num_active_queues;
 
@@ -1437,6 +1446,7 @@ static void i40evf_free_q_vectors(struct i40evf_adapter *adapter)
 			netif_napi_del(&q_vector->napi);
 	}
 	kfree(adapter->q_vectors);
+	adapter->q_vectors = NULL;
 }
 
 /**
@@ -2862,12 +2872,10 @@ static void i40evf_remove(struct pci_dev *pdev)
 		msleep(50);
 	}
 
-	if (adapter->msix_entries) {
-		i40evf_misc_irq_disable(adapter);
-		i40evf_free_misc_irq(adapter);
-		i40evf_reset_interrupt_capability(adapter);
-		i40evf_free_q_vectors(adapter);
-	}
+	i40evf_misc_irq_disable(adapter);
+	i40evf_free_misc_irq(adapter);
+	i40evf_reset_interrupt_capability(adapter);
+	i40evf_free_q_vectors(adapter);
 
 	if (adapter->watchdog_timer.function)
 		del_timer_sync(&adapter->watchdog_timer);
-- 
2.4.11

