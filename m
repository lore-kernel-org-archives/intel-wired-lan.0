From: Ira Weiny <ira.weiny@intel.com>
Date: Tue, 13 Oct 2020 13:52:49 -0700
Subject: [Intel-wired-lan] [PATCH RFC PKS/PMEM 24/58] fs/freevxfs:
 Utilize new kmap_thread()
In-Reply-To: <20201013112544.GA5249@infradead.org>
References: <20201009195033.3208459-1-ira.weiny@intel.com>
 <20201009195033.3208459-25-ira.weiny@intel.com>
 <20201013112544.GA5249@infradead.org>
Message-ID: <20201013205248.GJ2046448@iweiny-DESK2.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Oct 13, 2020 at 12:25:44PM +0100, Christoph Hellwig wrote:
> > -	kaddr = kmap(pp);
> > +	kaddr = kmap_thread(pp);
> >  	memcpy(kaddr, vip->vii_immed.vi_immed + offset, PAGE_SIZE);
> > -	kunmap(pp);
> > +	kunmap_thread(pp);
> 
> You only Cced me on this particular patch, which means I have absolutely
> no idea what kmap_thread and kunmap_thread actually do, and thus can't
> provide an informed review.

Sorry the list was so big I struggled with who to CC and on which patches.

> 
> That being said I think your life would be a lot easier if you add
> helpers for the above code sequence and its counterpart that copies
> to a potential hughmem page first, as that hides the implementation
> details from most users.

Matthew Wilcox and Al Viro have suggested similar ideas.

https://lore.kernel.org/lkml/20201013205012.GI2046448 at iweiny-DESK2.sc.intel.com/

Ira
