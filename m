From: Rose, Gregory V <gregory.v.rose@intel.com>
Date: Fri, 26 Feb 2016 15:47:12 +0000
Subject: [Intel-wired-lan] [PATCH iproute2 v2] iplink: Support VF Trust
In-Reply-To: <7F861DC0615E0C47A872E6F3C5FCDDBD05FB353F@BPXM14GP.gisp.nec.co.jp>
References: <7F861DC0615E0C47A872E6F3C5FCDDBD05FB353F@BPXM14GP.gisp.nec.co.jp>
Message-ID: <C5551D9AAB213A418B7FD5E4A6F30A0789F3905B@ORSMSX116.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

-----Original Message-----
From: Hiroshi Shimamoto [mailto:h-shimamoto at ct.jp.nec.com] 
Sent: Thursday, February 25, 2016 6:40 PM
To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; Stephen Hemminger <stephen@networkplumber.org>
Cc: Rose, Gregory V <gregory.v.rose@intel.com>; Or Gerlitz <gerlitz.or@gmail.com>; Alexander Duyck <alexander.duyck@gmail.com>; Skidmore, Donald C <donald.c.skidmore@intel.com>; intel-wired-lan at lists.osuosl.org; nhorman at redhat.com; jogreene at redhat.com; Linux Netdev List <netdev@vger.kernel.org>; Choi, Sy Jong <sy.jong.choi@intel.com>; Rony Efraim <ronye@mellanox.com>; Edward Cree <ecree@solarflare.com>; David Miller <davem@davemloft.net>; sassmann at redhat.com
Subject: [PATCH iproute2 v2] iplink: Support VF Trust

From: Hiroshi Shimamoto <h-shimamoto@ct.jp.nec.com>

Add IFLA_VF_TRUST message to trust the VF.
PF can accept some privileged operation from the trusted VF.
For example, ixgbe PF doesn't allow to enable VF promiscuous mode until the VF is trusted because it may hurt performance.

To trust VF.
 # ip link set dev eth0 vf 1 trust on

To untrust VF.
 # ip link set dev eth0 vf 1 trust off

Signed-off-by: Hiroshi Shimamoto <h-shimamoto@ct.jp.nec.com>
---

v1 -> v2: rebase to the latest code of iproute2.

The VF trust patch has been in kernel and the IFLA_VF_TRUST netlink attribute has been included iproute2, but no actual handler for this.
This patch add the functionality to trust vf from ip command.

 ip/iplink.c           | 13 +++++++++++++
 man/man8/ip-link.8.in |  7 ++++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/ip/iplink.c b/ip/iplink.c
index 5ab9d61..69f5057 100644
--- a/ip/iplink.c
+++ b/ip/iplink.c
@@ -82,6 +82,7 @@ void iplink_usage(void)
 	fprintf(stderr, "				   [ spoofchk { on | off} ] ]\n");
 	fprintf(stderr, "				   [ query_rss { on | off} ] ]\n");
 	fprintf(stderr, "				   [ state { auto | enable | disable} ] ]\n");
+	fprintf(stderr, "				   [ trust { on | off} ] ]\n");
 	fprintf(stderr, "			  [ master DEVICE ]\n");
 	fprintf(stderr, "			  [ nomaster ]\n");
 	fprintf(stderr, "			  [ addrgenmode { eui64 | none | stable_secret | random } ]\n");
@@ -356,6 +357,18 @@ static int iplink_parse_vf(int vf, int *argcp, char ***argvp,
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
 
diff --git a/man/man8/ip-link.8.in b/man/man8/ip-link.8.in index 4d32343..7dd7a90 100644
--- a/man/man8/ip-link.8.in
+++ b/man/man8/ip-link.8.in
@@ -142,7 +142,8 @@ ip-link \- network device configuration  .B min_tx_rate  .IR TXRATE " ] ["
 .B spoofchk { on | off } ] [
-.B state { auto | enable | disable}
+.B state { auto | enable | disable} ] [ .B trust { on | off }
 ] |
 .br
 .B master
@@ -1019,6 +1020,10 @@ parameter must be specified.
 reflection of the PF link state, enable lets the VF to communicate with other VFs on  this host even if the PF link state is down, disable causes the HW to drop any packets  sent by the VF.
+.sp
+.BI trust " on|off"
+- trust the specified VF user. This enables that VF user can set a 
+specific feature which may impact security and/or performance. (e.g. VF 
+multicast promiscuous mode)
 .in -8
 
 .TP
--
1.8.3.1

Acked-by: Greg Rose <Gregory.v.rose@intel.com>

