From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Tue,  4 Sep 2018 12:33:29 -0700
Subject: [Intel-wired-lan] [PATCH next-queue] ixgbevf: fix msglen for ipsec
 mbx messages
Message-ID: <1536089609-32716-1-git-send-email-shannon.nelson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Don't be fancy with message lengths, just set lengths to
number of dwords, not bytes.

Fixes: 0062e7cc955e ("ixgbevf: add VF IPsec offload code")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
---
 drivers/net/ethernet/intel/ixgbevf/ipsec.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbevf/ipsec.c b/drivers/net/ethernet/intel/ixgbevf/ipsec.c
index fac91c0..a68586c 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ipsec.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ipsec.c
@@ -21,7 +21,6 @@ static int ixgbevf_ipsec_set_pf_sa(struct ixgbevf_adapter *adapter,
 	u32 msgbuf[IXGBE_VFMAILBOX_SIZE] = { 0 };
 	struct ixgbe_hw *hw = &adapter->hw;
 	struct sa_mbx_msg *sam;
-	u16 msglen;
 	int ret;
 
 	/* send the important bits to the PF */
@@ -38,16 +37,14 @@ static int ixgbevf_ipsec_set_pf_sa(struct ixgbevf_adapter *adapter,
 	memcpy(sam->key, xs->aead->alg_key, sizeof(sam->key));
 
 	msgbuf[0] = IXGBE_VF_IPSEC_ADD;
-	msglen = sizeof(*sam) + sizeof(msgbuf[0]);
 
 	spin_lock_bh(&adapter->mbx_lock);
 
-	ret = hw->mbx.ops.write_posted(hw, msgbuf, msglen);
+	ret = hw->mbx.ops.write_posted(hw, msgbuf, IXGBE_VFMAILBOX_SIZE);
 	if (ret)
 		goto out;
 
-	msglen = sizeof(msgbuf[0]) * 2;
-	ret = hw->mbx.ops.read_posted(hw, msgbuf, msglen);
+	ret = hw->mbx.ops.read_posted(hw, msgbuf, 2);
 	if (ret)
 		goto out;
 
@@ -80,11 +77,11 @@ static int ixgbevf_ipsec_del_pf_sa(struct ixgbevf_adapter *adapter, int pfsa)
 
 	spin_lock_bh(&adapter->mbx_lock);
 
-	err = hw->mbx.ops.write_posted(hw, msgbuf, sizeof(msgbuf));
+	err = hw->mbx.ops.write_posted(hw, msgbuf, 2);
 	if (err)
 		goto out;
 
-	err = hw->mbx.ops.read_posted(hw, msgbuf, sizeof(msgbuf));
+	err = hw->mbx.ops.read_posted(hw, msgbuf, 2);
 	if (err)
 		goto out;
 
-- 
2.7.4

