From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 7 Nov 2019 18:38:23 +0000
Subject: [Intel-wired-lan] [PATCH S32 v3 08/15] ice: Change max MSI-x
 vector_id check in cfg_irq_map
In-Reply-To: <20191106100541.48639-8-anthony.l.nguyen@intel.com>
References: <20191106100541.48639-1-anthony.l.nguyen@intel.com>
 <20191106100541.48639-8-anthony.l.nguyen@intel.com>
Message-ID: <1998cf8653124e3a984a761edb115e2d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Wednesday, November 6, 2019 2:06 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S32 v3 08/15] ice: Change max MSI-x
> vector_id check in cfg_irq_map
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Currently we check to make sure the vector_id passed down from iavf is less
> than or equal to pf->hw.func_caps.common_caps.num_msix_vectors.
> This is incorrect because the vector_id is always 0-based and never greater
> than or equal to the ICE_MAX_INTR_PER_VF. Fix this by checking to make
> sure the vector_id is less than the max allowed interrupts per VF
> (ICE_MAX_INTR_PER_VF).
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


