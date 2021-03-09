From: Jambekar, Vishakha <vishakha.jambekar@intel.com>
Date: Tue, 9 Mar 2021 16:27:50 +0000
Subject: [Intel-wired-lan] [PATCH intel-net 3/3] ixgbe: move headroom
 initialization to ixgbe_configure_rx_ring
In-Reply-To: <20210303153928.11764-4-maciej.fijalkowski@intel.com>
References: <20210303153928.11764-1-maciej.fijalkowski@intel.com>
 <20210303153928.11764-4-maciej.fijalkowski@intel.com>
Message-ID: <SA2PR11MB4940862C67B9242DB23C4B86FF929@SA2PR11MB4940.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Maciej Fijalkowski
> Sent: Wednesday, March 3, 2021 9:09 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: netdev at vger.kernel.org; brouer at redhat.com; kuba at kernel.org;
> bpf at vger.kernel.org; Topel, Bjorn <bjorn.topel@intel.com>; Karlsson,
> Magnus <magnus.karlsson@intel.com>
> Subject: [Intel-wired-lan] [PATCH intel-net 3/3] ixgbe: move headroom
> initialization to ixgbe_configure_rx_ring
> 
> ixgbe_rx_offset(), that is supposed to initialize the Rx buffer headroom, relies
> on __IXGBE_RX_BUILD_SKB_ENABLED flag.
> 
> Currently, the callsite of mentioned function is placed incorrectly within
> ixgbe_setup_rx_resources() where Rx ring's build skb flag is not set yet. This
> causes the XDP_REDIRECT to be partially broken due to inability to create
> xdp_frame in the headroom space, as the headroom is 0.
> 
> Fix this by moving ixgbe_rx_offset() to ixgbe_configure_rx_ring() after the
> flag setting, which happens to be set in ixgbe_set_rx_buffer_len.
> 
> Fixes: c0d4e9d223c5 ("ixgbe: store the result of ixgbe_rx_offset() onto
> ixgbe_ring")
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
Tested-by: Vishakha Jambekar <vishakha.jambekar@intel.com>
