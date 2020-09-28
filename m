From: Nitesh Narayan Lal <nitesh@redhat.com>
Date: Mon, 28 Sep 2020 14:35:26 -0400
Subject: [Intel-wired-lan] [PATCH v4 1/4] sched/isolation: API to get number
 of housekeeping CPUs
In-Reply-To: <20200928183529.471328-1-nitesh@redhat.com>
References: <20200928183529.471328-1-nitesh@redhat.com>
Message-ID: <20200928183529.471328-2-nitesh@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Introduce a new API housekeeping_num_online_cpus(), that can be used to
retrieve the number of online housekeeping CPUs based on the housekeeping
flag passed by the caller.

Some of the consumers for this API are the device drivers that were
previously relying only on num_online_cpus() to determine the number of
MSIX vectors to create. In real-time environments to minimize interruptions
to isolated CPUs, all device-specific IRQ vectors are often moved to the
housekeeping CPUs, having excess vectors could cause housekeeping CPU to
run out of IRQ vectors.

Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>
---
 include/linux/sched/isolation.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
index cc9f393e2a70..e021b1846c1d 100644
--- a/include/linux/sched/isolation.h
+++ b/include/linux/sched/isolation.h
@@ -57,4 +57,13 @@ static inline bool housekeeping_cpu(int cpu, enum hk_flags flags)
 	return true;
 }
 
+static inline unsigned int housekeeping_num_online_cpus(enum hk_flags flags)
+{
+#ifdef CONFIG_CPU_ISOLATION
+	if (static_branch_unlikely(&housekeeping_overridden))
+		return cpumask_weight(housekeeping_cpumask(flags));
+#endif
+	return num_online_cpus();
+}
+
 #endif /* _LINUX_SCHED_ISOLATION_H */
-- 
2.18.2

