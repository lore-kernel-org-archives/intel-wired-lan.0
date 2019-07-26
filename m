From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 26 Jul 2019 21:53:53 +0000
Subject: [Intel-wired-lan] [next PATCH S8 11/12] i40e: Persistent lldp
 support
In-Reply-To: <20190723100144.57435-11-alice.michael@intel.com>
References: <20190723100144.57435-1-alice.michael@intel.com>
 <20190723100144.57435-11-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D40CEF8@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Tuesday, July 23, 2019 3:02 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Wnuczko, Sylwia <sylwia.wnuczko@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S8 11/12] i40e: Persistent lldp support
> 
> From: Sylwia Wnuczko <sylwia.wnuczko@intel.com>
> 
> This patch adds a function to read nvm module data and uses it to read
> current lldp agent configuration from nvm api version 1.8.
> 
> Title: i40e-shared: Persistent lldp support
> Change-type: FeatureImplementation
> 
> Signed-off-by: Sylwia Wnuczko <sylwia.wnuczko@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_dcb.c    |  18 +++-
>  drivers/net/ethernet/intel/i40e/i40e_dcb.h    |   2 +
>  drivers/net/ethernet/intel/i40e/i40e_nvm.c    | 101 ++++++++++++++++++
>  .../net/ethernet/intel/i40e/i40e_prototype.h  |   6 ++
>  drivers/net/ethernet/intel/i40e/i40e_type.h   |   1 +
>  5 files changed, 127 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


