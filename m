From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 28 Aug 2019 17:05:10 +0000
Subject: [Intel-wired-lan] [PATCH S28 7/9] ice: Minor refactor in queue
 management
In-Reply-To: <20190827131354.12703-7-anthony.l.nguyen@intel.com>
References: <20190827131354.12703-1-anthony.l.nguyen@intel.com>
 <20190827131354.12703-7-anthony.l.nguyen@intel.com>
Message-ID: <8d3c2c59f2b54c61ae0d9fd29fed29ef@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Tuesday, August 27, 2019 6:14 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S28 7/9] ice: Minor refactor in queue
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
>  drivers/net/ethernet/intel/ice/ice.h          |  2 -
>  drivers/net/ethernet/intel/ice/ice_lib.c      | 75 ++++++++++++++++---
>  drivers/net/ethernet/intel/ice/ice_lib.h      |  6 ++
>  drivers/net/ethernet/intel/ice/ice_main.c     | 29 -------
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 14 ++--
>  5 files changed, 78 insertions(+), 48 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


