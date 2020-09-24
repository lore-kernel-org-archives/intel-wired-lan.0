From: Frederic Weisbecker <frederic@kernel.org>
Date: Thu, 24 Sep 2020 14:11:51 +0200
Subject: [Intel-wired-lan] [PATCH v2 1/4] sched/isolation: API to get
 housekeeping online CPUs
In-Reply-To: <20200923181126.223766-2-nitesh@redhat.com>
References: <20200923181126.223766-1-nitesh@redhat.com>
 <20200923181126.223766-2-nitesh@redhat.com>
Message-ID: <20200924121150.GB19346@lenoir>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Sep 23, 2020 at 02:11:23PM -0400, Nitesh Narayan Lal wrote:
> Introduce a new API hk_num_online_cpus(), that can be used to
> retrieve the number of online housekeeping CPUs that are meant to handle
> managed IRQ jobs.
> 
> This API is introduced for the drivers that were previously relying only
> on num_online_cpus() to determine the number of MSIX vectors to create.
> In an RT environment with large isolated but fewer housekeeping CPUs this
> was leading to a situation where an attempt to move all of the vectors
> corresponding to isolated CPUs to housekeeping CPUs were failing due to
> per CPU vector limit.
> 
> Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>
> ---
>  include/linux/sched/isolation.h | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
> index cc9f393e2a70..2e96b626e02e 100644
> --- a/include/linux/sched/isolation.h
> +++ b/include/linux/sched/isolation.h
> @@ -57,4 +57,17 @@ static inline bool housekeeping_cpu(int cpu, enum hk_flags flags)
>  	return true;
>  }
>  
> +static inline unsigned int hk_num_online_cpus(void)
> +{
> +#ifdef CONFIG_CPU_ISOLATION
> +	const struct cpumask *hk_mask;
> +
> +	if (static_branch_unlikely(&housekeeping_overridden)) {
> +		hk_mask = housekeeping_cpumask(HK_FLAG_MANAGED_IRQ);

HK_FLAG_MANAGED_IRQ should be pass as an argument to the function:

housekeeping_num_online_cpus(HK_FLAG_MANAGED_IRQ) because it's
completely arbitrary otherwise.

> +		return cpumask_weight(hk_mask);
> +	}
> +#endif
> +	return cpumask_weight(cpu_online_mask);
> +}
> +
>  #endif /* _LINUX_SCHED_ISOLATION_H */
> -- 
> 2.18.2
> 
