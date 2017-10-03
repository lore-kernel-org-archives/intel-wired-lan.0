From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Tue,  3 Oct 2017 16:44:32 -0700
Subject: [Intel-wired-lan] [next-queue PATCH v2 3/5] net/sched: Introduce
	the user API for the CBS shaper
In-Reply-To: <20171003234435.8979-1-vinicius.gomes@intel.com>
References: <20171003234435.8979-1-vinicius.gomes@intel.com>
Message-ID: <20171003234435.8979-5-vinicius.gomes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Export the API necessary for configuring the CBS shaper (implemented
in the next patch) via the tc tool.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 include/uapi/linux/pkt_sched.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/uapi/linux/pkt_sched.h b/include/uapi/linux/pkt_sched.h
index 099bf5528fed..27c849c053cf 100644
--- a/include/uapi/linux/pkt_sched.h
+++ b/include/uapi/linux/pkt_sched.h
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

