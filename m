From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 29 Aug 2018 18:39:32 +0000
Subject: [Intel-wired-lan] [next PATCH S96 9/9] i40e: Prevent deleting
 MAC address from VF when set by PF
In-Reply-To: <20180828171609.78242-9-alice.michael@intel.com>
References: <20180828171609.78242-1-alice.michael@intel.com>
 <20180828171609.78242-9-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2EB2A0@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH S96 9/9] i40e: Prevent deleting MAC
> address from VF when set by PF
> 
> From: Patryk Ma?ek <patryk.malek@intel.com>
> 
> To prevent VF from deleting MAC address that was assigned by the PF we
> need to check for that scenario when we try to delete a MAC address from a
> VF.
> 
> Signed-off-by: Patryk Ma?ek <patryk.malek@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
