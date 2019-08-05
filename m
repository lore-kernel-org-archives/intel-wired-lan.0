From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 5 Aug 2019 21:34:32 +0000
Subject: [Intel-wired-lan] [PATCH S26 04/15] ice: Fix VF configuration
 issues due to reset
In-Reply-To: <20190802082533.23083-4-anthony.l.nguyen@intel.com>
References: <20190802082533.23083-1-anthony.l.nguyen@intel.com>
 <20190802082533.23083-4-anthony.l.nguyen@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D40F097@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Friday, August 2, 2019 1:25 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S26 04/15] ice: Fix VF configuration issues
> due to reset
> 
> From: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
> 
> This patch fixes a critical reset issue that resulting to the server reboot when
> an Admin changes VF configuration on the host, for example changing VF to
> Trusted/non_Trusted mode, the PF driver send reset notification to AVF
> driver while also continue with reset flow. However, AVF driver schedule
> another reset due to notification, which causes two concurrent reset going
> on, and trigger lock up in the FW, with AQ call to delete VSI.
> 
> Signed-off-by: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


