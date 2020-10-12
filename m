From: Ira Weiny <ira.weiny@intel.com>
Date: Mon, 12 Oct 2020 12:53:54 -0700
Subject: [Intel-wired-lan] [PATCH RFC PKS/PMEM 22/58] fs/f2fs: Utilize
 new kmap_thread()
In-Reply-To: <20201012164438.GA20115@casper.infradead.org>
References: <20201009195033.3208459-1-ira.weiny@intel.com>
 <20201009195033.3208459-23-ira.weiny@intel.com>
 <20201009213434.GA839@sol.localdomain>
 <20201010003954.GW20115@casper.infradead.org>
 <20201010013036.GD1122@sol.localdomain>
 <20201012065635.GB2046448@iweiny-DESK2.sc.intel.com>
 <20201012161946.GA858@sol.localdomain>
 <5d621db9-23d4-e140-45eb-d7fca2093d2b@intel.com>
 <20201012164438.GA20115@casper.infradead.org>
Message-ID: <20201012195354.GC2046448@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Oct 12, 2020 at 05:44:38PM +0100, Matthew Wilcox wrote:
> On Mon, Oct 12, 2020 at 09:28:29AM -0700, Dave Hansen wrote:
> > kmap_atomic() is always preferred over kmap()/kmap_thread().
> > kmap_atomic() is _much_ more lightweight since its TLB invalidation is
> > always CPU-local and never broadcast.
> > 
> > So, basically, unless you *must* sleep while the mapping is in place,
> > kmap_atomic() is preferred.
> 
> But kmap_atomic() disables preemption, so the _ideal_ interface would map
> it only locally, then on preemption make it global.  I don't even know
> if that _can_ be done.  But this email makes it seem like kmap_atomic()
> has no downsides.

And that is IIUC what Thomas was trying to solve.

Also, Linus brought up that kmap_atomic() has quirks in nesting.[1]

From what I can see all of these discussions support the need to have something
between kmap() and kmap_atomic().

However, the reason behind converting call sites to kmap_thread() are different
between Thomas' patch set and mine.  Both require more kmap granularity.
However, they do so with different reasons and underlying implementations but
with the _same_ resulting semantics; a thread local mapping which is
preemptable.[2]  Therefore they each focus on changing different call sites.

While this patch set is huge I think it serves a valuable purpose to identify a
large number of call sites which are candidates for this new semantic.

Ira

[1] https://lore.kernel.org/lkml/CAHk-=wgbmwsTOKs23Z=71EBTrULoeaH2U3TNqT2atHEWvkBKdw at mail.gmail.com/
[2] It is important to note these implementations are not incompatible with
each other.  So I don't see yet another 'kmap_something()' being required.
