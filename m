From: Peter Zijlstra <peterz@infradead.org>
Date: Thu, 21 Feb 2019 10:19:44 +0100
Subject: [Intel-wired-lan] [PATCH RFC 4/5] sched/topology: Annonate RCU
 pointers properly
In-Reply-To: <20190221054942.132388-5-joel@joelfernandes.org>
References: <20190221054942.132388-1-joel@joelfernandes.org>
 <20190221054942.132388-5-joel@joelfernandes.org>
Message-ID: <20190221091944.GY32477@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Feb 21, 2019 at 12:49:41AM -0500, Joel Fernandes (Google) wrote:

> Also replace rcu_assign_pointer call on rq->sd with WRITE_ONCE. This
> should be sufficient for the rq->sd initialization.

> @@ -668,7 +668,7 @@ cpu_attach_domain(struct sched_domain *sd, struct root_domain *rd, int cpu)
>  
>  	rq_attach_root(rq, rd);
>  	tmp = rq->sd;
> -	rcu_assign_pointer(rq->sd, sd);
> +	WRITE_ONCE(rq->sd, sd);
>  	dirty_sched_domain_sysctl(cpu);
>  	destroy_sched_domains(tmp);

Where did the RELEASE barrier go?

That was a publish operation, now it is not.
