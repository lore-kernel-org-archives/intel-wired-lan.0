From: Dvora Fuxbrumer <dvorax.fuxbrumer@linux.intel.com>
Date: Thu, 20 May 2021 09:55:35 +0300
Subject: [Intel-wired-lan] [PATCH v6 1/9] igc: Move igc_xdp_is_enabled()
In-Reply-To: <20210423062555.14972-2-jithu.joseph@intel.com>
References: <20210423062555.14972-1-jithu.joseph@intel.com>
 <20210423062555.14972-2-jithu.joseph@intel.com>
Message-ID: <5c909bf6-b52f-ff34-76b2-051eeac90cfd@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 23/04/2021 09:25, Jithu Joseph wrote:
> From: Andre Guedes <andre.guedes@intel.com>
> 
> Move the helper igc_xdp_is_enabled() to igc_xdp.h so it can be reused in
> igc_xdp.c by upcoming patches that will introduce AF_XDP zero-copy
> support to the driver.
> 
> Signed-off-by: Andre Guedes <andre.guedes@intel.com>
> Signed-off-by: Vedang Patel <vedang.patel@intel.com>
> Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
> Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_main.c | 5 -----
>   drivers/net/ethernet/intel/igc/igc_xdp.h  | 5 +++++
>   2 files changed, 5 insertions(+), 5 deletions(-)
> 
Tested-by: Dvora Fuxbrumer <dvorax.fuxbrumer@linux.intel.com>
