From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Date: Tue, 17 May 2016 22:41:33 +0200
Subject: [Intel-wired-lan] [PATCH 1/1] net: i40e: avoid null pointer
	dereference
Message-ID: <1463517693-10333-1-git-send-email-xypron.glpk@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

In function i40e_debug_aq parameter desc is assumed to be
possibly NULL. Do not dereference it before checking the
value.

Fixes: f905dd62be88 ("i40e/i40evf: add max buf len to aq debug print helper")
Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
---
 drivers/net/ethernet/intel/i40e/i40e_common.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_common.c b/drivers/net/ethernet/intel/i40e/i40e_common.c
index 422b41d..d5cb570 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_common.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_common.c
@@ -297,13 +297,15 @@ void i40e_debug_aq(struct i40e_hw *hw, enum i40e_debug_mask mask, void *desc,
 		   void *buffer, u16 buf_len)
 {
 	struct i40e_aq_desc *aq_desc = (struct i40e_aq_desc *)desc;
-	u16 len = le16_to_cpu(aq_desc->datalen);
+	u16 len;
 	u8 *buf = (u8 *)buffer;
 	u16 i = 0;
 
 	if ((!(mask & hw->debug_mask)) || (desc == NULL))
 		return;
 
+	len = le16_to_cpu(aq_desc->datalen);
+
 	i40e_debug(hw, mask,
 		   "AQ CMD: opcode 0x%04X, flags 0x%04X, datalen 0x%04X, retval 0x%04X\n",
 		   le16_to_cpu(aq_desc->opcode),
-- 
2.1.4

