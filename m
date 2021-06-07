From: Bhandare, KiranX <kiranx.bhandare@intel.com>
Date: Mon, 7 Jun 2021 15:32:09 +0000
Subject: [Intel-wired-lan] [PATCH v2 intel-net 2/2] ice: parametrize
 functions responsible for Tx ring management
In-Reply-To: <20210520063500.62037-3-maciej.fijalkowski@intel.com>
References: <20210520063500.62037-1-maciej.fijalkowski@intel.com>
 <20210520063500.62037-3-maciej.fijalkowski@intel.com>
Message-ID: <DM6PR11MB329297990325F28CCF5CD35DF1389@DM6PR11MB3292.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Maciej Fijalkowski
> Sent: Thursday, May 20, 2021 12:05 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: netdev at vger.kernel.org; bjorn at kernel.org; kuba at kernel.org;
> bpf at vger.kernel.org; davem at davemloft.net; Karlsson, Magnus
> <magnus.karlsson@intel.com>
> Subject: [Intel-wired-lan] [PATCH v2 intel-net 2/2] ice: parametrize functions
> responsible for Tx ring management
> 
> Commit ae15e0ba1b33 ("ice: Change number of XDP Tx queues to match
> number of Rx queues") tried to address the incorrect setting of XDP queue
> count that was based on the Tx queue count, whereas in theory we should
> provide the XDP queue per Rx queue. However, the routines that setup and
> destroy the set of Tx resources are still based on the
> vsi->num_txq.
> 
> Ice supports the asynchronous Tx/Rx queue count, so for a setup where
> vsi->num_txq > vsi->num_rxq, ice_vsi_stop_tx_rings and ice_vsi_cfg_txqs
> will be accessing the vsi->xdp_rings out of the bounds.
> 
> Parametrize two mentioned functions so they get the size of Tx resources
> array as the input.
> 
> Fixes: ae15e0ba1b33 ("ice: Change number of XDP Tx queues to match
> number of Rx queues")
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 

Tested-by: Kiran Bhandare <kiranx.bhandare@intel.com>  A Contingent Worker at Intel
