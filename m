From: Dvora Fuxbrumer <dvorax.fuxbrumer@linux.intel.com>
Date: Thu, 20 May 2021 09:57:03 +0300
Subject: [Intel-wired-lan] [PATCH v6 3/9] igc: Refactor
 igc_clean_rx_ring()
In-Reply-To: <20210423062555.14972-4-jithu.joseph@intel.com>
References: <20210423062555.14972-1-jithu.joseph@intel.com>
 <20210423062555.14972-4-jithu.joseph@intel.com>
Message-ID: <fd7e5894-e484-4f2f-4a4d-910e068c6c96@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 23/04/2021 09:25, Jithu Joseph wrote:
> From: Andre Guedes <andre.guedes@intel.com>
> 
> Refactor igc_clean_rx_ring() helper, preparing the code for AF_XDP
> zero-copy support which is added by upcoming patches.
> 
> The refactor consists of encapsulating page-shared specific code into
> its own helper, leaving common code that will be shared by both
> page-shared and xsk pool in igc_clean_rx_ring().
> 
> Signed-off-by: Andre Guedes <andre.guedes@intel.com>
> Signed-off-by: Vedang Patel <vedang.patel@intel.com>
> Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
> Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_main.c | 23 ++++++++++++++---------
>   1 file changed, 14 insertions(+), 9 deletions(-)
> 
Tested-by: Dvora Fuxbrumer <dvorax.fuxbrumer@linux.intel.com>
