From: Suraj Upadhyay <usuraj35@gmail.com>
Date: Wed, 15 Jul 2020 01:11:17 +0530
Subject: [Intel-wired-lan] [PATCH 2/4] e1000e/ethtool.c : Remove unnecessary
 usages of memset.
Message-ID: <20200714194117.GA21460@blackclown>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Replace memsets of 1 byte with simple assignments.
Issue found with checkpatch.pl

Signed-off-by: Suraj Upadhyay <usuraj35@gmail.com>
---
 drivers/net/ethernet/intel/e1000e/ethtool.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/ethtool.c b/drivers/net/ethernet/intel/e1000e/ethtool.c
index 64f684dc6c7a..a8fc9208382c 100644
--- a/drivers/net/ethernet/intel/e1000e/ethtool.c
+++ b/drivers/net/ethernet/intel/e1000e/ethtool.c
@@ -1608,8 +1608,8 @@ static void e1000_create_lbtest_frame(struct sk_buff *skb,
 	memset(skb->data, 0xFF, frame_size);
 	frame_size &= ~1;
 	memset(&skb->data[frame_size / 2], 0xAA, frame_size / 2 - 1);
-	memset(&skb->data[frame_size / 2 + 10], 0xBE, 1);
-	memset(&skb->data[frame_size / 2 + 12], 0xAF, 1);
+	skb->data[frame_size / 2 + 10] = 0xBE;
+	skb->data[frame_size / 2 + 12] = 0xAF;
 }
 
 static int e1000_check_lbtest_frame(struct sk_buff *skb,
-- 
2.17.1

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20200715/35f97841/attachment.asc>
