From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 7 Jan 2016 22:37:58 +0000
Subject: [Intel-wired-lan] [next PATCH S26 03/12] i40e: fix bug in dma
 sync
In-Reply-To: <1451932392-15538-4-git-send-email-deepthi.kavalur@intel.com>
References: <1451932392-15538-1-git-send-email-deepthi.kavalur@intel.com>
 <1451932392-15538-4-git-send-email-deepthi.kavalur@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F97E5F6@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Deepthi Kavalur
> Sent: Monday, January 04, 2016 10:33 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S26 03/12] i40e: fix bug in dma sync
> 
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> Driver was using an offset based off a dma handle while mapping and
> unmapping using sync_single_range_for[cpu|device], where it should be
> using dma handle (returned from alloc_coherent) and the offset of the
> memory to be sync'd.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Reviewed-by: Nelson, Shannon <shannon.nelson@intel.com>
> Reviewed-by: Williams, Mitch A <mitch.a.williams@intel.com>
> Change-ID: I208256565b1595ff0e9171ab852de06b997917c6
> ---
> Testing-Hints:
> Test traffic, test with DMA API debugging enabled.
> 
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 8 ++++----
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 8 ++++----
>  2 files changed, 8 insertions(+), 8 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied, no dma errors recorded
