From: Joel Fernandes <joel@joelfernandes.org>
Date: Thu, 21 Feb 2019 12:17:19 -0500
Subject: [Intel-wired-lan] [PATCH RFC 4/5] sched/topology: Annonate RCU
 pointers properly
In-Reply-To: <20190221152944.GS32494@hirez.programming.kicks-ass.net>
References: <20190221054942.132388-1-joel@joelfernandes.org>
 <20190221054942.132388-5-joel@joelfernandes.org>
 <20190221091944.GY32477@hirez.programming.kicks-ass.net>
 <20190221151057.GA19213@google.com>
 <20190221152944.GS32494@hirez.programming.kicks-ass.net>
Message-ID: <20190221171719.GB118415@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Feb 21, 2019 at 04:29:44PM +0100, Peter Zijlstra wrote:
> On Thu, Feb 21, 2019 at 10:10:57AM -0500, Joel Fernandes wrote:
> > Hi Peter,
> > 
> > Thanks for taking a look.
> > 
> > On Thu, Feb 21, 2019 at 10:19:44AM +0100, Peter Zijlstra wrote:
> > > On Thu, Feb 21, 2019 at 12:49:41AM -0500, Joel Fernandes (Google) wrote:
> > > 
> > > > Also replace rcu_assign_pointer call on rq->sd with WRITE_ONCE. This
> > > > should be sufficient for the rq->sd initialization.
> > > 
> > > > @@ -668,7 +668,7 @@ cpu_attach_domain(struct sched_domain *sd, struct root_domain *rd, int cpu)
> > > >  
> > > >  	rq_attach_root(rq, rd);
> > > >  	tmp = rq->sd;
> > > > -	rcu_assign_pointer(rq->sd, sd);
> > > > +	WRITE_ONCE(rq->sd, sd);
> > > >  	dirty_sched_domain_sysctl(cpu);
> > > >  	destroy_sched_domains(tmp);
> > > 
> > > Where did the RELEASE barrier go?
> > > 
> > > That was a publish operation, now it is not.
> > 
> > Funny thing is, initially I had written this patch with smp_store_release()
> > instead of WRITE_ONCE, but checkpatch complaints with that since it needs a
> > comment on top of it, and I wasn't sure if RELEASE barrier was the intent of
> > using rcu_assign_pointer (all the more reason to replace it with something
> > more explicit).
> > 
> > I will replace it with the following and resubmit it then:
> > 
> > /* Release barrier */
> > smp_store_release(&rq->sd, sd);
> > 
> > Or do we want to just drop the "Release barrier" comment and live with the
> > checkpatch warning?
> 
> How about we keep using rcu_assign_pointer(), the whole sched domain
> tree is under rcu; peruse that destroy_sched_domains() function for
> instance.
> 
> Also check how for_each_domain() uses rcu_dereference().

May be then, all those pointers should be made __rcu as well. Then we can use
rcu_assign_pointer() here. I will look more into it and study these functions
as you are suggesting.

thanks,

- Joel

