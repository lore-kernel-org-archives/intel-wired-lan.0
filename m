From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 13 Aug 2019 17:12:22 +0000
Subject: [Intel-wired-lan] [PATCH S27 09/15] ice: Minor refactor in
 queue management
In-Reply-To: <20190808143938.4968-9-anthony.l.nguyen@intel.com>
References: <20190808143938.4968-1-anthony.l.nguyen@intel.com>
 <20190808143938.4968-9-anthony.l.nguyen@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D411666@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Thursday, August 8, 2019 7:40 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S27 09/15] ice: Minor refactor in queue
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
>  drivers/net/ethernet/intel/ice/ice_lib.c      | 82 +++++++++++++++----
>  drivers/net/ethernet/intel/ice/ice_lib.h      |  6 ++
>  drivers/net/ethernet/intel/ice/ice_main.c     | 29 -------
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 14 ++--
>  5 files changed, 82 insertions(+), 51 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


