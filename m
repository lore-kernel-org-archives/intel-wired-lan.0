From: Bhandare, KiranX <kiranx.bhandare@intel.com>
Date: Tue, 9 Mar 2021 14:02:54 +0000
Subject: [Intel-wired-lan] [PATCH intel-net 2/3] ice: move headroom
 initialization to ice_setup_rx_ctx
In-Reply-To: <20210303153928.11764-3-maciej.fijalkowski@intel.com>
References: <20210303153928.11764-1-maciej.fijalkowski@intel.com>
 <20210303153928.11764-3-maciej.fijalkowski@intel.com>
Message-ID: <DM6PR11MB32927310973DCB896EF9E2AFF1929@DM6PR11MB3292.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH intel-net 2/3] ice: move headroom
> initialization to ice_setup_rx_ctx
> 
> ice_rx_offset(), that is supposed to initialize the Rx buffer headroom, relies
> on ICE_RX_FLAGS_RING_BUILD_SKB flag as well as XDP prog presence.
> 
> Currently, the callsite of mentioned function is placed incorrectly within
> ice_setup_rx_ring() where Rx ring's build skb flag is not set yet. This causes
> the XDP_REDIRECT to be partially broken due to inability to create xdp_frame
> in the headroom space, as the headroom is 0.
> 
> Fix this by moving ice_rx_offset() to ice_setup_rx_ctx() after the flag setting.
> 
> Fixes: f1b1f409bf79 ("ice: store the result of ice_rx_offset() onto ice_ring")
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_base.c | 18 ++++++++++++++++++
> drivers/net/ethernet/intel/ice/ice_txrx.c | 17 -----------------
>  2 files changed, 18 insertions(+), 17 deletions(-)
> 

Tested-by: Kiran Bhandare <kiranx.bhandare@intel.com>  A Contingent Worker at Intel
