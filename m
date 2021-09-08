From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed,  8 Sep 2021 10:52:36 -0700
Subject: [Intel-wired-lan] [PATCH 1/2] e100: fix length calculation in
 e100_get_regs_len
Message-ID: <20210908175237.3058574-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

commit abf9b902059f ("e100: cleanup unneeded math") tried to simplify
e100_get_regs_len and remove a double 'divide and then multiply'
calculation that the e100_reg_regs_len function did.

This change broke the size calculation entirely as it failed to account
for the fact that the numbered registers are actually 4 bytes wide and
not 1 byte. This resulted in a significant under allocation of the
register buffer used by e100_get_regs.

Fix this by properly multiplying the register count by u32 first before
adding the size of the dump buffer.

Fixes: abf9b902059f ("e100: cleanup unneeded math")
Reported-by: Felicitas Hetzelt <felicitashetzelt@gmail.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/e100.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e100.c b/drivers/net/ethernet/intel/e100.c
index 373eb027b925..588a59546d12 100644
--- a/drivers/net/ethernet/intel/e100.c
+++ b/drivers/net/ethernet/intel/e100.c
@@ -2441,7 +2441,11 @@ static void e100_get_drvinfo(struct net_device *netdev,
 static int e100_get_regs_len(struct net_device *netdev)
 {
 	struct nic *nic = netdev_priv(netdev);
-	return 1 + E100_PHY_REGS + sizeof(nic->mem->dump_buf);
+
+	/* We know the number of registers, and the size of the dump buffer.
+	 * Calculate the total size in bytes.
+	 */
+	return (1 + E100_PHY_REGS) * sizeof(u32) + sizeof(nic->mem->dump_buf);
 }
 
 static void e100_get_regs(struct net_device *netdev,
-- 
2.31.1.331.gb0c09ab8796f

