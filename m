From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Tue, 10 Oct 2017 17:46:50 -0700
Subject: [Intel-wired-lan] [iproute2 net-next v2 1/3] update headers with
	CBS API [ONLY FOR TESTING]
Message-ID: <20171011004652.15630-1-vinicius.gomes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The headers will be updated when iproute2 fetches the headers from
net-next, this patch is only to ease testing.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 include/linux/pkt_sched.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/linux/pkt_sched.h b/include/linux/pkt_sched.h
index 099bf552..41e349df 100644
--- a/include/linux/pkt_sched.h
+++ b/include/linux/pkt_sched.h
@@ -871,4 +871,22 @@ struct tc_pie_xstats {
 	__u32 maxq;             /* maximum queue size */
 	__u32 ecn_mark;         /* packets marked with ecn*/
 };
+
+/* CBS */
+struct tc_cbs_qopt {
+	__u8 offload;
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

