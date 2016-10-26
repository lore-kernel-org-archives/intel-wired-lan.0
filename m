From: Jesper Dangaard Brouer <brouer@redhat.com>
Date: Wed, 26 Oct 2016 17:45:42 +0200
Subject: [Intel-wired-lan] [net-next PATCH 00/27] Add support for DMA
 writable pages being writable by the network stack
In-Reply-To: <20161025153220.4815.61239.stgit@ahduyck-blue-test.jf.intel.com>
References: <20161025153220.4815.61239.stgit@ahduyck-blue-test.jf.intel.com>
Message-ID: <20161026174542.334798db@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 25 Oct 2016 11:36:48 -0400
Alexander Duyck <alexander.h.duyck@intel.com> wrote:

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

I really appreciate you are doing this work Alex, thanks! And I do
think it fits into my page pool plans. Thanks!

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  Author of http://www.iptv-analyzer.org
  LinkedIn: http://www.linkedin.com/in/brouer
