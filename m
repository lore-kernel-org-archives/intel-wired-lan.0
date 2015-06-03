From: Jacob Keller <jacob.e.keller@intel.com>
Date: Wed,  3 Jun 2015 15:56:40 -0700
Subject: [Intel-wired-lan] [PATCH 14/15] fm10k: remove err_no reference in
	fm10k_mbx.c
In-Reply-To: <1433372201-12007-1-git-send-email-jacob.e.keller@intel.com>
References: <1433372201-12007-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <1433372201-12007-14-git-send-email-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The reference to err_no was left around after a previous code refactor.
We never use the value, and it doesn't seem to be used in side a hidden
macro reference. Discovered via cppcheck.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_mbx.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_mbx.c b/drivers/net/ethernet/intel/fm10k/fm10k_mbx.c
index 1b2738380518..1a4b52637de9 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_mbx.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_mbx.c
@@ -1259,16 +1259,11 @@ static s32 fm10k_mbx_process_error(struct fm10k_hw *hw,
 				   struct fm10k_mbx_info *mbx)
 {
 	const u32 *hdr = &mbx->mbx_hdr;
-	s32 err_no;
 	u16 head;
 
 	/* we will need to pull all of the fields for verification */
 	head = FM10K_MSG_HDR_FIELD_GET(*hdr, HEAD);
 
-	/* we only have lower 10 bits of error number so add upper bits */
-	err_no = FM10K_MSG_HDR_FIELD_GET(*hdr, ERR_NO);
-	err_no |= ~FM10K_MSG_HDR_MASK(ERR_NO);
-
 	switch (mbx->state) {
 	case FM10K_STATE_OPEN:
 	case FM10K_STATE_DISCONNECT:
-- 
2.1.0

