From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 28 Oct 2016 08:48:01 -0700
Subject: [Intel-wired-lan] [net-next PATCH 00/27] Add support for DMA
 writable pages being writable by the network stack
In-Reply-To: <20161025153220.4815.61239.stgit@ahduyck-blue-test.jf.intel.com>
References: <20161025153220.4815.61239.stgit@ahduyck-blue-test.jf.intel.com>
Message-ID: <CAKgT0UfOZuRnon84_8Bdn5muoi7=Xrwd7Kbxi4C8jiXpyX7-gg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Oct 25, 2016 at 8:36 AM, Alexander Duyck
<alexander.h.duyck@intel.com> wrote:
> The first 22 patches in the set add support for the DMA attribute
> DMA_ATTR_SKIP_CPU_SYNC on multiple platforms/architectures.  This is needed
> so that we can flag the calls to dma_map/unmap_page so that we do not
> invalidate cache lines that do not currently belong to the device.  Instead
> we have to take care of this in the driver via a call to
> sync_single_range_for_cpu prior to freeing the Rx page.
>
> Patch 23 adds support for dma_map_page_attrs and dma_unmap_page_attrs so
> that we can unmap and map a page using the DMA_ATTR_SKIP_CPU_SYNC
> attribute.
>
> Patch 24 adds support for freeing a page that has multiple references being
> held by a single caller.  This way we can free page fragments that were
> allocated by a given driver.
>
> The last 3 patches use these updates in the igb driver to allow for us to
> reimpelement the use of build_skb.
>
> My hope is to get the series accepted into the net-next tree as I have a
> number of other Intel drivers I could then begin updating once these
> patches are accepted.
>
> v1: Split out changes DMA_ERROR_CODE fix for swiotlb-xen
>     Minor fixes based on issues found by kernel build bot
>     Few minor changes for issues found on code review
>     Added Acked-by for patches that were acked and not changed

So the feedback for this set has been mostly just a few "Acked-by"s,
and it looks like the series was marked as "Not Applicable" in
patchwork.  I was wondering what the correct merge strategy for this
patch set should be going forward?

I was wondering if I should be looking at breaking up the set and
splitting it over a few different trees, or if I should just hold onto
it and resubmit it when the merge window opens?  My preference would
be to submit it as a single set so I can know all the patches are
present to avoid any possible regressions due to only part of the set
being present.

Anyway, I am just trying to figure out how best to proceed from here
since these patch sets that touch multiple areas are always
complicated to get submitted.

Thanks.

- Alex
