From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 31 Oct 2017 19:06:38 +0000
Subject: [Intel-wired-lan] [next PATCH S81-V3 7/9] i40e: add
	helper	conversion function for link_speed
In-Reply-To: <20171027150656.68250-7-alice.michael@intel.com>
References: <20171027150656.68250-1-alice.michael@intel.com>
 <20171027150656.68250-7-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EADD73@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Friday, October 27, 2017 8:07 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S81-V3 7/9] i40e: add helper
> conversion function for link_speed
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> We introduced the virtchnl interface in order to have an interface for talking
> to a virtual device driver which was host-driver agnostic. This interface has its
> own definitions, including one for link speed.
> 
> The host driver has to talk to the virtchnl interface using these new
> definitions in order to remain compatible. Today, the i40e link_speed
> enumerations are value-exact matches for the virtchnl interface, so it was
> originally decided to simply use a typecast.
> 
> However, this is unsafe, and makes it easier for future drivers to continue
> this unsafe practice. There is nothing guaranteeing these values are exact,
> and the type-cast would hide any compiler warning which indicates the
> problem.
> 
> Rather than rely on this type cast, introduce a helper function which can
> convert the AdminQ link speed definition into a virtchnl definition. This can
> then be used by host driver implementations in order to safely convert to
> the interface recognized by the virtual functions.
> 
> If the link speed is not able to be represented by the virtchnl definitions we'll
> report UNKNOWN which is the safest result.
> 
> This will ensure that should the driver specific link_speeds actual bit
> definitions change, we do not report them incorrectly according to the VF.
> 
> Additionally, this provides a better pattern for future drivers to copy, as it is
> more likely a future device may not use the exact same bit-wise definition as
> the current virtchnl interface.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_prototype.h   | 31
> ++++++++++++++++++++++
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  4 +--
>  2 files changed, 33 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


