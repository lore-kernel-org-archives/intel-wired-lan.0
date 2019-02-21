From: Joel Fernandes (Google) <joel@joelfernandes.org>
Date: Thu, 21 Feb 2019 00:49:40 -0500
Subject: [Intel-wired-lan] [PATCH RFC 3/5] sched/cpufreq: Fix incorrect RCU
 API usage
In-Reply-To: <20190221054942.132388-1-joel@joelfernandes.org>
References: <20190221054942.132388-1-joel@joelfernandes.org>
Message-ID: <20190221054942.132388-4-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Recently I added an RCU annotation check to rcu_assign_pointer(). All
pointers assigned to RCU protected data are to be annotated with __rcu
inorder to be able to use rcu_assign_pointer() similar to checks in
other RCU APIs.

This resulted in a sparse error: kernel//sched/cpufreq.c:41:9: sparse:
error: incompatible types in comparison expression (different address
spaces)

Fix this by using the correct APIs for RCU accesses. This will
potentially avoid any future bugs in the code. If it is felt that RCU
protection is not needed here, then the rcu_assign_pointer call can be
dropped and replaced with, say, WRITE_ONCE or smp_store_release. Or, may
be we add a new API to do it. But calls rcu_assign_pointer seems an
abuse of the RCU API unless RCU is being used.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/sched/cpufreq.c | 8 ++++++--
 kernel/sched/sched.h   | 2 +-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/cpufreq.c b/kernel/sched/cpufreq.c
index 22bd8980f32f..c9aeb3bf5dc2 100644
--- a/kernel/sched/cpufreq.c
+++ b/kernel/sched/cpufreq.c
@@ -7,7 +7,7 @@
  */
 #include "sched.h"
 
-DEFINE_PER_CPU(struct update_util_data *, cpufreq_update_util_data);
+DEFINE_PER_CPU(struct update_util_data __rcu *, cpufreq_update_util_data);
 
 /**
  * cpufreq_add_update_util_hook - Populate the CPU's update_util_data pointer.
@@ -34,8 +34,12 @@ void cpufreq_add_update_util_hook(int cpu, struct update_util_data *data,
 	if (WARN_ON(!data || !func))
 		return;
 
-	if (WARN_ON(per_cpu(cpufreq_update_util_data, cpu)))
+	rcu_read_lock();
+	if (WARN_ON(rcu_dereference(per_cpu(cpufreq_update_util_data, cpu)))) {
+		rcu_read_unlock();
 		return;
+	}
+	rcu_read_unlock();
 
 	data->func = func;
 	rcu_assign_pointer(per_cpu(cpufreq_update_util_data, cpu), data);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index d04530bf251f..2ab545d40381 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2166,7 +2166,7 @@ static inline u64 irq_time_read(int cpu)
 #endif /* CONFIG_IRQ_TIME_ACCOUNTING */
 
 #ifdef CONFIG_CPU_FREQ
-DECLARE_PER_CPU(struct update_util_data *, cpufreq_update_util_data);
+DECLARE_PER_CPU(struct update_util_data __rcu *, cpufreq_update_util_data);
 
 /**
  * cpufreq_update_util - Take a note about CPU utilization changes.
-- 
2.21.0.rc0.258.g878e2cd30e-goog

