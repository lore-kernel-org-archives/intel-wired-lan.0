From: Eric Biggers <ebiggers@kernel.org>
Date: Mon, 12 Oct 2020 09:19:46 -0700
Subject: [Intel-wired-lan] [PATCH RFC PKS/PMEM 22/58] fs/f2fs: Utilize
 new kmap_thread()
In-Reply-To: <20201012065635.GB2046448@iweiny-DESK2.sc.intel.com>
References: <20201009195033.3208459-1-ira.weiny@intel.com>
 <20201009195033.3208459-23-ira.weiny@intel.com>
 <20201009213434.GA839@sol.localdomain>
 <20201010003954.GW20115@casper.infradead.org>
 <20201010013036.GD1122@sol.localdomain>
 <20201012065635.GB2046448@iweiny-DESK2.sc.intel.com>
Message-ID: <20201012161946.GA858@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Sun, Oct 11, 2020 at 11:56:35PM -0700, Ira Weiny wrote:
> > 
> > And I still don't really understand.  After this patchset, there is still code
> > nearly identical to the above (doing a temporary mapping just for a memcpy) that
> > would still be using kmap_atomic().
> 
> I don't understand.  You mean there would be other call sites calling:
> 
> kmap_atomic()
> memcpy()
> kunmap_atomic()

Yes, there are tons of places that do this.  Try 'git grep -A6 kmap_atomic'
and look for memcpy().

Hence why I'm asking what will be the "recommended" way to do this...
kunmap_thread() or kmap_atomic()?

> And since I don't know the call site details if there are kmap_thread() calls
> which are better off as kmap_atomic() calls I think it is worth converting
> them.  But I made the assumption that kmap users would already be calling
> kmap_atomic() if they could (because it is more efficient).

Not necessarily.  In cases where either one is correct, people might not have
put much thought into which of kmap() and kmap_atomic() they are using.

- Eric
