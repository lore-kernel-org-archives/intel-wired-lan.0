From: Greg Edwards <gedwards@ddn.com>
Date: Thu, 20 Jul 2017 10:00:58 -0600
Subject: [Intel-wired-lan] [PATCH 2/2] igbvf: after mailbox write,
	wait for reply
In-Reply-To: <20170720160058.8198-1-gedwards@ddn.com>
References: <20170720160058.8198-1-gedwards@ddn.com>
Message-ID: <20170720160058.8198-3-gedwards@ddn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Two of the VF mailbox commands were not waiting for a reply from the PF,
which can result in a VF mailbox timeout in the VM for the next command.

Signed-off-by: Greg Edwards <gedwards@ddn.com>
---
 drivers/net/ethernet/intel/igbvf/vf.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igbvf/vf.c b/drivers/net/ethernet/intel/igbvf/vf.c
index 528be116184e..1d3aa9adcaa8 100644
--- a/drivers/net/ethernet/intel/igbvf/vf.c
+++ b/drivers/net/ethernet/intel/igbvf/vf.c
@@ -230,6 +230,7 @@ static void e1000_update_mc_addr_list_vf(struct e1000_hw *hw,
 	u16 *hash_list = (u16 *)&msgbuf[1];
 	u32 hash_value;
 	u32 cnt, i;
+	s32 ret_val;
 
 	/* Each entry in the list uses 1 16 bit word.  We have 30
 	 * 16 bit words available in our HW msg buffer (minus 1 for the
@@ -250,7 +251,9 @@ static void e1000_update_mc_addr_list_vf(struct e1000_hw *hw,
 		mc_addr_list += ETH_ALEN;
 	}
 
-	mbx->ops.write_posted(hw, msgbuf, E1000_VFMAILBOX_SIZE);
+	ret_val = mbx->ops.write_posted(hw, msgbuf, E1000_VFMAILBOX_SIZE);
+	if (!ret_val)
+		mbx->ops.read_posted(hw, msgbuf, 1);
 }
 
 /**
@@ -293,11 +296,14 @@ void e1000_rlpml_set_vf(struct e1000_hw *hw, u16 max_size)
 {
 	struct e1000_mbx_info *mbx = &hw->mbx;
 	u32 msgbuf[2];
+	s32 ret_val;
 
 	msgbuf[0] = E1000_VF_SET_LPE;
 	msgbuf[1] = max_size;
 
-	mbx->ops.write_posted(hw, msgbuf, 2);
+	ret_val = mbx->ops.write_posted(hw, msgbuf, 2);
+	if (!ret_val)
+		mbx->ops.read_posted(hw, msgbuf, 1);
 }
 
 /**
-- 
2.13.3

