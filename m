From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Wed, 18 Oct 2017 15:47:03 -0700
Subject: [Intel-wired-lan] [next-queue PATCH] net/sched/sch_cbs: Fix
	compilation on 32bit architectures
Message-ID: <20171018224703.15454-1-vinicius.gomes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

There was still a couple of divisions of 64bit quantities happening,
which can fail to compile if there aren't instructions to handle that
kind of division.

It will fail with a message like this:

ERROR: "__aeabi_ldivmod" [net/sched/sch_cbs.ko] undefined!

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 net/sched/sch_cbs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/sched/sch_cbs.c b/net/sched/sch_cbs.c
index cae021c642e5..bdb533b7fb8c 100644
--- a/net/sched/sch_cbs.c
+++ b/net/sched/sch_cbs.c
@@ -331,8 +331,8 @@ static int cbs_dump(struct Qdisc *sch, struct sk_buff *skb)
 
 	opt.hicredit = q->hicredit;
 	opt.locredit = q->locredit;
-	opt.sendslope = q->sendslope / BYTES_PER_KBIT;
-	opt.idleslope = q->idleslope / BYTES_PER_KBIT;
+	opt.sendslope = div64_s64(q->sendslope, BYTES_PER_KBIT);
+	opt.idleslope = div64_s64(q->idleslope, BYTES_PER_KBIT);
 	opt.offload = q->offload;
 
 	if (nla_put(skb, TCA_CBS_PARMS, sizeof(opt), &opt))
-- 
2.14.2

