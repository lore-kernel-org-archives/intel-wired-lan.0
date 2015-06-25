From: Jacob Keller <jacob.e.keller@intel.com>
Date: Thu, 25 Jun 2015 15:12:04 -0700
Subject: [Intel-wired-lan] [PATCH net-next] fm10k: create "correct" header
	for the remote end on connect
Message-ID: <1435270324-29738-1-git-send-email-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

When we connect to the mailbox, we insert a fake disconnect header so
that the code does not see an invalid header and thus instantly error
every time we bring up the mailbox. However, we incorrectly record the
tail and head from the local perspective. Since the remote end shouldn't
have anything for us, add a "create_fake_disconnect_hdr" function which
inverts the TAIL and HEAD fields. This enables us to connect without any
errors of either TAIL or HEAD incorrectness, and prevents creating
extraneous error messages. This is necessary now since mbx_reset_work
does not actually reset the Tx FIFO head and tail pointers, thus head
and tail might not be equivalent on a reconnect.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_mbx.c | 46 +++++++++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_mbx.c b/drivers/net/ethernet/intel/fm10k/fm10k_mbx.c
index 0ff21d1fb9db..6bc27c2d671b 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_mbx.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_mbx.c
@@ -899,6 +899,48 @@ static void fm10k_mbx_create_disconnect_hdr(struct fm10k_mbx_info *mbx)
 }
 
 /**
+ *  fm10k_mbx_create_fake_disconnect_hdr - Generate a false disconnect mailbox header
+ *  @mbx: pointer to mailbox
+ *
+ *  This function creates a fake disconnect header for loading into remote
+ *  mailbox header. The primary purpose is to prevent errors on immediate
+ *  start up after mbx->connect.
+ **/
+static void fm10k_mbx_create_fake_disconnect_hdr(struct fm10k_mbx_info *mbx)
+{
+	u32 hdr = FM10K_MSG_HDR_FIELD_SET(FM10K_MSG_DISCONNECT, TYPE) |
+		  FM10K_MSG_HDR_FIELD_SET(mbx->head, TAIL) |
+		  FM10K_MSG_HDR_FIELD_SET(mbx->tail, HEAD);
+	u16 crc = fm10k_crc_16b(&hdr, mbx->local, 1);
+
+	mbx->mbx_lock |= FM10K_MBX_ACK;
+
+	/* load header to memory to be written */
+	mbx->mbx_hdr = hdr | FM10K_MSG_HDR_FIELD_SET(crc, CRC);
+}
+
+/**
+ *  fm10k_mbx_create_fake_disconnect_hdr - Generate a false disconnect mailbox header
+ *  @mbx: pointer to mailbox
+ *
+ *  This function creates a fake disconnect header for loading into remote
+ *  mailbox header. The primary purpose is to prevent errors on immediate
+ *  start up after mbx->connect.
+ **/
+static void fm10k_mbx_create_fake_disconnect_hdr(struct fm10k_mbx_info *mbx)
+{
+	u32 hdr = FM10K_MSG_HDR_FIELD_SET(FM10K_MSG_DISCONNECT, TYPE) |
+		  FM10K_MSG_HDR_FIELD_SET(mbx->head, TAIL) |
+		  FM10K_MSG_HDR_FIELD_SET(mbx->tail, HEAD);
+	u16 crc = fm10k_crc_16b(&hdr, mbx->local, 1);
+
+	mbx->mbx_lock |= FM10K_MBX_ACK;
+
+	/* load header to memory to be written */
+	mbx->mbx_hdr = hdr | FM10K_MSG_HDR_FIELD_SET(crc, CRC);
+}
+
+/**
  *  fm10k_mbx_create_error_msg - Generate a error message
  *  @mbx: pointer to mailbox
  *  @err: local error encountered
@@ -1435,8 +1477,10 @@ static s32 fm10k_mbx_connect(struct fm10k_hw *hw, struct fm10k_mbx_info *mbx)
 	/* Place mbx in ready to connect state */
 	mbx->state = FM10K_STATE_CONNECT;
 
+	fm10k_mbx_reset_work(mbx);
+
 	/* initialize header of remote mailbox */
-	fm10k_mbx_create_disconnect_hdr(mbx);
+	fm10k_mbx_create_fake_disconnect_hdr(mbx);
 	fm10k_write_reg(hw, mbx->mbmem_reg ^ mbx->mbmem_len, mbx->mbx_hdr);
 
 	/* enable interrupt and notify other party of new message */
-- 
2.4.3

