From: Rafael J. Wysocki <rjw@rjwysocki.net>
Date: Fri, 22 Feb 2019 00:05:08 +0100
Subject: [Intel-wired-lan] [PATCH RFC 3/5] sched/cpufreq: Fix incorrect
 RCU API usage
In-Reply-To: <20190221054942.132388-4-joel@joelfernandes.org>
References: <20190221054942.132388-1-joel@joelfernandes.org>
 <20190221054942.132388-4-joel@joelfernandes.org>
Message-ID: <3194474.xhKMNsEZRq@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thursday, February 21, 2019 6:49:40 AM CET Joel Fernandes (Google) wrote:
> Recently I added an RCU annotation check to rcu_assign_pointer(). All
> pointers assigned to RCU protected data are to be annotated with __rcu
> inorder to be able to use rcu_assign_pointer() similar to checks in
> other RCU APIs.
> 
> This resulted in a sparse error: kernel//sched/cpufreq.c:41:9: sparse:
> error: incompatible types in comparison expression (different address
> spaces)
> 
> Fix this by using the correct APIs for RCU accesses. This will
> potentially avoid any future bugs in the code. If it is felt that RCU
> protection is not needed here, then the rcu_assign_pointer call can be
> dropped and replaced with, say, WRITE_ONCE or smp_store_release. Or, may
> be we add a new API to do it. But calls rcu_assign_pointer seems an
> abuse of the RCU API unless RCU is being used.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  kernel/sched/cpufreq.c | 8 ++++++--
>  kernel/sched/sched.h   | 2 +-
>  2 files changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/cpufreq.c b/kernel/sched/cpufreq.c
> index 22bd8980f32f..c9aeb3bf5dc2 100644
> --- a/kernel/sched/cpufreq.c
> +++ b/kernel/sched/cpufreq.c
> @@ -7,7 +7,7 @@
>   */
>  #include "sched.h"
>  
> -DEFINE_PER_CPU(struct update_util_data *, cpufreq_update_util_data);
> +DEFINE_PER_CPU(struct update_util_data __rcu *, cpufreq_update_util_data);
>  
>  /**
>   * cpufreq_add_update_util_hook - Populate the CPU's update_util_data pointer.
> @@ -34,8 +34,12 @@ void cpufreq_add_update_util_hook(int cpu, struct update_util_data *data,
>  	if (WARN_ON(!data || !func))
>  		return;
>  
> -	if (WARN_ON(per_cpu(cpufreq_update_util_data, cpu)))
> +	rcu_read_lock();
> +	if (WARN_ON(rcu_dereference(per_cpu(cpufreq_update_util_data, cpu)))) {
> +		rcu_read_unlock();
>  		return;
> +	}
> +	rcu_read_unlock();

As Steve said, this is not a read-side critical section, so the rcu_read_lock()
and rcu_read_unlock() don't help.

But rcu_access_pointer() should work here AFAICS.

Cheers,
Rafael

