From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Tue, 26 Sep 2017 16:39:56 -0700
Subject: [Intel-wired-lan] [iproute2 net-next 1/3] update headers with CBS
	API
Message-ID: <20170926233958.12027-1-vinicius.gomes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 include/linux/pkt_sched.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/linux/pkt_sched.h b/include/linux/pkt_sched.h
index 099bf552..27c849c0 100644
--- a/include/linux/pkt_sched.h
+++ b/include/linux/pkt_sched.h
@@ -871,4 +871,21 @@ struct tc_pie_xstats {
 	__u32 maxq;             /* maximum queue size */
 	__u32 ecn_mark;         /* packets marked with ecn*/
 };
+
+/* CBS */
+struct tc_cbs_qopt {
+	__s32 hicredit;
+	__s32 locredit;
+	__s32 idleslope;
+	__s32 sendslope;
+};
+
+enum {
+	TCA_CBS_UNSPEC,
+	TCA_CBS_PARMS,
+	__TCA_CBS_MAX,
+};
+
+#define TCA_CBS_MAX (__TCA_CBS_MAX - 1)
+
 #endif
-- 
2.14.2

