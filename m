From: Andre Guedes <andre.guedes@intel.com>
Date: Fri, 28 Feb 2020 00:19:57 -0800
Subject: [Intel-wired-lan] [PATCH] igc: Fix overwrites when dumping registers
Message-ID: <20200228081957.61782-1-andre.guedes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This patch fixes some register overwriting when dumping registers via
ethtool.

We have a total of 16 RAL registers, starting at offset 139. So RAH
offset should be 139 + 16 = 155, not 145. As result some RAL registers
are overwritten. Likewise, RAH registers are also overwritten by TDBAL,
TDBAH, TDLEN, and TDH registers.

To fix this bug while preserving the ABI, this patch re-writes RAL and
RAH registers at the end of 'regs_buff' and bumps regs->version. It also
removes some pointless comments in the middle of igc_set_regs().

Signed-off-by: Andre Guedes <andre.guedes@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_ethtool.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
index 69f50b8e2af3..7e4ad4e9f8ad 100644
--- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
+++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
@@ -153,7 +153,7 @@ static void igc_get_regs(struct net_device *netdev,
 
 	memset(p, 0, IGC_REGS_LEN * sizeof(u32));
 
-	regs->version = (1u << 24) | (hw->revision_id << 16) | hw->device_id;
+	regs->version = (2u << 24) | (hw->revision_id << 16) | hw->device_id;
 
 	/* General Registers */
 	regs_buff[0] = rd32(IGC_CTRL);
@@ -306,6 +306,15 @@ static void igc_get_regs(struct net_device *netdev,
 		regs_buff[164 + i] = rd32(IGC_TDT(i));
 	for (i = 0; i < 4; i++)
 		regs_buff[168 + i] = rd32(IGC_TXDCTL(i));
+
+	/* XXX: Due to a bug few lines above, RAL and RAH registers are
+	 * overwritten. To preserve the ABI, we write these registers again in
+	 * regs_buff.
+	 */
+	for (i = 0; i < 16; i++)
+		regs_buff[172 + i] = rd32(IGC_RAL(i));
+	for (i = 0; i < 16; i++)
+		regs_buff[188 + i] = rd32(IGC_RAH(i));
 }
 
 static void igc_get_wol(struct net_device *netdev, struct ethtool_wolinfo *wol)
-- 
2.25.0

