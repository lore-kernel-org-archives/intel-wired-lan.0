From: Dvora Fuxbrumer <dvorax.fuxbrumer@linux.intel.com>
Date: Thu, 8 Apr 2021 13:13:36 +0300
Subject: [Intel-wired-lan] [PATCH v5 9/9] igc: Enable TX via AF_XDP
 zero-copy
In-Reply-To: <20210226002308.2348-10-jithu.joseph@intel.com>
References: <20210226002308.2348-1-jithu.joseph@intel.com>
 <20210226002308.2348-10-jithu.joseph@intel.com>
Message-ID: <d8f54700-d8a9-b1c8-fa37-0a4dba55f5f8@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 26/02/2021 02:23, Jithu Joseph wrote:
> From: Andre Guedes <andre.guedes@intel.com>
> 
> Add support for transmitting packets via AF_XDP zero-copy mechanism.
> 
> The packet transmission itself is implemented by igc_xdp_xmit_zc() which
> is called from igc_clean_tx_irq() when the ring has AF_XDP zero-copy
> enabled. Likewise i40e and ice drivers, the transmission budget used is
> the number of descriptors available on the ring.
> 
> A new tx buffer type is introduced to 'enum igc_tx_buffer_type' to
> indicate the tx buffer uses memory from xsk pool so it can be properly
> cleaned after transmission or when the ring is cleaned.
> 
> The I225 controller has only 4 Tx hardware queues so the main difference
> between igc and other Intel drivers that support AF_XDP zero-copy is
> that there is no tx ring dedicated exclusively to XDP. Instead, tx
> rings are shared between the network stack and XDP, and netdev queue
> lock is used to ensure mutual exclusion. This is the same approach
> implemented to support XDP_TX and XDP_REDIRECT actions.
> 
> Signed-off-by: Andre Guedes <andre.guedes@intel.com>
> Signed-off-by: Vedang Patel <vedang.patel@intel.com>
> Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
> Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc.h      |   3 +
>   drivers/net/ethernet/intel/igc/igc_base.h |   1 +
>   drivers/net/ethernet/intel/igc/igc_main.c | 113 +++++++++++++++++++++-
>   drivers/net/ethernet/intel/igc/igc_xdp.c  |  20 +++-
>   4 files changed, 129 insertions(+), 8 deletions(-)
> 
Tested-by: Dvora Fuxbrumer <dvorax.fuxbrumer@linux.intel.com>
