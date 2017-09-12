From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 12 Sep 2017 21:40:39 +0000
Subject: [Intel-wired-lan] [next PATCH S80-V3 06/11] i40e/i40evf: bump
 tail	only in multiples of 8
In-Reply-To: <20170907120556.45699-6-alice.michael@intel.com>
References: <20170907120556.45699-1-alice.michael@intel.com>
 <20170907120556.45699-6-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EAA0EA@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Thursday, September 7, 2017 5:06 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S80-V3 06/11] i40e/i40evf: bump tail
> only in multiples of 8
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> Hardware only fetches descriptors on cachelines of 8, essentially ignoring the
> lower 3 bits of the tail register. Thus, it is pointless to bump tail by an
> unaligned access as the hardware will ignore some of the new descriptors we
> allocated. Thus, it's ideal if we can ensure tail writes are always aligned to 8.
> 
> At first, it seems like we'd already do this, since we allocate descriptors in
> batches which are a multiple of 8. Since we'd always increment by a multiple
> of 8, it seems like the value should always be aligned.
> 
> However, this ignores allocation failures. If we fail to allocate a buffer, our tail
> register will become unaligned. Once it has become unaligned it will
> essentially be stuck unaligned until a buffer allocation happens to fail at the
> exact amount necessary to re-align it.
> 
> We can do better, by simply rounding down the number of buffers we're
> about to allocate (cleaned_count) such that "next_to_clean
> + cleaned_count" is rounded to the nearest multiple of 8.
> 
> We do this by calculating how far off that value is and subtracting it from the
> cleaned_count. This essentially defers allocation of buffers if they're going to
> be ignored by hardware anyways, and re-aligns our next_to_use and tail
> values after a failure to allocate a descriptor.
> 
> This calculation ensures that we always align the tail writes in a way the
> hardware expects and don't unnecessarily allocate buffers which won't be
> fetched immediately.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 9 +++++++++
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 9 +++++++++
>  2 files changed, 18 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


