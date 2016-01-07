From: Alexander Duyck <aduyck@mirantis.com>
Date: Wed, 06 Jan 2016 23:10:23 -0800
Subject: [Intel-wired-lan] [next PATCH 01/11] igb: clean up code for setting
	MAC address
In-Reply-To: <20160107070850.13648.21033.stgit@localhost.localdomain>
References: <20160107070850.13648.21033.stgit@localhost.localdomain>
Message-ID: <20160107071023.13648.94040.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Drop a bunch of hand written byte swapping code in favor of just doing the
byte swapping ourselves.  The registers are little endian registers storing
a big endian value so if we read the MAC address array as little endian
then we will get the CPU registers into the proper layout.

Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 637135e216e4..3b6d4e10d095 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -7834,15 +7834,14 @@ static void igb_io_resume(struct pci_dev *pdev)
 static void igb_rar_set_qsel(struct igb_adapter *adapter, u8 *addr, u32 index,
 			     u8 qsel)
 {
-	u32 rar_low, rar_high;
 	struct e1000_hw *hw = &adapter->hw;
+	u32 rar_low, rar_high;
 
 	/* HW expects these in little endian so we reverse the byte order
-	 * from network order (big endian) to little endian
+	 * from network order (big endian) to CPU endian
 	 */
-	rar_low = ((u32) addr[0] | ((u32) addr[1] << 8) |
-		   ((u32) addr[2] << 16) | ((u32) addr[3] << 24));
-	rar_high = ((u32) addr[4] | ((u32) addr[5] << 8));
+	rar_low = le32_to_cpup((__be32 *)(addr));
+	rar_high = le16_to_cpup((__be16 *)(addr + 4));
 
 	/* Indicate to hardware the Address is Valid. */
 	rar_high |= E1000_RAH_AV;

