From: Colin King <colin.king@canonical.com>
Date: Sun,  7 Jan 2018 23:17:51 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: use ARRAY_SIZE for array sizing
 calculation on array buf
Message-ID: <20180107231751.7847-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Colin Ian King <colin.king@canonical.com>

Use the ARRAY_SIZE macro on array buf to determine size of the array.
Improvement suggested by coccinelle.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
index cb7da5f9c4da..28c23ef2ec28 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
@@ -949,7 +949,7 @@ static s32 ixgbe_checksum_ptr_x550(struct ixgbe_hw *hw, u16 ptr,
 	u16 length, bufsz, i, start;
 	u16 *local_buffer;
 
-	bufsz = sizeof(buf) / sizeof(buf[0]);
+	bufsz = ARRAY_SIZE(buf);
 
 	/* Read a chunk at the pointer location */
 	if (!buffer) {
-- 
2.15.1

