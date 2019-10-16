From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 16 Oct 2019 16:24:47 +0000
Subject: [Intel-wired-lan] [PATCH S31 14/15] ice: Rename VF function
 ice_vc_dis_vf to match its behavior
In-Reply-To: <20191009140953.14087-14-anthony.l.nguyen@intel.com>
References: <20191009140953.14087-1-anthony.l.nguyen@intel.com>
 <20191009140953.14087-14-anthony.l.nguyen@intel.com>
Message-ID: <15aeec78607c4fbb9385309f30825d04@intel.com>
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
> Subject: [Intel-wired-lan] [PATCH S31 14/15] ice: Rename VF function
> ice_vc_dis_vf to match its behavior
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> ice_vc_dis_vf() tells iavf that it's going to perform a reset and then performs
> a software reset. This is misleading based on the function name because the
> VF does not get disabled. So fix this by changing the name to
> ice_vc_reset_vf().
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


