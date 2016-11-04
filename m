From: Bimmy Pujari <bimmy.pujari@intel.com>
Date: Fri,  4 Nov 2016 10:35:58 -0700
Subject: [Intel-wired-lan] [next PATCH S52 01/11] i40evf: check for
	msix_entries null dereference
In-Reply-To: <1478280968-8098-1-git-send-email-bimmy.pujari@intel.com>
References: <1478280968-8098-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1478280968-8098-2-git-send-email-bimmy.pujari@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alan Brady <alan.brady@intel.com>

It is possible for msix_entries to be freed by a previous suspend/remove
before a VF is closed.  This patch fixes the issue by checking for NULL
before dereferencing msix_entries and returning early in the case where
it is NULL within the i40evf_close code path.  Without this patch it is
possible to trigger a kernel panic through NULL dereference.

Signed-off-by: Alan Brady <alan.brady@intel.com>
Change-ID: I92a2746e82533a889e25f91578eac9abd0388ae2
---
Testing-hints:
    Create lots of VFs and bring themm up on the host, assign them and
the PF to namespaces, then shut the system down.

 drivers/net/ethernet/intel/i40evf/i40evf_main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index 7bbb55f..a47ca2d 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -631,6 +631,9 @@ static void i40evf_free_traffic_irqs(struct i40evf_adapter *adapter)
 {
 	int vector, irq_num, q_vectors;
 
+	if (!adapter->msix_entries)
+		return;
+
 	q_vectors = adapter->num_msix_vectors - NONQ_VECS;
 
 	for (vector = 0; vector < q_vectors; vector++) {
@@ -1443,6 +1446,9 @@ static void i40evf_free_q_vectors(struct i40evf_adapter *adapter)
  **/
 void i40evf_reset_interrupt_capability(struct i40evf_adapter *adapter)
 {
+	if (!adapter->msix_entries)
+		return;
+
 	pci_disable_msix(adapter->pdev);
 	kfree(adapter->msix_entries);
 	adapter->msix_entries = NULL;
-- 
2.4.11

