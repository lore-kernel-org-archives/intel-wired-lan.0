From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 26 Oct 2015 16:32:02 -0700
Subject: [Intel-wired-lan] [next-queue 1/6] fm10k: use ether_addr_copy to
	copy MAC address
Message-ID: <1445902327-6717-1-git-send-email-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Use the ether_addr_copy function instead of copying byte-by-byte in a
for-loop by hand.

Reported-by: Bruce Allan <bruce.w.allan@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_pf.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pf.c b/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
index 8b9b6ba5b92b..bbf0b4aef241 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
@@ -266,7 +266,6 @@ static s32 fm10k_read_mac_addr_pf(struct fm10k_hw *hw)
 {
 	u8 perm_addr[ETH_ALEN];
 	u32 serial_num;
-	int i;
 
 	serial_num = fm10k_read_reg(hw, FM10K_SM_AREA(1));
 
@@ -288,10 +287,8 @@ static s32 fm10k_read_mac_addr_pf(struct fm10k_hw *hw)
 	perm_addr[4] = (u8)(serial_num >> 8);
 	perm_addr[5] = (u8)(serial_num);
 
-	for (i = 0; i < ETH_ALEN; i++) {
-		hw->mac.perm_addr[i] = perm_addr[i];
-		hw->mac.addr[i] = perm_addr[i];
-	}
+	ether_addr_copy(hw->mac.perm_addr, perm_addr);
+	ether_addr_copy(hw->mac.addr, perm_addr);
 
 	return 0;
 }
-- 
2.6.1.264.gbab76a9

