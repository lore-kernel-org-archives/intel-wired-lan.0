From: Mark D Rustad <mark.d.rustad@intel.com>
Date: Thu, 22 Oct 2015 11:03:10 -0700
Subject: [Intel-wired-lan] [PATCH] net: Fix warnings from
	inet_timewait_sock.h
Message-ID: <20151022180310.105186.43189.stgit@mdrustad-wks.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

With W=1, inet_timewait_sock.h is generating the following warnings:

include/net/inet_timewait_sock.h:116:1: warning: <E2><80><98>inline<E2><80><99> is not at beginning of declaration [-Wold-style-declaration]
 static void inline inet_twsk_schedule(struct inet_timewait_sock *tw, int timeo)
 ^
include/net/inet_timewait_sock.h:121:1: warning: <E2><80><98>inline<E2><80><99> is not at beginning of declaration [-Wold-style-declaration]
 static void inline inet_twsk_reschedule(struct inet_timewait_sock *tw, int timeo)
 ^

Simply reorder the declaration to the proper order to resolve them.

Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
---
 include/net/inet_timewait_sock.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/net/inet_timewait_sock.h b/include/net/inet_timewait_sock.h
index e581fc69129d..c9b3eb70f340 100644
--- a/include/net/inet_timewait_sock.h
+++ b/include/net/inet_timewait_sock.h
@@ -113,12 +113,12 @@ void __inet_twsk_hashdance(struct inet_timewait_sock *tw, struct sock *sk,
 void __inet_twsk_schedule(struct inet_timewait_sock *tw, int timeo,
 			  bool rearm);
 
-static void inline inet_twsk_schedule(struct inet_timewait_sock *tw, int timeo)
+static inline void inet_twsk_schedule(struct inet_timewait_sock *tw, int timeo)
 {
 	__inet_twsk_schedule(tw, timeo, false);
 }
 
-static void inline inet_twsk_reschedule(struct inet_timewait_sock *tw, int timeo)
+static inline void inet_twsk_reschedule(struct inet_timewait_sock *tw, int timeo)
 {
 	__inet_twsk_schedule(tw, timeo, true);
 }

