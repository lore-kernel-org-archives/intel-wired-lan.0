From: Amritha Nambiar <amritha.nambiar@intel.com>
Date: Wed, 13 Sep 2017 02:59:19 -0700
Subject: [Intel-wired-lan] [RFC PATCH v3 1/7] tc_mirred: Clean up
	white-space noise
In-Reply-To: <150529632024.57063.15338545678487601430.stgit@anamdev.jf.intel.com>
References: <150529632024.57063.15338545678487601430.stgit@anamdev.jf.intel.com>
Message-ID: <150529675926.57063.2440322390685604327.stgit@anamdev.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
---
 include/uapi/linux/tc_act/tc_mirred.h |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/tc_act/tc_mirred.h b/include/uapi/linux/tc_act/tc_mirred.h
index 3d7a2b3..69038c2 100644
--- a/include/uapi/linux/tc_act/tc_mirred.h
+++ b/include/uapi/linux/tc_act/tc_mirred.h
@@ -9,13 +9,13 @@
 #define TCA_EGRESS_MIRROR 2 /* mirror packet to EGRESS */
 #define TCA_INGRESS_REDIR 3  /* packet redirect to INGRESS*/
 #define TCA_INGRESS_MIRROR 4 /* mirror packet to INGRESS */
-                                                                                
+
 struct tc_mirred {
 	tc_gen;
 	int                     eaction;   /* one of IN/EGRESS_MIRROR/REDIR */
 	__u32                   ifindex;  /* ifindex of egress port */
 };
-                                                                                
+
 enum {
 	TCA_MIRRED_UNSPEC,
 	TCA_MIRRED_TM,
@@ -24,5 +24,5 @@ enum {
 	__TCA_MIRRED_MAX
 };
 #define TCA_MIRRED_MAX (__TCA_MIRRED_MAX - 1)
-                                                                                
+
 #endif

