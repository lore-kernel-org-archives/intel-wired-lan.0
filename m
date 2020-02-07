From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 7 Feb 2020 22:35:21 +0000
Subject: [Intel-wired-lan] [PATCH S37 v3 13/15] ice: Cleanup
 ice_vsi_alloc_q_vectors
In-Reply-To: <20200206092013.23388-13-anthony.l.nguyen@intel.com>
References: <20200206092013.23388-1-anthony.l.nguyen@intel.com>
 <20200206092013.23388-13-anthony.l.nguyen@intel.com>
Message-ID: <27d7f2dc2e0e4a6d9104ee88a0aa29ec@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Thursday, February 6, 2020 1:20 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S37 v3 13/15] ice: Cleanup
> ice_vsi_alloc_q_vectors
> 
> From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
> 
> 1. Remove local variable num_q_vectors and use vsi->num_q_vectors
> instead 2. Remove local variable pf and pass vsi->back to ice_pf_to_dev
> 
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_base.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


