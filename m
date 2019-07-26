From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 26 Jul 2019 21:54:41 +0000
Subject: [Intel-wired-lan] [next PATCH S8 12/12] i40e: fix retrying in
 i40e_aq_get_phy_capabilities
In-Reply-To: <20190723100144.57435-12-alice.michael@intel.com>
References: <20190723100144.57435-1-alice.michael@intel.com>
 <20190723100144.57435-12-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D40CF0A@ORSMSX104.amr.corp.intel.com>
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
> Cc: Formela, Marcin <marcin.formela@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S8 12/12] i40e: fix retrying in
> i40e_aq_get_phy_capabilities
> 
> From: Marcin Formela <marcin.formela@intel.com>
> 
> Fixed a bug where driver was breaking out of the loop and reporting an error
> without retrying first.
> 
> Signed-off-by: Marcin Formela <marcin.formela@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_common.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


