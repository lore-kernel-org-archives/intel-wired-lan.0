From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri, 10 Nov 2017 10:55:53 -0800
Subject: [Intel-wired-lan] [PATCH 3/3] ethtool: correct VF index values for
 the ring_cookie parameter
In-Reply-To: <20171110185553.14657-1-jacob.e.keller@intel.com>
References: <20171110185553.14657-1-jacob.e.keller@intel.com>
Message-ID: <20171110185553.14657-3-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Instead of relying on the input being offset by 1, instead adjust the
"vf" input value by 1 so that it correctly targets the VF the user
expects. Additionally, update the displayed output to show the correct
VF number.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---

This is the way the VF parameter should have worked from the beginning,
but unfortunately I did not code it as such. It may be considered a
functional change (since we already supported the vf parameter with the
offset not handled properly). I would consider this a bug fix, but it
might be considered a behavior change....

 ethtool.8.in |  3 +--
 rxclass.c    | 14 +++++++++++++-
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/ethtool.8.in b/ethtool.8.in
index 6ad30650eb5b..76f86e6b6827 100644
--- a/ethtool.8.in
+++ b/ethtool.8.in
@@ -839,8 +839,7 @@ lB	l.
 .TE
 .TP
 .BI vf \ N
-Specifies the Virtual Function the filter applies to. A value of 0 indicates
-the PF, and thus the VF index is offset by 1. Not compatible with action.
+Specifies the Virtual Function the filter applies to. Not compatible with action.
 .TP
 .BI queue \ N
 Specifies the Rx queue to send packets to. Not compatible with action.
diff --git a/rxclass.c b/rxclass.c
index 144c8e5e76be..e05031b6a23f 100644
--- a/rxclass.c
+++ b/rxclass.c
@@ -251,9 +251,14 @@ static void rxclass_print_nfc_rule(struct ethtool_rx_flow_spec *fsp)
 		u64 vf = ethtool_get_flow_spec_ring_vf(fsp->ring_cookie);
 		u64 queue = ethtool_get_flow_spec_ring(fsp->ring_cookie);
 
+		/* A value of zero indicates that this rule targeted the main
+		 * function. A positive value indicates which virtual function
+		 * was targeted, so we'll subtract 1 in order to show the
+		 * correct VF index
+		 */
 		if (vf)
 			fprintf(stdout, "\tAction: Direct to VF %llu queue %llu\n",
-				vf, queue);
+				vf - 1, queue);
 		else
 			fprintf(stdout, "\tAction: Direct to queue %llu\n",
 				queue);
@@ -1047,6 +1052,13 @@ static int rxclass_get_val(char *str, unsigned char *p, u32 *flags,
 		err = rxclass_get_ulong(str, &val, 8);
 		if (err)
 			return -1;
+
+		/* The ring_cookie uses 0 to indicate the rule targets the
+		 * main function, so add 1 to the value in order to target the
+		 * correct virtual function.
+		 */
+		val++;
+
 		*(u64 *)&p[opt->offset] &= ~ETHTOOL_RX_FLOW_SPEC_RING_VF;
 		*(u64 *)&p[opt->offset] = (u64)val << ETHTOOL_RX_FLOW_SPEC_RING_VF_OFF;
 		break;
-- 
2.15.0

