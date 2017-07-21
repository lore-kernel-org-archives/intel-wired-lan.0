From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 21 Jul 2017 18:03:21 +0000
Subject: [Intel-wired-lan] [next PATCH S77-V3 03/10] i40e: use
	separate	state bit for miscellaneous IRQ setup
In-Reply-To: <20170714132709.52657-3-alice.michael@intel.com>
References: <20170714132709.52657-1-alice.michael@intel.com>
 <20170714132709.52657-3-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DB2706@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Friday, July 14, 2017 6:27 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S77-V3 03/10] i40e: use separate state
> bit for miscellaneous IRQ setup
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> We currently (mis)use the __I40E_RECOVERY_PENDING bit to determine
> when we should actually request a new IRQ in i40e_setup_misc_vector().
> 
> This led to a design mistake where we open-coded the re-setup of the
> miscellaneous vector in i40e_resume() instead of using the function
> provided. If we did not open-code this and instead tried to use the
> i40e_setup_misc_vector() function, it would lead to never reallocating the
> IRQ.
> 
> This would lead to a second i40e_suspend() call failing to free the vector due
> to a NULL pointer dereference.
> 
> A future patch is going to re-work how the i40e_suspend() and
> i40e_resume() flows work to clear all IRQ vectors, which would require us to
> use i40e_setup_misc_vector() directly. Since during this time the
> __I40E_RECOVERY_PENDING bit is set, we'll never re-allocate the vector.
> 
> Rather than leaving the open-coded setup in i40e_resume() lets just fix the
> problem properly in i40e_setup_misc_vector().
> 
> Introduce a new state bit which indicates when the IRQ has been assigned,
> which will be set when i40e_setup_misc_vector is first called.
> This ultimately resolves the issue of re-requesting the vector, without
> overloading the __I40E_RECOVERY_PENDING state. This ensures that the
> suspend/resume cycle can use the setup function instead of open-coding
> the re-request during resume.
> 
> Additionally, since the only callers of i40e_stop_misc_vector also want to
> free it, move this code directly into the function to avoid duplication. Due to
> the new functionality, rename it to i40e_free_misc_vector().
> 
> This lets us drop the extra calls to free and re-enable the vector during
> i40e_suspend() and i40e_resume(). We don't need to call
> i40e_setup_misc_Vector() in i40e_resume() because it gets called by the
> i40e_rebuild() call.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h      |  1 +
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 39 +++++++++++---------------
> ---
>  2 files changed, 15 insertions(+), 25 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


