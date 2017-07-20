From: Greg Edwards <gedwards@ddn.com>
Date: Thu, 20 Jul 2017 10:15:14 -0600
Subject: [Intel-wired-lan] [PATCH] igbvf: convert msleep to mdelay in atomic
	context
Message-ID: <20170720161514.9729-1-gedwards@ddn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

This fixes a "scheduling while atomic" splat seen with
CONFIG_DEBUG_ATOMIC_SLEEP enabled.

Signed-off-by: Greg Edwards <gedwards@ddn.com>
---
 drivers/net/ethernet/intel/igbvf/vf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igbvf/vf.c b/drivers/net/ethernet/intel/igbvf/vf.c
index 1d3aa9adcaa8..9577ccf4b26a 100644
--- a/drivers/net/ethernet/intel/igbvf/vf.c
+++ b/drivers/net/ethernet/intel/igbvf/vf.c
@@ -149,7 +149,7 @@ static s32 e1000_reset_hw_vf(struct e1000_hw *hw)
 		msgbuf[0] = E1000_VF_RESET;
 		mbx->ops.write_posted(hw, msgbuf, 1);
 
-		msleep(10);
+		mdelay(10);
 
 		/* set our "perm_addr" based on info provided by PF */
 		ret_val = mbx->ops.read_posted(hw, msgbuf, 3);
-- 
2.13.3

