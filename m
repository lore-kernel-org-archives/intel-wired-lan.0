From: Vedang Patel <vedang.patel@intel.com>
Date: Fri, 21 Jun 2019 10:28:25 -0700
Subject: [Intel-wired-lan] [PATCH net-next v5 4/7] taprio: Remove inline
 directive
In-Reply-To: <1561138108-12943-1-git-send-email-vedang.patel@intel.com>
References: <1561138108-12943-1-git-send-email-vedang.patel@intel.com>
Message-ID: <1561138108-12943-5-git-send-email-vedang.patel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Remove inline directive from length_to_duration(). We will let the compiler
make the decisions.

Signed-off-by: Vedang Patel <vedang.patel@intel.com>
---
 net/sched/sch_taprio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index a41d7d4434ee..6ef0cc03fdb9 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -168,7 +168,7 @@ static struct sk_buff *taprio_peek(struct Qdisc *sch)
 	return NULL;
 }
 
-static inline int length_to_duration(struct taprio_sched *q, int len)
+static int length_to_duration(struct taprio_sched *q, int len)
 {
 	return div_u64(len * atomic64_read(&q->picos_per_byte), 1000);
 }
-- 
2.7.3

