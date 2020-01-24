From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 24 Jan 2020 23:17:10 +0000
Subject: [Intel-wired-lan] [PATCH S37 13/15] ice: Cleanup
 ice_vsi_alloc_q_vectors
In-Reply-To: <20200122152041.41498-13-anthony.l.nguyen@intel.com>
References: <20200122152041.41498-1-anthony.l.nguyen@intel.com>
 <20200122152041.41498-13-anthony.l.nguyen@intel.com>
Message-ID: <aef8833c4c3646b192e960a27766f630@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Wednesday, January 22, 2020 7:21 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S37 13/15] ice: Cleanup
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


