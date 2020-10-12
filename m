From: Dave Hansen <dave.hansen@intel.com>
Date: Mon, 12 Oct 2020 09:28:29 -0700
Subject: [Intel-wired-lan] [PATCH RFC PKS/PMEM 22/58] fs/f2fs: Utilize
 new kmap_thread()
In-Reply-To: <20201012161946.GA858@sol.localdomain>
References: <20201009195033.3208459-1-ira.weiny@intel.com>
 <20201009195033.3208459-23-ira.weiny@intel.com>
 <20201009213434.GA839@sol.localdomain>
 <20201010003954.GW20115@casper.infradead.org>
 <20201010013036.GD1122@sol.localdomain>
 <20201012065635.GB2046448@iweiny-DESK2.sc.intel.com>
 <20201012161946.GA858@sol.localdomain>
Message-ID: <5d621db9-23d4-e140-45eb-d7fca2093d2b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 10/12/20 9:19 AM, Eric Biggers wrote:
> On Sun, Oct 11, 2020 at 11:56:35PM -0700, Ira Weiny wrote:
>>> And I still don't really understand.  After this patchset, there is still code
>>> nearly identical to the above (doing a temporary mapping just for a memcpy) that
>>> would still be using kmap_atomic().
>> I don't understand.  You mean there would be other call sites calling:
>>
>> kmap_atomic()
>> memcpy()
>> kunmap_atomic()
> Yes, there are tons of places that do this.  Try 'git grep -A6 kmap_atomic'
> and look for memcpy().
> 
> Hence why I'm asking what will be the "recommended" way to do this...
> kunmap_thread() or kmap_atomic()?

kmap_atomic() is always preferred over kmap()/kmap_thread().
kmap_atomic() is _much_ more lightweight since its TLB invalidation is
always CPU-local and never broadcast.

So, basically, unless you *must* sleep while the mapping is in place,
kmap_atomic() is preferred.

