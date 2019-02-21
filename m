From: Peter Zijlstra <peterz@infradead.org>
Date: Thu, 21 Feb 2019 10:18:05 +0100
Subject: [Intel-wired-lan] [PATCH RFC 3/5] sched/cpufreq: Fix incorrect
 RCU API usage
In-Reply-To: <20190221054942.132388-4-joel@joelfernandes.org>
References: <20190221054942.132388-1-joel@joelfernandes.org>
 <20190221054942.132388-4-joel@joelfernandes.org>
Message-ID: <20190221091805.GX32477@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Feb 21, 2019 at 12:49:40AM -0500, Joel Fernandes (Google) wrote:
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
>  
>  	data->func = func;
>  	rcu_assign_pointer(per_cpu(cpufreq_update_util_data, cpu), data);

This doesn't make any kind of sense to me.

