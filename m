From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 26 Sep 2018 17:08:30 +0000
Subject: [Intel-wired-lan] [PATCH v2 13/16] ice: Add more flexibility on
 how we assign an ITR index
In-Reply-To: <20180920004308.13772-14-anirudh.venkataramanan@intel.com>
References: <20180920004308.13772-1-anirudh.venkataramanan@intel.com>
 <20180920004308.13772-14-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2FC610@ORSMSX106.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Wednesday, September 19, 2018 5:43 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v2 13/16] ice: Add more flexibility on how
> we assign an ITR index
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> This issue came about when looking at the VF function
> ice_vc_cfg_irq_map_msg. Currently we are assigning the itr_setting value to
> the itr_idx received from the AVF driver, which is not correct and is not used
> for the VF flow anyway. Currently the only way we set the ITR index for both
> the PF and VF driver is by hardcoding ICE_TX_ITR or ICE_RX_ITR for the ITR
> index on each q_vector.
> 
> To fix this, add the member itr_idx in struct ice_ring_container. Thisi can then
> be used to dynamically program the correct ITR index. This change also
> affected the PF driver so make the necessary changes there as well.
> 
> Also, removed the itr_setting member in struct ice_ring because it is not
> being used meaningfully and is going to be removed in a future patch that
> includes dynamic itr.
> 
> On another note, this will be useful moving forward if we decide to split rx/tx
> rings on different q_vectors instead of sharing them as queue pairs.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
> [Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> cleaned
> up commit message]
> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c         | 73 ++++++++++++++----------
>  drivers/net/ethernet/intel/ice/ice_txrx.h        | 13 ++---
>  drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 20 ++++---
>  3 files changed, 59 insertions(+), 47 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


