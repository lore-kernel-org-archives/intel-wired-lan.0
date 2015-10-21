From: Catherine Sullivan <catherine.sullivan@intel.com>
Date: Wed, 21 Oct 2015 19:47:06 -0400
Subject: [Intel-wired-lan] [next PATCH S19 05/15] i40e: Properly cast type
	for arithmetic
In-Reply-To: <1445471236-35918-1-git-send-email-catherine.sullivan@intel.com>
References: <1445471236-35918-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <1445471236-35918-6-git-send-email-catherine.sullivan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Helin Zhang <helin.zhang@intel.com>

Pointer of type void * shouldn't be used in arithmetic, which may
result in compilation error. Casting of (u8 *) can be added to fix
that.

Signed-off-by: Helin Zhang <helin.zhang@intel.com>
Change-ID: I273aa57cdef7cacac5c552c348d585cd09d7e06b

---
Testing-hints: Patch just avoids a compile warning with cast to u8 *, so
verify with gcc option:
-Wpointer-arith like make -C /lib/modules/`uname -r`/build \
 M=driver/net/ethernet/intel EXTRA_CFLAGS=-Wpointer-arith
Before this patch, there will be a warning on this line (among many
others) - search for buff.va, and after it will be gone.
 drivers/net/ethernet/intel/i40e/i40e_nvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_nvm.c b/drivers/net/ethernet/intel/i40e/i40e_nvm.c
index 6100cdd..29d6785 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_nvm.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_nvm.c
@@ -1246,7 +1246,7 @@ static i40e_status i40e_nvmupd_get_aq_result(struct i40e_hw *hw,
 		remainder -= len;
 		buff = hw->nvm_buff.va;
 	} else {
-		buff = hw->nvm_buff.va + (cmd->offset - aq_desc_len);
+		buff = (u8 *)hw->nvm_buff.va + (cmd->offset - aq_desc_len);
 	}
 
 	if (remainder > 0) {
-- 
1.9.3

