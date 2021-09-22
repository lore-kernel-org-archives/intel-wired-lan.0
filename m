From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Wed, 22 Sep 2021 18:28:07 +0000
Subject: [Intel-wired-lan] [PATCH v7 intel-next 3/9] ice: split ice_ring
 onto Tx/Rx separate structs
In-Reply-To: <20210819120004.34392-4-maciej.fijalkowski@intel.com>
References: <20210819120004.34392-1-maciej.fijalkowski@intel.com>
 <20210819120004.34392-4-maciej.fijalkowski@intel.com>
Message-ID: <BL0PR11MB336312F04BF37B31B133B8DBFCA29@BL0PR11MB3363.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Maciej Fijalkowski
> Sent: Thursday, August 19, 2021 5:30 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: joamaki at gmail.com; Lobakin, Alexandr <alexandr.lobakin@intel.com>;
> netdev at vger.kernel.org; toke at redhat.com; bjorn at kernel.org;
> kuba at kernel.org; bpf at vger.kernel.org; davem at davemloft.net; Karlsson,
> Magnus <magnus.karlsson@intel.com>
> Subject: [Intel-wired-lan] [PATCH v7 intel-next 3/9] ice: split ice_ring onto
> Tx/Rx separate structs
> 
> While it was convenient to have a generic ring structure that served
> both Tx and Rx sides, next commits are going to introduce several
> Tx-specific fields, so in order to avoid hurting the Rx side, let's
> pull out the Tx ring onto new ice_tx_ring and ice_rx_ring structs.
> 
> Rx ring could be handled by the old ice_ring which would reduce the code
> churn within this patch, but this would make things asymmetric.
> 
> Make the union out of the ring container within ice_q_vector so that it
> is possible to iterate over newly introduced ice_tx_ring.
> 
> Remove the @size as it's only accessed from control path and it can be
> calculated pretty easily.
> 
> Change definitions of ice_update_ring_stats and
> ice_fetch_u64_stats_per_ring so that they are ring agnostic and can be
> used for both Rx and Tx rings.
> 
> Sizes of Rx and Tx ring structs are 256 and 192 bytes, respectively. In
> Rx ring xdp_rxq_info occupies its own cacheline, so it's the major
> difference now.
> 
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h          |  33 +++--
>  drivers/net/ethernet/intel/ice/ice_base.c     |  57 ++++----
>  drivers/net/ethernet/intel/ice/ice_base.h     |   8 +-
>  drivers/net/ethernet/intel/ice/ice_dcb_lib.c  |   5 +-
>  drivers/net/ethernet/intel/ice/ice_dcb_lib.h  |  10 +-
>  drivers/net/ethernet/intel/ice/ice_eswitch.c  |  35 ++---
>  drivers/net/ethernet/intel/ice/ice_eswitch.h  |   4 +-
>  drivers/net/ethernet/intel/ice/ice_ethtool.c  |  49 ++++---
>  drivers/net/ethernet/intel/ice/ice_lib.c      |  64 +++++----
>  drivers/net/ethernet/intel/ice/ice_lib.h      |   6 +-
>  drivers/net/ethernet/intel/ice/ice_main.c     |  69 +++++----
>  drivers/net/ethernet/intel/ice/ice_ptp.c      |   2 +-
>  drivers/net/ethernet/intel/ice/ice_ptp.h      |   4 +-
>  drivers/net/ethernet/intel/ice/ice_trace.h    |  28 ++--
>  drivers/net/ethernet/intel/ice/ice_txrx.c     | 131 ++++++++++--------
>  drivers/net/ethernet/intel/ice/ice_txrx.h     | 114 +++++++++------
>  drivers/net/ethernet/intel/ice/ice_txrx_lib.c |  18 +--
>  drivers/net/ethernet/intel/ice/ice_txrx_lib.h |  14 +-
>  .../net/ethernet/intel/ice/ice_virtchnl_pf.c  |   2 +-
>  drivers/net/ethernet/intel/ice/ice_xsk.c      |  49 ++++---
>  drivers/net/ethernet/intel/ice/ice_xsk.h      |  20 +--
>  21 files changed, 397 insertions(+), 325 deletions(-)
> 

Tested-by: Gurucharan G <gurucharanx.g@intel.com> (A Contingent worker at Intel)
