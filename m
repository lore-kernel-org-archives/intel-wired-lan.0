From: Suraj Upadhyay <usuraj35@gmail.com>
Date: Wed, 15 Jul 2020 01:10:35 +0530
Subject: [Intel-wired-lan] [PATCH 1/4] e1000/e1000_ethtool.c: Remove
 unnecessary usages of memset
Message-ID: <20200714194035.GA21382@blackclown>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Replace memsets of 1 byte with simple assignments.
Issue reported by checkpatch.pl.

Signed-off-by: Suraj Upadhyay <usuraj35@gmail.com>
---
 drivers/net/ethernet/intel/e1000/e1000_ethtool.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000/e1000_ethtool.c b/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
index 0b4196d2cdd4..f976e9daa3d8 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_ethtool.c
@@ -1356,8 +1356,8 @@ static void e1000_create_lbtest_frame(struct sk_buff *skb,
 	memset(skb->data, 0xFF, frame_size);
 	frame_size &= ~1;
 	memset(&skb->data[frame_size / 2], 0xAA, frame_size / 2 - 1);
-	memset(&skb->data[frame_size / 2 + 10], 0xBE, 1);
-	memset(&skb->data[frame_size / 2 + 12], 0xAF, 1);
+	skb->data[frame_size / 2 + 10] = 0xBE;
+	skb->data[frame_size / 2 + 12] = 0xAF;
 }
 
 static int e1000_check_lbtest_frame(const unsigned char *data,
-- 
2.17.1

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20200715/8bf0e2df/attachment.asc>
