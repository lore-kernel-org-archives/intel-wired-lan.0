From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 31 Jul 2019 17:40:11 +0000
Subject: [Intel-wired-lan] [PATCH S23 v4 14/15] ice: Change type for
 queue counts
In-Reply-To: <20190725085541.55104-14-anthony.l.nguyen@intel.com>
References: <20190725085541.55104-1-anthony.l.nguyen@intel.com>
 <20190725085541.55104-14-anthony.l.nguyen@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D40E9DE@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH S23 v4 14/15] ice: Change type for queue
> counts
> 
> From: Pawel Kaminski <pawel.kaminski@intel.com>
> 
> These queue variables are being assigned values that are type u16.
> Change the local variables to match these types. Since these represent
> queue counts, they should never be negative.
> 
> Signed-off-by: Pawel Kaminski <pawel.kaminski@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
> v3: Change type back to u16
>     Fix format specifiers and min_t type
>     Redo commit message
> 
> v2: Change type from u16 to unsigned int
>     Reword commit message
> ---
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 25 ++++++++++---------
>  1 file changed, 13 insertions(+), 12 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


