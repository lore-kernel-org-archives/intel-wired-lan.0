From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 26 Jul 2019 21:53:00 +0000
Subject: [Intel-wired-lan] [next PATCH S8 09/12] i40e: make
 i40e_set_mac_type() public
In-Reply-To: <20190723100144.57435-9-alice.michael@intel.com>
References: <20190723100144.57435-1-alice.michael@intel.com>
 <20190723100144.57435-9-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D40CED8@ORSMSX104.amr.corp.intel.com>
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
> Cc: Kwapulinski, Piotr <piotr.kwapulinski@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S8 09/12] i40e: make
> i40e_set_mac_type() public
> 
> From: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
> 
> Make i40e_set_mac_type() public. i40e driver requires i40e_set_mac_type()
> to be public. It is required for recovery mode handling. Without this patch
> recovery mode could not be detected in i40e_probe().
> 
> Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_common.c    | 2 +-
>  drivers/net/ethernet/intel/i40e/i40e_prototype.h | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


