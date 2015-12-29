From: Bruce Allan <bruce.w.allan@intel.com>
Date: Mon, 28 Dec 2015 18:00:30 -0800
Subject: [Intel-wired-lan] [next-queue PATCH] fm10k: use ether_addr_copy to
	copy MAC address
Message-ID: <20151229020030.2327.78167.stgit@bwallan-smackover2.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Cleanup the remaining instances of using memcpy() instead of the preferred
ether_addr_copy().

Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
index 60a70e9..6190a81 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
@@ -1776,8 +1776,8 @@ static int fm10k_sw_init(struct fm10k_intfc *interface,
 		netdev->addr_assign_type |= NET_ADDR_RANDOM;
 	}
 
-	memcpy(netdev->dev_addr, hw->mac.addr, netdev->addr_len);
-	memcpy(netdev->perm_addr, hw->mac.addr, netdev->addr_len);
+	ether_addr_copy(netdev->dev_addr, hw->mac.addr);
+	ether_addr_copy(netdev->perm_addr, hw->mac.addr);
 
 	if (!is_valid_ether_addr(netdev->perm_addr)) {
 		dev_err(&pdev->dev, "Invalid MAC Address\n");

