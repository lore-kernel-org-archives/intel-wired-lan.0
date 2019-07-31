From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 31 Jul 2019 17:34:11 +0000
Subject: [Intel-wired-lan] [PATCH S23 v4 03/15] ice: Assume that more
 than one Rx queue is rare in ice_napi_poll
In-Reply-To: <20190725085541.55104-3-anthony.l.nguyen@intel.com>
References: <20190725085541.55104-1-anthony.l.nguyen@intel.com>
 <20190725085541.55104-3-anthony.l.nguyen@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D40E92A@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Thursday, July 25, 2019 1:55 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S23 v4 03/15] ice: Assume that more than
> one Rx queue is rare in ice_napi_poll
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Currently we divide budget by the number of Rx queues per Rx ring
> container in ice_napi_poll even if there is only 1. This is an unnecessary divide
> for the normal case of 1 Rx ring per Rx ring container. Fix this by using an
> unlikely() call in the case where we actually need to divide.
> 
> Also, we will always set budget_per_ring even if there are no Rx rings in the
> Rx ring container so we don't need to initialize it to 0.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_txrx.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


