From: Mark D Rustad <mark.d.rustad@intel.com>
Date: Fri, 18 Mar 2016 11:33:21 -0700
Subject: [Intel-wired-lan] [PATCH V2 7/7] ixgbe: Add some new device IDs for
	new 10G MAC
In-Reply-To: <20160318183203.40415.3005.stgit@mdrustad-wks.jf.intel.com>
References: <20160318183203.40415.3005.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <20160318183321.40415.56956.stgit@mdrustad-wks.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Add device IDs for native SFP interfaces for new MAC.

Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index dbd6fade5529..ec57c2728b24 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -130,6 +130,7 @@ static const struct pci_device_id ixgbe_pci_tbl[] = {
 	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_X550EM_X_KR), board_X550EM_x},
 	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_X550EM_X_10G_T), board_X550EM_x},
 	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_X550EM_X_SFP), board_X550EM_x},
+	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_X550EM_A_SFP_N), board_x550em_a },
 	/* required last entry */
 	{0, }
 };

