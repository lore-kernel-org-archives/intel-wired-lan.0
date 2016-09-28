From: Mark D Rustad <mark.d.rustad@intel.com>
Date: Wed, 28 Sep 2016 15:36:43 -0700
Subject: [Intel-wired-lan] [PATCH] ixgbevf: Handle previously-freed
	msix_entries
Message-ID: <147510220328.65927.12326717639568004933.stgit@mdrustad-wks.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The msix_entries memory can be freed by a previous suspend or
remove, so don't crash on close when it isn't there.

Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
---
 drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index 7eaac3234049..4b018890840d 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -1498,6 +1498,9 @@ static void ixgbevf_free_irq(struct ixgbevf_adapter *adapter)
 {
 	int i, q_vectors;
 
+	if (!adapter->msix_entries)
+		return;
+
 	q_vectors = adapter->num_msix_vectors;
 	i = q_vectors - 1;
 
@@ -2552,6 +2555,9 @@ static void ixgbevf_free_q_vectors(struct ixgbevf_adapter *adapter)
  **/
 static void ixgbevf_reset_interrupt_capability(struct ixgbevf_adapter *adapter)
 {
+	if (!adapter->msix_entries)
+		return;
+
 	pci_disable_msix(adapter->pdev);
 	kfree(adapter->msix_entries);
 	adapter->msix_entries = NULL;

