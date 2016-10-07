From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 7 Oct 2016 16:34:30 +0000
Subject: [Intel-wired-lan] [next PATCH S49-V2 13/15] i40e: use a
	mutex	instead of spinlock in PTP user entry points
In-Reply-To: <1475685046-16900-14-git-send-email-bimmy.pujari@intel.com>
References: <1475685046-16900-1-git-send-email-bimmy.pujari@intel.com>
 <1475685046-16900-14-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA0FBFC@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Wednesday, October 05, 2016 9:31 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S49-V2 13/15] i40e: use a mutex
> instead of spinlock in PTP user entry points
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> We need a locking mechanism to protect the hardware SYSTIME register
> which is split over 2 values, and has internal hardware latching. We can't allow
> multiple accesses at the same time. However....
> 
> The spinlock_t is overkill here, especially use of spin_lock_irqsave, since
> every PTP access will halt hardirqs. Notice that the only places which need
> the SYSTIME value are user context and are capable of sleeping.
> Thus, it is safe to use a mutex here instead of the spinlock.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Change-ID: I971761a89b58c6aad953590162e85a327fbba232
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h     |  2 +-
>  drivers/net/ethernet/intel/i40e/i40e_ptp.c | 20 +++++++-------------
>  2 files changed, 8 insertions(+), 14 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


