From: Suraj Upadhyay <usuraj35@gmail.com>
Date: Wed, 15 Jul 2020 01:12:13 +0530
Subject: [Intel-wired-lan] [PATCH 4/4] ixgbe/ixgbe_ethtool.c: Remove
 unnecessary usages of memset.
Message-ID: <20200714194212.GA21612@blackclown>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Replace memsets of 1 byte with simple assignment.
Issue found with checkpatch.pl

Signed-off-by: Suraj Upadhyay <usuraj35@gmail.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index 6725d892336e..71ec908266a6 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -1951,8 +1951,8 @@ static void ixgbe_create_lbtest_frame(struct sk_buff *skb,
 	memset(skb->data, 0xFF, frame_size);
 	frame_size >>= 1;
 	memset(&skb->data[frame_size], 0xAA, frame_size / 2 - 1);
-	memset(&skb->data[frame_size + 10], 0xBE, 1);
-	memset(&skb->data[frame_size + 12], 0xAF, 1);
+	skb->data[frame_size + 10] = 0xBE;
+	skb->data[frame_size + 12] = 0xAF;
 }
 
 static bool ixgbe_check_lbtest_frame(struct ixgbe_rx_buffer *rx_buffer,
-- 
2.17.1

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20200715/82b862c2/attachment.asc>
