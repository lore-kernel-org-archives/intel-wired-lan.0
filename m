From: Dvora Fuxbrumer <dvorax.fuxbrumer@linux.intel.com>
Date: Thu, 8 Apr 2021 13:13:08 +0300
Subject: [Intel-wired-lan] [PATCH v5 8/9] igc: Enable RX via AF_XDP
 zero-copy
In-Reply-To: <20210226002308.2348-9-jithu.joseph@intel.com>
References: <20210226002308.2348-1-jithu.joseph@intel.com>
 <20210226002308.2348-9-jithu.joseph@intel.com>
Message-ID: <f794464d-11f1-a659-34c9-82c203dbbe0e@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 26/02/2021 02:23, Jithu Joseph wrote:
> From: Andre Guedes <andre.guedes@intel.com>
> 
> Add support for receiving packets via AF_XDP zero-copy mechanism.
> 
> Add a new flag to 'enum igc_ring_flags_t' to indicate the ring has
> AF_XDP zero-copy enabled so proper ring setup is carried out during ring
> configuration in igc_configure_rx_ring().
> 
> RX buffers can now be allocated via the shared pages mechanism (default
> behavior of the driver) or via xsk pool (when AF_XDP zero-copy is
> enabled) so a union is added to the 'struct igc_rx_buffer' to cover both
> cases.
> 
> When AF_XDP zero-copy is enabled, rx buffers are allocated from the xsk
> pool using the new helper igc_alloc_rx_buffers_zc() which is the
> counterpart of igc_alloc_rx_buffers().
> 
> Likewise other Intel drivers that support AF_XDP zero-copy, in igc we
> have a dedicated path for cleaning up rx irqs when zero-copy is enabled.
> This avoids adding too many checks within igc_clean_rx_irq(), resulting
> in a more readable and efficient code since this function is called from
> the hot-path of the driver.
> 
> Signed-off-by: Andre Guedes <andre.guedes@intel.com>
> Signed-off-by: Vedang Patel <vedang.patel@intel.com>
> Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
> Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc.h      |  22 +-
>   drivers/net/ethernet/intel/igc/igc_base.h |   1 +
>   drivers/net/ethernet/intel/igc/igc_main.c | 338 +++++++++++++++++++++-
>   drivers/net/ethernet/intel/igc/igc_xdp.c  |  98 +++++++
>   drivers/net/ethernet/intel/igc/igc_xdp.h  |   2 +
>   5 files changed, 442 insertions(+), 19 deletions(-)
> 
Tested-by: Dvora Fuxbrumer <dvorax.fuxbrumer@linux.intel.com>
