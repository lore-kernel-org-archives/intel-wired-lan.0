From: Hiroshi Shimamoto <h-shimamoto@ct.jp.nec.com>
Date: Wed, 7 Oct 2015 10:06:32 +0000
Subject: [Intel-wired-lan] [iproute2 PATCH] iplink: Support VF Trust
Message-ID: <7F861DC0615E0C47A872E6F3C5FCDDBD05F42A95@BPXM14GP.gisp.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Hiroshi Shimamoto <h-shimamoto@ct.jp.nec.com>

Add IFLA_VF_TRUST message to trust the VF.
PF can accept some privileged operation from the trusted VF.
For example, ixgbe PF doesn't allow to enable VF promiscuous mode until
the VF is trusted because it may hurt performance.

To trust VF.
 # ip link set dev eth0 vf 1 trust on

To untrust VF.
 # ip link set dev eth0 vf 1 trust off

Signed-off-by: Hiroshi Shimamoto <h-shimamoto@ct.jp.nec.com>
---

This patch implements a functionality for trusting a VF in ip command.

The kernel side implementation of if_link was submitted as below.
http://marc.info/?l=linux-netdev&m=144074520803184&w=2
[PATCH v8 1/3] if_link: Add control trust VF

---
 include/linux/if_link.h |  6 ++++++
 ip/iplink.c             | 13 +++++++++++++
 man/man8/ip-link.8.in   |  7 ++++++-
 3 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/include/linux/if_link.h b/include/linux/if_link.h
index 1934566..ca9a681 100644
--- a/include/linux/if_link.h
+++ b/include/linux/if_link.h
@@ -499,6 +499,7 @@ enum {
 				 * on/off switch
 				 */
 	IFLA_VF_STATS,		/* network device statistics */
+	IFLA_VF_TRUST,		/* Trust VF */
 	__IFLA_VF_MAX,
 };
 
@@ -560,6 +561,11 @@ enum {
 
 #define IFLA_VF_STATS_MAX (__IFLA_VF_STATS_MAX - 1)
 
+struct ifla_vf_trust {
+	__u32 vf;
+	__u32 setting;
+};
+
 /* VF ports management section
  *
  *	Nested layout of set/get msg is:
diff --git a/ip/iplink.c b/ip/iplink.c
index 1c45205..0536f34 100644
--- a/ip/iplink.c
+++ b/ip/iplink.c
@@ -82,6 +82,7 @@ void iplink_usage(void)
 	fprintf(stderr, "				   [ spoofchk { on | off} ] ]\n");
 	fprintf(stderr, "				   [ query_rss { on | off} ] ]\n");
 	fprintf(stderr, "				   [ state { auto | enable | disable} ] ]\n");
+	fprintf(stderr, "				   [ trust { on | off} ] ]\n");
 	fprintf(stderr, "			  [ master DEVICE ]\n");
 	fprintf(stderr, "			  [ nomaster ]\n");
 	fprintf(stderr, "			  [ addrgenmode { eui64 | none } ]\n");
@@ -352,6 +353,18 @@ static int iplink_parse_vf(int vf, int *argcp, char ***argvp,
 			ivs.vf = vf;
 			addattr_l(&req->n, sizeof(*req), IFLA_VF_RSS_QUERY_EN, &ivs, sizeof(ivs));
 
+		} else if (matches(*argv, "trust") == 0) {
+			struct ifla_vf_trust ivt;
+			NEXT_ARG();
+			if (matches(*argv, "on") == 0)
+				ivt.setting = 1;
+			else if (matches(*argv, "off") == 0)
+				ivt.setting = 0;
+			else
+				invarg("Invalid \"trust\" value\n", *argv);
+			ivt.vf = vf;
+			addattr_l(&req->n, sizeof(*req), IFLA_VF_TRUST, &ivt, sizeof(ivt));
+
 		} else if (matches(*argv, "state") == 0) {
 			struct ifla_vf_link_state ivl;
 
diff --git a/man/man8/ip-link.8.in b/man/man8/ip-link.8.in
index 4928249..6a0c876 100644
--- a/man/man8/ip-link.8.in
+++ b/man/man8/ip-link.8.in
@@ -142,7 +142,8 @@ ip-link \- network device configuration
 .B min_tx_rate
 .IR TXRATE " ] ["
 .B spoofchk { on | off } ] [
-.B state { auto | enable | disable}
+.B state { auto | enable | disable} ] [
+.B trust { on | off }
 ] |
 .br
 .B master
@@ -968,6 +969,10 @@ parameter must be specified.
 reflection of the PF link state, enable lets the VF to communicate with other VFs on
 this host even if the PF link state is down, disable causes the HW to drop any packets
 sent by the VF.
+.sp
+.BI trust " on|off"
+- trust the specified VF user. This enables that VF user can set a specific feature
+which may impact security and/or perfomance. (e.g. VF multicast promiscuous mode)
 .in -8
 
 .TP
-- 
1.8.3.1

