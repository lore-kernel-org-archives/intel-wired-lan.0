From: Jesper Dangaard Brouer <brouer@redhat.com>
Date: Thu, 4 Mar 2021 09:53:56 +0100
Subject: [Intel-wired-lan] [PATCH intel-net 1/3] i40e: move headroom
 initialization to i40e_configure_rx_ring
In-Reply-To: <20210303153928.11764-2-maciej.fijalkowski@intel.com>
References: <20210303153928.11764-1-maciej.fijalkowski@intel.com>
 <20210303153928.11764-2-maciej.fijalkowski@intel.com>
Message-ID: <20210304095356.054a8778@carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed,  3 Mar 2021 16:39:26 +0100
Maciej Fijalkowski <maciej.fijalkowski@intel.com> wrote:

> i40e_rx_offset(), that is supposed to initialize the Rx buffer headroom,
> relies on I40E_RXR_FLAGS_BUILD_SKB_ENABLED flag.
> 
> Currently, the callsite of mentioned function is placed incorrectly
> within i40e_setup_rx_descriptors() where Rx ring's build skb flag is not
> set yet. This causes the XDP_REDIRECT to be partially broken due to
> inability to create xdp_frame in the headroom space, as the headroom is
> 0.
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
> Fix this by moving i40e_rx_offset() to i40e_configure_rx_ring() after
> the flag setting.
> 
> Fixes: f7bb0d71d658 ("i40e: store the result of i40e_rx_offset() onto i40e_ring")
> Reported-by: Jesper Dangaard Brouer <brouer@redhat.com>
> Co-developed-by: Jesper Dangaard Brouer <brouer@redhat.com>
> Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 13 +++++++++++++
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c | 12 ------------
>  2 files changed, 13 insertions(+), 12 deletions(-)

Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>
Tested-by: Jesper Dangaard Brouer <brouer@redhat.com>

I'm currently looking at extending samples/bpf/ xdp_redirect_map to
detect the situation.  As with this bug the redirect tests/sample
programs will just report really high performance numbers (because
packets are dropped earlier due to err).   Knowing what performance
numbers to expect, I could see that they were out-of-spec, and
investigated the root-cause.

I assume Intel QA tested XDP-redirect and didn't find the bug due to
this.  Red Hat QA also use samples/bpf/xdp* and based on the reports I
get from them, I could not blame them if this bug would slip through,
as the tool reports "good" results.

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer

