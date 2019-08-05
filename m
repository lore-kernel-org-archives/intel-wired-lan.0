From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 5 Aug 2019 21:37:45 +0000
Subject: [Intel-wired-lan] [PATCH S26 09/15] ice: Report what the user
 set for coalesce [tx|rx]-usecs
In-Reply-To: <20190802082533.23083-9-anthony.l.nguyen@intel.com>
References: <20190802082533.23083-1-anthony.l.nguyen@intel.com>
 <20190802082533.23083-9-anthony.l.nguyen@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D40F0E7@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH S26 09/15] ice: Report what the user set for
> coalesce [tx|rx]-usecs
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Currently if the user sets an odd value for [tx|rx]-usecs we align the value
> because the hardware only understands ITR values in multiples of 2. This
> seems misleading because we are essentially telling the user that the ITR
> value is odd, when in fact we have changed it internally.
> Fix this by reporting that setting odd ITR values is not allowed.
> 
> Also, while making changes to ice_set_rc_coalesce() I noticed a bit of
> code/error duplication. Make the necessary changes to remove the
> duplication.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_ethtool.c | 88 ++++++++++----------
>  1 file changed, 44 insertions(+), 44 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


