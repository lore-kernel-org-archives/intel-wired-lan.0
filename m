From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Mon, 18 Apr 2016 11:33:48 -0700
Subject: [Intel-wired-lan] [PATCH next S35 v3 8/9] i40evf: Allocate rx
	buffers properly
In-Reply-To: <1461004429-34316-8-git-send-email-jesse.brandeburg@intel.com>
References: <1461004429-34316-1-git-send-email-jesse.brandeburg@intel.com>
 <1461004429-34316-2-git-send-email-jesse.brandeburg@intel.com>
 <1461004429-34316-3-git-send-email-jesse.brandeburg@intel.com>
 <1461004429-34316-4-git-send-email-jesse.brandeburg@intel.com>
 <1461004429-34316-5-git-send-email-jesse.brandeburg@intel.com>
 <1461004429-34316-6-git-send-email-jesse.brandeburg@intel.com>
 <1461004429-34316-7-git-send-email-jesse.brandeburg@intel.com>
 <1461004429-34316-8-git-send-email-jesse.brandeburg@intel.com>
Message-ID: <1461004429-34316-9-git-send-email-jesse.brandeburg@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Mitch Williams <mitch.a.williams@intel.com>

Allocate the correct number of RX buffers, and don't fiddle with
next_to_use. The common RX code handles all of this. This fixes a memory
leak of one page each time the driver is opened.

Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
Change-Id: Id06eca353086e084921f047acad28c14745684ee
---
 drivers/net/ethernet/intel/i40evf/i40evf_main.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
index 8d77ad1..6609a5b 100644
--- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
+++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
@@ -990,9 +990,7 @@ static void i40evf_configure(struct i40evf_adapter *adapter)
 	for (i = 0; i < adapter->num_active_queues; i++) {
 		struct i40e_ring *ring = &adapter->rx_rings[i];
 
-		i40evf_alloc_rx_buffers(ring, ring->count);
-		ring->next_to_use = ring->count - 1;
-		writel(ring->next_to_use, ring->tail);
+		i40evf_alloc_rx_buffers(ring, I40E_DESC_UNUSED(ring));
 	}
 }
 
@@ -2762,7 +2760,6 @@ static void i40evf_remove(struct pci_dev *pdev)
 
 	iounmap(hw->hw_addr);
 	pci_release_regions(pdev);
-
 	i40evf_free_all_tx_resources(adapter);
 	i40evf_free_all_rx_resources(adapter);
 	i40evf_free_queues(adapter);
-- 
1.8.3.1

