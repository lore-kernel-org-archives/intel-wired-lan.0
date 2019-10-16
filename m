From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 16 Oct 2019 16:18:45 +0000
Subject: [Intel-wired-lan] [PATCH S31 05/15] ice: handle DCBx
 non-contiguous TC request
In-Reply-To: <20191009140953.14087-5-anthony.l.nguyen@intel.com>
References: <20191009140953.14087-1-anthony.l.nguyen@intel.com>
 <20191009140953.14087-5-anthony.l.nguyen@intel.com>
Message-ID: <9bfaed1dfb0a404ab0b70b383c2e627b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Wednesday, October 9, 2019 7:10 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S31 05/15] ice: handle DCBx non-
> contiguous TC request
> 
> From: Paul Greenwalt <paul.greenwalt@intel.com>
> 
> If DCBx request non-contiguous TCs, then the driver will configure default
> traffic class (TC0). This is done to prevent Tx hang since the driver currently
> does not support non-contiguous TC.
> 
> Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_dcb_lib.c | 161 +++++++++++++------
>  1 file changed, 112 insertions(+), 49 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


