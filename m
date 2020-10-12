From: Ira Weiny <ira.weiny@intel.com>
Date: Mon, 12 Oct 2020 16:31:26 -0700
Subject: [Intel-wired-lan] [PATCH RFC PKS/PMEM 22/58] fs/f2fs: Utilize
 new kmap_thread()
In-Reply-To: <20201012200254.GB20115@casper.infradead.org>
References: <20201009195033.3208459-23-ira.weiny@intel.com>
 <20201009213434.GA839@sol.localdomain>
 <20201010003954.GW20115@casper.infradead.org>
 <20201010013036.GD1122@sol.localdomain>
 <20201012065635.GB2046448@iweiny-DESK2.sc.intel.com>
 <20201012161946.GA858@sol.localdomain>
 <5d621db9-23d4-e140-45eb-d7fca2093d2b@intel.com>
 <20201012164438.GA20115@casper.infradead.org>
 <20201012195354.GC2046448@iweiny-DESK2.sc.intel.com>
 <20201012200254.GB20115@casper.infradead.org>
Message-ID: <20201012233126.GD2046448@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Oct 12, 2020 at 09:02:54PM +0100, Matthew Wilcox wrote:
> On Mon, Oct 12, 2020 at 12:53:54PM -0700, Ira Weiny wrote:
> > On Mon, Oct 12, 2020 at 05:44:38PM +0100, Matthew Wilcox wrote:
> > > On Mon, Oct 12, 2020 at 09:28:29AM -0700, Dave Hansen wrote:
> > > > kmap_atomic() is always preferred over kmap()/kmap_thread().
> > > > kmap_atomic() is _much_ more lightweight since its TLB invalidation is
> > > > always CPU-local and never broadcast.
> > > > 
> > > > So, basically, unless you *must* sleep while the mapping is in place,
> > > > kmap_atomic() is preferred.
> > > 
> > > But kmap_atomic() disables preemption, so the _ideal_ interface would map
> > > it only locally, then on preemption make it global.  I don't even know
> > > if that _can_ be done.  But this email makes it seem like kmap_atomic()
> > > has no downsides.
> > 
> > And that is IIUC what Thomas was trying to solve.
> > 
> > Also, Linus brought up that kmap_atomic() has quirks in nesting.[1]
> > 
> > >From what I can see all of these discussions support the need to have something
> > between kmap() and kmap_atomic().
> > 
> > However, the reason behind converting call sites to kmap_thread() are different
> > between Thomas' patch set and mine.  Both require more kmap granularity.
> > However, they do so with different reasons and underlying implementations but
> > with the _same_ resulting semantics; a thread local mapping which is
> > preemptable.[2]  Therefore they each focus on changing different call sites.
> > 
> > While this patch set is huge I think it serves a valuable purpose to identify a
> > large number of call sites which are candidates for this new semantic.
> 
> Yes, I agree.  My problem with this patch-set is that it ties it to
> some Intel feature that almost nobody cares about.

I humbly disagree.  At this level the only thing this is tied to is the idea
that there are additional memory protections available which can be enabled
quickly on a per-thread basis.  PKS on Intel is but 1 implementation of that.

Even the kmap code only has knowledge that there is something which needs to be
done special on a devm page.

>
> Maybe we should
> care about it, but you didn't try very hard to make anyone care about
> it in the cover letter.

Ok my bad.  We have customers who care very much about restricting access to
the PMEM pages to prevent bugs in the kernel from causing permanent damage to
their data/file systems.  I'll reword the cover letter better.

> 
> For a future patch-set, I'd like to see you just introduce the new
> API.  Then you can optimise the Intel implementation of it afterwards.
> Those patch-sets have entirely different reviewers.

I considered doing this.  But this seemed more logical because the feature is
being driven by PMEM which is behind the kmap interface not by the users of the
API.

I can introduce a patch set with a kmap_thread() call which does nothing if
that is more palatable but it seems wrong to me to do so.

Ira
