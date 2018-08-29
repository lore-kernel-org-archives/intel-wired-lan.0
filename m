From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 29 Aug 2018 18:14:04 +0000
Subject: [Intel-wired-lan] [next PATCH S96 3/9] i40e: hold the rtnl lock
 on clearing interrupt scheme
In-Reply-To: <20180828171609.78242-3-alice.michael@intel.com>
References: <20180828171609.78242-1-alice.michael@intel.com>
 <20180828171609.78242-3-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2EB23E@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH S96 3/9] i40e: hold the rtnl lock on
> clearing interrupt scheme
> 
> From: Patryk Ma?ek <patryk.malek@intel.com>
> 
> Hold the rtnl lock when we're clearing interrupt scheme in i40e_shutdown
> and in i40e_remove.
> 
> Signed-off-by: Patryk Ma?ek <patryk.malek@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


