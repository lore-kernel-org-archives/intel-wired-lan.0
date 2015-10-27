From: Alexander Duyck <aduyck@mirantis.com>
Date: Tue, 27 Oct 2015 16:59:18 -0700
Subject: [Intel-wired-lan] [next PATCH 2/5] fm10k: Cleanup exception
 handling for mailbox interrupt
In-Reply-To: <20151027235341.30048.46286.stgit@localhost.localdomain>
References: <20151027235341.30048.46286.stgit@localhost.localdomain>
Message-ID: <20151027235918.30048.41769.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch addresses two issues.

First is the fact that the fm10k_mbx_free_irq was assuming msix_entries was
valid and that will not always be the case.  As such we need to add a check
for if it is NULL.

Second is the fact that we weren't freeing the IRQ if the mailbox API
returned an error on trying to connect.

Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
index 15e67a383d27..15327d274d72 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
@@ -1131,6 +1131,10 @@ void fm10k_mbx_free_irq(struct fm10k_intfc *interface)
 	struct fm10k_hw *hw = &interface->hw;
 	int itr_reg;
 
+	/* no mailbox IRQ to free if MSI-X is not enabled */
+	if (!interface->msix_entries)
+		return;
+
 	/* disconnect the mailbox */
 	hw->mbx.ops.disconnect(hw, &hw->mbx);
 
@@ -1453,10 +1457,15 @@ int fm10k_mbx_request_irq(struct fm10k_intfc *interface)
 		err = fm10k_mbx_request_irq_pf(interface);
 	else
 		err = fm10k_mbx_request_irq_vf(interface);
+	if (err)
+		return err;
 
 	/* connect mailbox */
-	if (!err)
-		err = hw->mbx.ops.connect(hw, &hw->mbx);
+	err = hw->mbx.ops.connect(hw, &hw->mbx);
+
+	/* if the mailbox failed to connect, then free IRQ */
+	if (err)
+		fm10k_mbx_free_irq(interface);
 
 	return err;
 }

