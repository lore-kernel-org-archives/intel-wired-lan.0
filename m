From: Fujinaka, Todd <todd.fujinaka@intel.com>
Date: Wed, 9 Mar 2016 18:56:10 +0000
Subject: [Intel-wired-lan] [PATCH] igb: simplify check for all F
	for	surprise removal
In-Reply-To: <20160226215708.15005.5114.stgit@htfujina-fc.jf.intel.com>
References: <20160226215708.15005.5114.stgit@htfujina-fc.jf.intel.com>
Message-ID: <9B4A1B1917080E46B64F07F2989DADD65AB570A9@ORSMSX114.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

I've confirmed this is broken for some parts. Please drop this patch.

Todd Fujinaka
Software Application Engineer
Networking Division (ND)
Intel Corporation
todd.fujinaka at intel.com
(503) 712-4565


-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Todd Fujinaka
Sent: Friday, February 26, 2016 1:57 PM
To: intel-wired-lan@lists.osuosl.org
Subject: [Intel-wired-lan] [PATCH] igb: simplify check for all F for surprise removal

The previous check appears to be delaying problems by doing multiple reads. Also, we've found that having igbvf in the host and vm and using direct-assign returns all F's on the STATUS register and we can't use that as an error condition. Since the VLAN Ether Type register
(E1000_VET) has a hard-coded return value of 0x8100, check that register for all Fs instead.

Signed-off-by: Todd Fujinaka <todd.fujinaka@intel.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c |   23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index a1d9b05..e932763 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -763,9 +763,22 @@ static void igb_cache_ring_register(struct igb_adapter *adapter)
 	}
 }
 
-u32 igb_rd32(struct e1000_hw *hw, u32 reg)
+static void igb_check_remove(struct e1000_hw *hw, u32 reg, u8 __iomem 
+*hw_addr)
 {
 	struct igb_adapter *igb = container_of(hw, struct igb_adapter, hw);
+
+	/* E1000_VET is always 0x8100 and can't be all F's */
+	if ((reg == E1000_VET) || (!(~readl(&hw_addr[E1000_VET])))) {
+		struct net_device *netdev = igb->netdev;
+
+		hw->hw_addr = NULL;
+		netif_device_detach(netdev);
+		netdev_err(netdev, "PCIe link lost, device now detached\n");
+	}
+}
+
+u32 igb_rd32(struct e1000_hw *hw, u32 reg) {
 	u8 __iomem *hw_addr = ACCESS_ONCE(hw->hw_addr);
 	u32 value = 0;
 
@@ -775,12 +788,8 @@ u32 igb_rd32(struct e1000_hw *hw, u32 reg)
 	value = readl(&hw_addr[reg]);
 
 	/* reads should not return all F's */
-	if (!(~value) && (!reg || !(~readl(hw_addr)))) {
-		struct net_device *netdev = igb->netdev;
-		hw->hw_addr = NULL;
-		netif_device_detach(netdev);
-		netdev_err(netdev, "PCIe link lost, device now detached\n");
-	}
+	if (unlikely(!(~value)))
+		igb_check_remove(hw, reg, hw_addr);
 
 	return value;
 }

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan at lists.osuosl.org
http://lists.osuosl.org/mailman/listinfo/intel-wired-lan
