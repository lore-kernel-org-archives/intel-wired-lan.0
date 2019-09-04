From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 4 Sep 2019 22:27:23 +0000
Subject: [Intel-wired-lan] [PATCH S28 v2 7/9] ice: Minor refactor in
 queue management
In-Reply-To: <20190903083108.19593-7-anthony.l.nguyen@intel.com>
References: <20190903083108.19593-1-anthony.l.nguyen@intel.com>
 <20190903083108.19593-7-anthony.l.nguyen@intel.com>
Message-ID: <0d8f7deee7f24e429b6dcb900058c56b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Tuesday, September 3, 2019 1:31 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S28 v2 7/9] ice: Minor refactor in queue
> management
> 
> From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
> 
> Remove q_left_tx and q_left_rx from the PF struct as these can be obtained
> by calling ice_get_avail_txq_count and ice_get_avail_rxq_count respectively.
> 
> The function ice_determine_q_usage is only setting num_lan_tx and
> num_lan_rx in the PF structure, and these are later assigned to
> vsi->alloc_txq and vsi->alloc_rxq respectively. This is an unnecessary
> indirection, so remove ice_determine_q_usage and just assign values for vsi-
> >alloc_txq and vsi->alloc_rxq in ice_vsi_set_num_qs and use these to set
> num_lan_tx and num_lan_rx respectively.
> 
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
> v2:
> Move ice_get_avail_txq_count() and ice_get_avail_rxq_count() to
> ice_main.c to avoid static namespace issues
> ---
>  drivers/net/ethernet/intel/ice/ice.h          |  4 +-
>  drivers/net/ethernet/intel/ice/ice_lib.c      | 25 ++++++----
>  drivers/net/ethernet/intel/ice/ice_main.c     | 50 +++++++++++--------
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 14 +++---
>  4 files changed, 54 insertions(+), 39 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


