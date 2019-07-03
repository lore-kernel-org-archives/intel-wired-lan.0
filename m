From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 3 Jul 2019 18:20:35 +0000
Subject: [Intel-wired-lan] [PATCH S23 v2 14/15] ice: Change type for
 queue counts
In-Reply-To: <20190628150348.59202-1-anthony.l.nguyen@intel.com>
References: <20190628150348.59202-1-anthony.l.nguyen@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D3FD1B3@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Friday, June 28, 2019 8:04 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: pmenzel at molgen.mpg.de
> Subject: [Intel-wired-lan] [PATCH S23 v2 14/15] ice: Change type for queue
> counts
> 
> From: Pawel Kaminski <pawel.kaminski@intel.com>
> 
> A negative queue count should never exist, change the type to unsigned to
> convey that.
> 
> Signed-off-by: Pawel Kaminski <pawel.kaminski@intel.com>
> ---
> v2: Change type from u16 to unsigned int
>     Reword commit message
> 
>  drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


