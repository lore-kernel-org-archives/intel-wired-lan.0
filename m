From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 31 Jul 2019 17:40:40 +0000
Subject: [Intel-wired-lan] [PATCH S23 v4 15/15] ice: improve print for
 VF's when adding/deleting MAC filters
In-Reply-To: <20190725085541.55104-15-anthony.l.nguyen@intel.com>
References: <20190725085541.55104-1-anthony.l.nguyen@intel.com>
 <20190725085541.55104-15-anthony.l.nguyen@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D40E9EE@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Thursday, July 25, 2019 1:56 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S23 v4 15/15] ice: improve print for VF's
> when adding/deleting MAC filters
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> When we fail to add/delete MAC filters in the VF, the print doesn't
> distinguish between the two. Fix that by printing whether or not we failed to
> add/delete the MAC filter respectively.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


