From: Creeley, Brett <brett.creeley@intel.com>
Date: Mon, 16 Aug 2021 16:51:06 +0000
Subject: [Intel-wired-lan] [PATCH v5 intel-next 2/9] ice: move
 ice_container_type onto ice_ring_container
In-Reply-To: <20210814140812.46632-3-maciej.fijalkowski@intel.com>
References: <20210814140812.46632-1-maciej.fijalkowski@intel.com>
 <20210814140812.46632-3-maciej.fijalkowski@intel.com>
Message-ID: <CO1PR11MB4835F0FDF2ABA2578B722095F5FD9@CO1PR11MB4835.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Fijalkowski, Maciej <maciej.fijalkowski@intel.com>
> Sent: Saturday, August 14, 2021 7:08 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: netdev at vger.kernel.org; bpf at vger.kernel.org; davem at davemloft.net; Nguyen, Anthony L <anthony.l.nguyen@intel.com>;
> kuba at kernel.org; bjorn at kernel.org; Karlsson, Magnus <magnus.karlsson@intel.com>; Brandeburg, Jesse
> <jesse.brandeburg@intel.com>; Lobakin, Alexandr <alexandr.lobakin@intel.com>; joamaki at gmail.com; toke at redhat.com; Creeley,
> Brett <brett.creeley@intel.com>; Fijalkowski, Maciej <maciej.fijalkowski@intel.com>
> Subject: [PATCH v5 intel-next 2/9] ice: move ice_container_type onto ice_ring_container
> 
> Currently ice_container_type is scoped only for ice_ethtool.c. Next
> commit that will split the ice_ring struct onto Rx/Tx specific ring
> structs is going to also modify the type of linked list of rings that is
> within ice_ring_container. Therefore, the functions that are taking the
> ice_ring_container as an input argument will need to be aware of a ring
> type that will be looked up.
> 
> Embed ice_container_type within ice_ring_container and initialize it
> properly when allocating the q_vectors.
> 
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_base.c    |  2 ++
>  drivers/net/ethernet/intel/ice/ice_ethtool.c | 36 ++++++++------------
>  drivers/net/ethernet/intel/ice/ice_txrx.h    |  6 ++++
>  3 files changed, 23 insertions(+), 21 deletions(-)

<snip>

> +enum ice_container_type {
> +	ICE_RX_CONTAINER,
> +	ICE_TX_CONTAINER,
> +};
> +
>  struct ice_ring_container {
>  	/* head of linked-list of rings */
>  	struct ice_ring *ring;
> @@ -347,6 +352,7 @@ struct ice_ring_container {
>  	u16 itr_setting:13;
>  	u16 itr_reserved:2;
>  	u16 itr_mode:1;
> +	enum ice_container_type type;

It may not matter, but should you make sure
the size of "type" doesn't negativelly affect this
structure?

>  };
> 
>  struct ice_coalesce_stored {
> --
> 2.20.1

