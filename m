From: Peter Zijlstra <peterz@infradead.org>
Date: Thu, 24 Sep 2020 14:24:02 +0200
Subject: [Intel-wired-lan] [PATCH v2 1/4] sched/isolation: API to get
 housekeeping online CPUs
In-Reply-To: <20200924120956.GA19346@lenoir>
References: <20200923181126.223766-1-nitesh@redhat.com>
 <20200923181126.223766-2-nitesh@redhat.com>
 <20200924084029.GC1362448@hirez.programming.kicks-ass.net>
 <20200924120956.GA19346@lenoir>
Message-ID: <20200924122402.GH2628@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Sep 24, 2020 at 02:09:57PM +0200, Frederic Weisbecker wrote:

> > > +static inline unsigned int hk_num_online_cpus(void)
> > 
> > This breaks with the established naming of that header.
> 
> I guess we can make it housekeeping_num_online_cpus() ?

That would be consistent :-)
