From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Thu, 31 Aug 2017 18:26:45 -0700
Subject: [Intel-wired-lan] [RFC iproute2 1/2] update headers with CBS API
	[RFC]
Message-ID: <20170901012646.14939-1-vinicius.gomes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 include/linux/pkt_sched.h | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/include/linux/pkt_sched.h b/include/linux/pkt_sched.h
index 099bf552..ba6c9a54 100644
--- a/include/linux/pkt_sched.h
+++ b/include/linux/pkt_sched.h
@@ -871,4 +871,33 @@ struct tc_pie_xstats {
 	__u32 maxq;             /* maximum queue size */
 	__u32 ecn_mark;         /* packets marked with ecn*/
 };
+
+/* CBS */
+/* FIXME: this is only for usage with ndo_setup_tc(), this should be
+ * in another header someplace else. Is pkt_cls.h the right place?
+ */
+struct tc_cbs_qopt_offload {
+	__u8		enable;
+	__s32		queue;
+	__s32		hicredit;
+	__s32		locredit;
+	__s32		idleslope;
+	__s32		sendslope;
+};
+
+struct tc_cbs_qopt {
+	__s32		hicredit;
+	__s32		locredit;
+	__s32		idleslope;
+	__s32		sendslope;
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
2.14.1

