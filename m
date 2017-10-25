From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 25 Oct 2017 20:39:01 +0000
Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH] i40e/i40evf:
 Revert "i40e/i40evf: bump tail only in multiples of 8"
In-Reply-To: <20171022005030.19175.91947.stgit@localhost.localdomain>
References: <20171022005030.19175.91947.stgit@localhost.localdomain>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EAD639@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Saturday, October 21, 2017 5:52 PM
> To: netdev at vger.kernel.org; intel-wired-lan at lists.osuosl.org;
> akp at cohaesio.com; pstaszewski at itcare.pl
> Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH] i40e/i40evf: Revert
> "i40e/i40evf: bump tail only in multiples of 8"
> 
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> This reverts commit 11f29003d6376fb123b7c3779dba49bb56fb0815.
> 
> I am reverting this as I am fairly certain this can result in a memory leak when
> combined with the current page recycling scheme. Specifically we end up
> attempting to allocate fewer buffers than we recycled and this results in us
> rewinding the next to alloc pointer which leads to leaks when we overwrite
> the rx_buffer_info when processing the next frame.
> 
> Fixes: 11f29003d637 ("i40e/i40evf: bump tail only in multiples of 8")
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   |    9 ---------
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c |    9 ---------
>  2 files changed, 18 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


