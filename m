From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 31 Oct 2018 16:28:13 +0000
Subject: [Intel-wired-lan] [next PATCH S98 6/6] i40e: suppress bogus
 error message
In-Reply-To: <20181026213333.51495-6-alice.michael@intel.com>
References: <20181026213333.51495-1-alice.michael@intel.com>
 <20181026213333.51495-6-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D328FC7@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Friday, October 26, 2018 2:34 PM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S98 6/6] i40e: suppress bogus error
> message
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> The i40e driver complains about unprivileged VFs trying to configure
> promiscuous mode each time a VF reset occurs. This isn't the fault of the
> poor VF driver - the PF driver itself is making the request.
> 
> To fix this, skip the privilege check if the request is to disable all promiscuous
> activity. This gets rid of the bogus message, but doesn't affect privilege
> checks, since we really only care if the unprivileged VF is trying to enable
> promiscuous mode.
> 
> Testing Hints (required if no HSD): watch dmesg log while VF resets occur.
> You can trigger a VFR by unloading i40evf or shutting down the VM with an
> assigned VF.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


