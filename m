From: Sasha Neftin <sasha.neftin@intel.com>
Date: Thu,  9 Jul 2020 10:34:16 +0300
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Fix static checker warning
Message-ID: <20200709073416.14126-1-sasha.neftin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

drivers/net/ethernet/intel/igc/igc_mac.c:424 igc_check_for_copper_link()
error: uninitialized symbol 'link'.
This patch come to fix this warning and initialize the 'link' symbol.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Fixes: 707abf069548 ("igc: Add initial LTR support")
Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_mac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_mac.c b/drivers/net/ethernet/intel/igc/igc_mac.c
index 674b8ad21fea..09cd0ec7ee87 100644
--- a/drivers/net/ethernet/intel/igc/igc_mac.c
+++ b/drivers/net/ethernet/intel/igc/igc_mac.c
@@ -355,8 +355,8 @@ void igc_rar_set(struct igc_hw *hw, u8 *addr, u32 index)
 s32 igc_check_for_copper_link(struct igc_hw *hw)
 {
 	struct igc_mac_info *mac = &hw->mac;
+	bool link = false;
 	s32 ret_val;
-	bool link;
 
 	/* We only want to go out to the PHY registers to see if Auto-Neg
 	 * has completed and/or if our link status has changed.  The
-- 
2.11.0

