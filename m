From: Alexander Duyck <alexander.h.duyck@redhat.com>
Date: Thu, 18 Jun 2015 19:41:10 -0700
Subject: [Intel-wired-lan] [PATCH v2] fm10k: Report MAC address on driver
	load
Message-ID: <20150619023812.1345.75383.stgit@ahduyck-vm-fedora22>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This change adds the MAC address to the list of values recorded on driver
load.  The MAC address represents the serial number of the unit and allows
us to track the value should a card be replaced in a system.

The log message should now be similar in output to that of ixgbe.

Signed-off-by: Alexander Duyck <alexander.h.duyck@redhat.com>
---

v2: Moved printing of MAC onto separate line similar to ixgbe.

(Hopefully this works for you Jeff.  I took at look at the patch and just
 moved the bit I needed down.  I figured since this block hasn't changed I
 should be able to get away with just doing this instead of pulling and
 rebasing off of your tree. )

 drivers/net/ethernet/intel/fm10k/fm10k_pci.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
index ce53ff25f88d..62a584f633d8 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
@@ -1843,6 +1843,9 @@ static int fm10k_probe(struct pci_dev *pdev,
 	/* print warning for non-optimal configurations */
 	fm10k_slot_warn(interface);
 
+	/* report MAC address for logging */
+	dev_info(&pdev->dev, "%pM\n", netdev->dev_addr);
+
 	/* enable SR-IOV after registering netdev to enforce PF/VF ordering */
 	fm10k_iov_configure(pdev, 0);
 

