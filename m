From: Richard Cochran <rcochran@linutronix.de>
Date: Mon, 18 Sep 2017 09:41:17 +0200
Subject: [Intel-wired-lan] [PATCH RFC V1 net-next 2/6] net: skbuff: Add a
	field to support time based transmission.
In-Reply-To: <cover.1505719061.git.rcochran@linutronix.de>
References: <cover.1505719061.git.rcochran@linutronix.de>
Message-ID: <555939002f1ca9d89b14f30b3579445e4fa628d9.1505719061.git.rcochran@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Signed-off-by: Richard Cochran <rcochran@linutronix.de>
---
 include/linux/skbuff.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 72299ef00061..bc7f7dcbb413 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -635,6 +635,7 @@ typedef unsigned char *sk_buff_data_t;
  *	@dst_pending_confirm: need to confirm neighbour
   *	@napi_id: id of the NAPI struct this skb came from
  *	@secmark: security marking
+ *	@transmit_time: desired future transmission time in nanoseconds
  *	@mark: Generic packet mark
  *	@vlan_proto: vlan encapsulation protocol
  *	@vlan_tci: vlan tag control information
@@ -804,6 +805,7 @@ struct sk_buff {
 #ifdef CONFIG_NETWORK_SECMARK
 	__u32		secmark;
 #endif
+	__u64			transmit_time;
 
 	union {
 		__u32		mark;
-- 
2.11.0

