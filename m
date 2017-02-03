From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 3 Feb 2017 22:52:58 +0000
Subject: [Intel-wired-lan] [next PATCH S59 4/6] i40e/i40evf: Add support
 for	mapping pages with DMA attributes
In-Reply-To: <1485808177-6333-5-git-send-email-bimmy.pujari@intel.com>
References: <1485808177-6333-1-git-send-email-bimmy.pujari@intel.com>
 <1485808177-6333-5-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA5DC20@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Monday, January 30, 2017 12:30 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S59 4/6] i40e/i40evf: Add support for
> mapping pages with DMA attributes
> 
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> This patch adds support for DMA_ATTR_SKIP_CPU_SYNC and
> DMA_ATTR_WEAK_ORDERING. By enabling both of these for the Rx path we
> are able to see performance improvements on architectures that implement
> either one due to the fact that page mapping and unmapping only has to
> sync what is actually being used instead of the entire buffer. In addition by
> enabling the weak ordering attribute enables a performance improvement
> for architectures that can associate a memory ordering with a DMA buffer
> such as Sparc.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> Change-ID: If176824e8231c5b24b8a5d55b339a6026738fc75
> ---
> Testing Hints: Changes would only be visible with SPARC platforms or
>                systems with swiotlb=force enabled. Even then the actual
>                effect should be minimal. Mainly we just need to verify
>                that on kernels 4.10 and newer we are still able to
>                receive traffic without any issues.
> 
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 31
> ++++++++++++++++++++++-----
>  drivers/net/ethernet/intel/i40e/i40e_txrx.h   |  3 +++
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 31
> ++++++++++++++++++++++-----
> drivers/net/ethernet/intel/i40evf/i40e_txrx.h |  3 +++
>  4 files changed, 58 insertions(+), 10 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


