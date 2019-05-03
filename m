From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 3 May 2019 23:35:00 +0000
Subject: [Intel-wired-lan] [next PATCH S5 02/10] i40e: add constraints
 for accessing veb array
In-Reply-To: <20190424122055.27896-2-alice.michael@intel.com>
References: <20190424122055.27896-1-alice.michael@intel.com>
 <20190424122055.27896-2-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D39C68F@ORSMSX106.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Wednesday, April 24, 2019 5:21 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Kwapulinski, Piotr <piotr.kwapulinski@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S5 02/10] i40e: add constraints for
> accessing veb array
> 
> From: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
> 
> Add veb array access boundary checks.
> Ensure veb array index is smaller than I40E_MAX_VEB.
> 
> Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


