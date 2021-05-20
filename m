From: Dvora Fuxbrumer <dvorax.fuxbrumer@linux.intel.com>
Date: Thu, 20 May 2021 09:59:31 +0300
Subject: [Intel-wired-lan] [PATCH v6 7/9] igc: Replace IGC_TX_FLAGS_XDP
 flag by an enum
In-Reply-To: <20210423062555.14972-8-jithu.joseph@intel.com>
References: <20210423062555.14972-1-jithu.joseph@intel.com>
 <20210423062555.14972-8-jithu.joseph@intel.com>
Message-ID: <8245d1b2-b3c4-cda3-fca4-3eebee4aa8a3@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 23/04/2021 09:25, Jithu Joseph wrote:
> From: Andre Guedes <andre.guedes@intel.com>
> 
> Up to this point, tx buffers are associated with either a skb or a xdpf,
> and the IGC_TX_FLAGS_XDP flag was enough to distinguish between these
> two case. However, with upcoming patches that will add AF_XDP zero-copy
> support, a third case will be introduced so this flag-based approach
> won't fit well.
> 
> In preparation to land AF_XDP zero-copy support, replace the
> IGC_TX_FLAGS_XDP flag by an enum which will be extended once zero-copy
> support is introduced to the driver.
> 
> Signed-off-by: Andre Guedes <andre.guedes@intel.com>
> Signed-off-by: Vedang Patel <vedang.patel@intel.com>
> Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
> Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc.h      |  8 +++++--
>   drivers/net/ethernet/intel/igc/igc_main.c | 27 ++++++++++++++++++-----
>   2 files changed, 28 insertions(+), 7 deletions(-)
> 
Tested-by: Dvora Fuxbrumer <dvorax.fuxbrumer@linux.intel.com>
