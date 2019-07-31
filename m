From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 31 Jul 2019 17:33:41 +0000
Subject: [Intel-wired-lan] [PATCH S23 v4 02/15] ice: Use the software
 based tail when checking for hung Tx ring
In-Reply-To: <20190725085541.55104-2-anthony.l.nguyen@intel.com>
References: <20190725085541.55104-1-anthony.l.nguyen@intel.com>
 <20190725085541.55104-2-anthony.l.nguyen@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D40E91B@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH S23 v4 02/15] ice: Use the software based
> tail when checking for hung Tx ring
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Currently in ice_get_tx_pending we try to read a Tx ring's tail. This is then
> compared with the software based head (next_to_clean) to determine if we
> have pending work. This will never work because reading of the Tx ring's tail
> is no longer supported. Fix this by using the software based tail
> (next_to_use) to determine if there is pending work.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


