From: Paul E. McKenney <paulmck@linux.ibm.com>
Date: Thu, 21 Feb 2019 09:29:48 -0800
Subject: [Intel-wired-lan] [PATCH RFC 3/5] sched/cpufreq: Fix incorrect
 RCU API usage
In-Reply-To: <20190221171311.GA118415@google.com>
References: <20190221054942.132388-1-joel@joelfernandes.org>
 <20190221054942.132388-4-joel@joelfernandes.org>
 <20190221091805.GX32477@hirez.programming.kicks-ass.net>
 <20190221152139.GB19213@google.com>
 <20190221153117.GT32494@hirez.programming.kicks-ass.net>
 <20190221155218.GZ11787@linux.ibm.com>
 <20190221161144.GU32494@hirez.programming.kicks-ass.net>
 <20190221171311.GA118415@google.com>
Message-ID: <20190221172948.GA11787@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Feb 21, 2019 at 12:13:11PM -0500, Joel Fernandes wrote:
> On Thu, Feb 21, 2019 at 05:11:44PM +0100, Peter Zijlstra wrote:
> > On Thu, Feb 21, 2019 at 07:52:18AM -0800, Paul E. McKenney wrote:
> > > On Thu, Feb 21, 2019 at 04:31:17PM +0100, Peter Zijlstra wrote:
> > > > On Thu, Feb 21, 2019 at 10:21:39AM -0500, Joel Fernandes wrote:
> > > > > On Thu, Feb 21, 2019 at 10:18:05AM +0100, Peter Zijlstra wrote:
> > > > > > On Thu, Feb 21, 2019 at 12:49:40AM -0500, Joel Fernandes (Google) wrote:
> > > > > > > @@ -34,8 +34,12 @@ void cpufreq_add_update_util_hook(int cpu, struct update_util_data *data,
> > > > > > >  	if (WARN_ON(!data || !func))
> > > > > > >  		return;
> > > > > > >  
> > > > > > > -	if (WARN_ON(per_cpu(cpufreq_update_util_data, cpu)))
> > > > > > > +	rcu_read_lock();
> > > > > > > +	if (WARN_ON(rcu_dereference(per_cpu(cpufreq_update_util_data, cpu)))) {
> > > > > > > +		rcu_read_unlock();
> > > > > > >  		return;
> > > > > > > +	}
> > > > > > > +	rcu_read_unlock();
> > > > > > >  
> > > > > > >  	data->func = func;
> > > > > > >  	rcu_assign_pointer(per_cpu(cpufreq_update_util_data, cpu), data);
> > 
> > > For whatever it is worth, in that case it could use rcu_access_pointer().
> > > And this primitive does not do the lockdep check for being within an RCU
> > > read-side critical section.  As Peter says, if there is no dereferencing,
> > > there can be no use-after-free bug, so the RCU read-side critical is
> > > not needed.
> > 
> > On top of that, I suspect this is under the write-side lock (we're doing
> > assignment after all).
> 
> Yes it is under a policy->rwsem, just confirmed that.
> 
> And indeed rcu_read_lock() is not needed here in this patch, thanks for
> pointing that out. Sometimes the word "dereference" plays some visual tricks
> and in this case tempted me to add an RCU reader section ;-) Assuming you
> guys are in agreement with usage of rcu_access_pointer() here to keep sparse
> happy, I'll rework the patch accordingly and resubmit with that.

Works for me!

							Thanx, Paul

