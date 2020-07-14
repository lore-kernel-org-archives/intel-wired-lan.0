From: Suraj Upadhyay <usuraj35@gmail.com>
Date: Wed, 15 Jul 2020 01:11:47 +0530
Subject: [Intel-wired-lan] [PATCH 3/4] igb/igb_ethtool.c : Remove
 unnecessary usages of memset.
Message-ID: <20200714194147.GA21537@blackclown>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Replace memsets of 1 byte with simple assignment.
Issue found with checkpatch.pl

Signed-off-by: Suraj Upadhyay <usuraj35@gmail.com>
---
 drivers/net/ethernet/intel/igb/igb_ethtool.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_ethtool.c b/drivers/net/ethernet/intel/igb/igb_ethtool.c
index c2cf414d126b..6e8231c1ddf0 100644
--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
@@ -1782,8 +1782,8 @@ static void igb_create_lbtest_frame(struct sk_buff *skb,
 	memset(skb->data, 0xFF, frame_size);
 	frame_size /= 2;
 	memset(&skb->data[frame_size], 0xAA, frame_size - 1);
-	memset(&skb->data[frame_size + 10], 0xBE, 1);
-	memset(&skb->data[frame_size + 12], 0xAF, 1);
+	skb->data[frame_size + 10] = 0xBE;
+	skb->data[frame_size + 12] = 0xAF;
 }
 
 static int igb_check_lbtest_frame(struct igb_rx_buffer *rx_buffer,
-- 
2.17.1

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20200715/72e3a22e/attachment.asc>
