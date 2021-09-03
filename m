From: Kuruvinakunnel, George <george.kuruvinakunnel@intel.com>
Date: Fri, 3 Sep 2021 06:37:31 +0000
Subject: [Intel-wired-lan] [PATCH v7 intel-next 4/9] ice: unify
 xdp_rings accesses
In-Reply-To: <20210819120004.34392-5-maciej.fijalkowski@intel.com>
References: <20210819120004.34392-1-maciej.fijalkowski@intel.com>
 <20210819120004.34392-5-maciej.fijalkowski@intel.com>
Message-ID: <PH0PR11MB51448229AD1C3E3DFCBA97D6E2CF9@PH0PR11MB5144.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH v7 intel-next 4/9] ice: unify xdp_rings accesses
> 
> There has been a long lasting issue of improper xdp_rings indexing for XDP_TX
> and XDP_REDIRECT actions. Given that currently rx_ring->q_index is mixed with
> smp_processor_id(), there could be a situation where Tx descriptors are produced
> onto XDP Tx ring, but tail is never bumped - for example pin a particular queue id
> to non-matching IRQ line.
> 
> Address this problem by ignoring the user ring count setting and always initialize
> the xdp_rings array to be of num_possible_cpus() size. Then, always use the
> smp_processor_id() as an index to xdp_rings array. This provides serialization as
> at given time only a single softirq can run on a particular CPU.
> 
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c      | 2 +-
>  drivers/net/ethernet/intel/ice/ice_main.c     | 2 +-
>  drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 

Tested-by: George Kuruvinakunnel <george.kuruvinakunnel@intel.com>
