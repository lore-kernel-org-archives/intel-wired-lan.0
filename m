From: Mark D Rustad <mark.d.rustad@intel.com>
Date: Fri, 17 Jul 2015 15:22:33 -0700
Subject: [Intel-wired-lan] [PATCH 3/3] ixgbe: Add new X550EM SFP+ device ID
In-Reply-To: <20150717222130.123580.2307.stgit@mdrustad-wks.jf.intel.com>
References: <20150717222130.123580.2307.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <20150717222233.123580.45333.stgit@mdrustad-wks.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Add new device ID for X550EM device with SFPs.

Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index a4f5b11c9a06..c3da64cb5fd7 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -137,6 +137,7 @@ static const struct pci_device_id ixgbe_pci_tbl[] = {
 	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_X550EM_X_KX4), board_X550EM_x},
 	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_X550EM_X_KR), board_X550EM_x},
 	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_X550EM_X_10G_T), board_X550EM_x},
+	{PCI_VDEVICE(INTEL, IXGBE_DEV_ID_X550EM_X_SFP), board_X550EM_x},
 	/* required last entry */
 	{0, }
 };

