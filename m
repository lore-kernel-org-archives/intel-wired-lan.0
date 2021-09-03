From: Kuruvinakunnel, George <george.kuruvinakunnel@intel.com>
Date: Fri, 3 Sep 2021 06:45:30 +0000
Subject: [Intel-wired-lan] [PATCH v7 intel-next 6/9] ice: propagate
 xdp_ring onto rx_ring
In-Reply-To: <20210819120004.34392-7-maciej.fijalkowski@intel.com>
References: <20210819120004.34392-1-maciej.fijalkowski@intel.com>
 <20210819120004.34392-7-maciej.fijalkowski@intel.com>
Message-ID: <PH0PR11MB51440C7E16476F0583A279B7E2CF9@PH0PR11MB5144.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Maciej
> Fijalkowski
> Sent: Thursday, August 19, 2021 5:30 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: joamaki at gmail.com; Lobakin, Alexandr <alexandr.lobakin@intel.com>;
> netdev at vger.kernel.org; toke at redhat.com; bjorn at kernel.org; kuba at kernel.org;
> bpf at vger.kernel.org; davem at davemloft.net; Karlsson, Magnus
> <magnus.karlsson@intel.com>
> Subject: [Intel-wired-lan] [PATCH v7 intel-next 6/9] ice: propagate xdp_ring onto
> rx_ring
> 
> With rings being split, it is now convenient to introduce a pointer to XDP ring within
> the Rx ring. For XDP_TX workloads this means that xdp_rings array access will be
> skipped, which was executed per each processed frame.
> 
> Also, read the XDP prog once per NAPI and if prog is present, set up the local
> xdp_ring pointer. Reading prog a single time was discussed in [1] with some
> concern raised by Toke around dispatcher handling and having the need for going
> through the RCU grace period in the ndo_bpf driver callback, but ice currently is
> torning down NAPI instances regardless of the prog presence on VSI.
> 
> Although the pointer to XDP ring introduced to Rx ring makes things a lot
> slimmer/simpler, I still feel that single prog read per NAPI lifetime is beneficial.
> 
> Further patch that will introduce the fallback path will also get a profit from that as
> xdp_ring pointer will be set during the XDP rings setup.
> 
> [1]: https://lore.kernel.org/bpf/87k0oseo6e.fsf at toke.dk/
> 
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c     |  3 +++
>  drivers/net/ethernet/intel/ice/ice_txrx.c     | 23 +++++++++--------
>  drivers/net/ethernet/intel/ice/ice_txrx.h     |  1 +
>  drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 10 +++-----
> drivers/net/ethernet/intel/ice/ice_txrx_lib.h |  2 +-
>  drivers/net/ethernet/intel/ice/ice_xsk.c      | 25 +++++++++++--------
>  6 files changed, 35 insertions(+), 29 deletions(-)
> 

Tested-by: George Kuruvinakunnel <george.kuruvinakunnel@intel.com>
