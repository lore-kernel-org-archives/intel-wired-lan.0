From: Frederic Weisbecker <frederic@kernel.org>
Date: Fri, 23 Oct 2020 15:29:50 +0200
Subject: [Intel-wired-lan] [PATCH v4 2/4] sched/isolation: Extend
 nohz_full to isolate managed IRQs
In-Reply-To: <20201023132505.GZ2628@hirez.programming.kicks-ass.net>
References: <20200928183529.471328-1-nitesh@redhat.com>
 <20200928183529.471328-3-nitesh@redhat.com>
 <20201023132505.GZ2628@hirez.programming.kicks-ass.net>
Message-ID: <20201023132950.GA47962@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, Oct 23, 2020 at 03:25:05PM +0200, Peter Zijlstra wrote:
> On Mon, Sep 28, 2020 at 02:35:27PM -0400, Nitesh Narayan Lal wrote:
> > Extend nohz_full feature set to include isolation from managed IRQS. This
> 
> So you say it's for managed-irqs, the feature is actually called
> MANAGED_IRQ, but, AFAICT, it does *NOT* in fact affect managed IRQs.
> 
> Also, as per Thomas' earlier points, managed-irqs are in fact perfectly
> fine and don't need help at at...
> 
> > is required specifically for setups that only uses nohz_full and still
> > requires isolation for maintaining lower latency for the listed CPUs.
> > 
> > Suggested-by: Frederic Weisbecker <frederic@kernel.org>

Ah and yes there is this tag :-p

So that's my bad, I really thought this thing was about managed IRQ.
The problem is that I can't find a single documentation about them so I'm
too clueless on that matter.

Thanks.

> > Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>
> > ---
> >  kernel/sched/isolation.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
> > index 5a6ea03f9882..9df9598a9e39 100644
> > --- a/kernel/sched/isolation.c
> > +++ b/kernel/sched/isolation.c
> > @@ -141,7 +141,7 @@ static int __init housekeeping_nohz_full_setup(char *str)
> >  	unsigned int flags;
> >  
> >  	flags = HK_FLAG_TICK | HK_FLAG_WQ | HK_FLAG_TIMER | HK_FLAG_RCU |
> > -		HK_FLAG_MISC | HK_FLAG_KTHREAD;
> > +		HK_FLAG_MISC | HK_FLAG_KTHREAD | HK_FLAG_MANAGED_IRQ;
> >  
> >  	return housekeeping_setup(str, flags);
> >  }
> > -- 
> > 2.18.2
> > 
