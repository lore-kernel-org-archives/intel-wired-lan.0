From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 8 Aug 2019 18:42:55 +0000
Subject: [Intel-wired-lan] [PATCH v3 1/1] ixgbe: sync the first fragment
 unconditionally
In-Reply-To: <20190808040312.21719-1-firo.yang@suse.com>
References: <20190808040312.21719-1-firo.yang@suse.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D40F4D7@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Firo Yang
> Sent: Wednesday, August 7, 2019 9:04 PM
> To: netdev at vger.kernel.org
> Cc: maciejromanfijalkowski at gmail.com; Firo Yang <firo.yang@suse.com>;
> linux-kernel at vger.kernel.org; intel-wired-lan at lists.osuosl.org;
> jian.w.wen at oracle.com; alexander.h.duyck at linux.intel.com;
> davem at davemloft.net
> Subject: [Intel-wired-lan] [PATCH v3 1/1] ixgbe: sync the first fragment
> unconditionally
> 
> In Xen environment, if Xen-swiotlb is enabled, ixgbe driver could possibly
> allocate a page, DMA memory buffer, for the first fragment which is not
> suitable for Xen-swiotlb to do DMA operations.
> Xen-swiotlb have to internally allocate another page for doing DMA
> operations. This mechanism requires syncing the data from the internal page
> to the page which ixgbe sends to upper network stack. However, since
> commit f3213d932173 ("ixgbe: Update driver to make use of DMA attributes
> in Rx path"), the unmap operation is performed with
> DMA_ATTR_SKIP_CPU_SYNC. As a result, the sync is not performed.
> Since the sync isn't performed, the upper network stack could receive a
> incomplete network packet. By incomplete, it means the linear data on the
> first fragment(between skb->head and skb->end) is invalid. So we have to
> copy the data from the internal xen-swiotlb page to the page which ixgbe
> sends to upper network stack through the sync operation.
> 
> More details from Alexander Duyck:
> Specifically since we are mapping the frame with
> DMA_ATTR_SKIP_CPU_SYNC we have to unmap with that as well. As a result
> a sync is not performed on an unmap and must be done manually as we
> skipped it for the first frag. As such we need to always sync before possibly
> performing a page unmap operation.
> 
> Fixes: f3213d932173 ("ixgbe: Update driver to make use of DMA attributes in
> Rx path")
> Reviewed-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> Signed-off-by: Firo Yang <firo.yang@suse.com>
> ---
> Changes from v2:
>  * Added details on the problem caused by skipping the sync.
>  * Added more explanation from Alexander Duyck.
> 
> Changes from v1:
>  * Imporved the patch description.
>  * Added Reviewed-by: and Fixes: as suggested by Alexander Duyck.
> 
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


