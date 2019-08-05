From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 5 Aug 2019 21:32:50 +0000
Subject: [Intel-wired-lan] [PATCH S26 01/15] ice: add support for
 enabling/disabling single queues
In-Reply-To: <20190802082533.23083-1-anthony.l.nguyen@intel.com>
References: <20190802082533.23083-1-anthony.l.nguyen@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D40F064@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Friday, August 2, 2019 1:25 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S26 01/15] ice: add support for
> enabling/disabling single queues
> 
> From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> 
> Refactor the queue handling functions that are going through queue arrays in
> a way that the logic done for a single queue is pulled out and it will be called
> for each ring when traversing ring array. This implies that when disabling Tx
> rings we won't fill up q_ids, q_teids and q_handles arrays.  Drop also 'offset'
> parameter; the value from vsi's txq_map is stored in ring->reg_idx and that
> drops the need for mentioned parameter. Introduce the ice_vsi_cfg_txq,
> ice_vsi_stop_tx_ring and ice_vsi_ctrl_rx_ring that are the functions with
> pulled out logic.
> 
> There's several Tx queue meta data (q_id, q_handle, q_teid and other) that
> need to be set up during Tx queue disablement, so let's as well add a helper
> structure that wraps it up and a function that will be filling it up.
> 
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c | 340 +++++++++++++----------
> drivers/net/ethernet/intel/ice/ice_lib.h |  18 +-
>  2 files changed, 213 insertions(+), 145 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


