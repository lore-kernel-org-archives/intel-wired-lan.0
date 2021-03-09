From: Bhandare, KiranX <kiranx.bhandare@intel.com>
Date: Tue, 9 Mar 2021 14:04:04 +0000
Subject: [Intel-wired-lan] [PATCH intel-net 1/3] i40e: move headroom
 initialization to i40e_configure_rx_ring
In-Reply-To: <20210303153928.11764-2-maciej.fijalkowski@intel.com>
References: <20210303153928.11764-1-maciej.fijalkowski@intel.com>
 <20210303153928.11764-2-maciej.fijalkowski@intel.com>
Message-ID: <DM6PR11MB32923242A018780B50182999F1929@DM6PR11MB3292.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Maciej Fijalkowski
> Sent: Wednesday, March 3, 2021 9:09 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: netdev at vger.kernel.org; brouer at redhat.com; kuba at kernel.org;
> bpf at vger.kernel.org; Topel, Bjorn <bjorn.topel@intel.com>; Karlsson,
> Magnus <magnus.karlsson@intel.com>
> Subject: [Intel-wired-lan] [PATCH intel-net 1/3] i40e: move headroom
> initialization to i40e_configure_rx_ring
> 
> i40e_rx_offset(), that is supposed to initialize the Rx buffer headroom, relies
> on I40E_RXR_FLAGS_BUILD_SKB_ENABLED flag.
> 
> Currently, the callsite of mentioned function is placed incorrectly within
> i40e_setup_rx_descriptors() where Rx ring's build skb flag is not set yet. This
> causes the XDP_REDIRECT to be partially broken due to inability to create
> xdp_frame in the headroom space, as the headroom is 0.
> 
> For the record, below is the call graph:
> 
> i40e_vsi_open
>  i40e_vsi_setup_rx_resources
>   i40e_setup_rx_descriptors
>    i40e_rx_offset() <-- sets offset to 0 as build_skb flag is set below
> 
>  i40e_vsi_configure_rx
>   i40e_configure_rx_ring
>    set_ring_build_skb_enabled(ring) <-- set build_skb flag
> 
> Fix this by moving i40e_rx_offset() to i40e_configure_rx_ring() after the flag
> setting.
> 
> Fixes: f7bb0d71d658 ("i40e: store the result of i40e_rx_offset() onto
> i40e_ring")
> Reported-by: Jesper Dangaard Brouer <brouer@redhat.com>
> Co-developed-by: Jesper Dangaard Brouer <brouer@redhat.com>
> Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 13 +++++++++++++
> drivers/net/ethernet/intel/i40e/i40e_txrx.c | 12 ------------
>  2 files changed, 13 insertions(+), 12 deletions(-)
> 

Tested-by: Kiran Bhandare <kiranx.bhandare@intel.com>  A Contingent Worker at Intel
