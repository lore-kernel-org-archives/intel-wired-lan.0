From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 29 Aug 2018 18:39:02 +0000
Subject: [Intel-wired-lan] [next PATCH S96 8/9] i40evf: cancel workqueue
 sync for adminq when a VF is removed
In-Reply-To: <20180828171609.78242-8-alice.michael@intel.com>
References: <20180828171609.78242-1-alice.michael@intel.com>
 <20180828171609.78242-8-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2EB294@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Tuesday, August 28, 2018 10:16 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S96 8/9] i40evf: cancel workqueue
> sync for adminq when a VF is removed
> 
> From: Lihong Yang <lihong.yang@intel.com>
> 
> If a VF is being removed, there is no need to continue with the workqueue
> sync for the adminq task, thus cancel it. Without this call, when VFs are
> created and removed right away, there might be a chance for the driver to
> crash with events stuck in the adminq.
> 
> Signed-off-by: Lihong Yang <lihong.yang@intel.com>
> ---
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c | 2 ++
>  1 file changed, 2 insertions(+)


Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


