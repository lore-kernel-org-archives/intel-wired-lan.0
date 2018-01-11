From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Fri, 12 Jan 2018 00:46:01 +0300
Subject: [Intel-wired-lan] [PATCH] ixgbe: Fix && vs || typo
Message-ID: <20180111214601.4cyjpvmbsothnc23@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

"offset" can't be both 0x0 and 0xFFFF so presumably || was intended
instead of &&.  That matches with how this check is done in other
functions.

Fixes: 73834aec7199 ("ixgbe: extend firmware version support")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
index 1948e4208fb4..27de8a7f2aeb 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_common.c
@@ -4084,7 +4084,7 @@ void ixgbe_get_oem_prod_version(struct ixgbe_hw *hw,
 	hw->eeprom.ops.read(hw, NVM_OEM_PROD_VER_PTR, &offset);
 
 	/* Return is offset to OEM Product Version block is invalid */
-	if (offset == 0x0 && offset == NVM_INVALID_PTR)
+	if (offset == 0x0 || offset == NVM_INVALID_PTR)
 		return;
 
 	/* Read product version block */
