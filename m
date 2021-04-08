From: Dvora Fuxbrumer <dvorax.fuxbrumer@linux.intel.com>
Date: Thu, 8 Apr 2021 13:08:54 +0300
Subject: [Intel-wired-lan] [PATCH v5 2/9] igc: Refactor
 __igc_xdp_run_prog()
In-Reply-To: <20210226002308.2348-3-jithu.joseph@intel.com>
References: <20210226002308.2348-1-jithu.joseph@intel.com>
 <20210226002308.2348-3-jithu.joseph@intel.com>
Message-ID: <9f0c50ba-189f-89dd-bfa4-9ab1dcb3008f@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 26/02/2021 02:23, Jithu Joseph wrote:
> From: Andre Guedes <andre.guedes@intel.com>
> 
> Refactor __igc_xdp_run_prog() helper from igc_xdp_run_prog(),
> preparing the code for AF_XDP zero-copy support which is added
> by upcoming patches.
> 
> The existing igc_xdp_run_prog() caters to regular XDP rx path
> which has to verify if bpf_prog is not NULL. Zero-copy
> path assumes that bpf_prog is not NULL and hence this check is
> not required. Therefore it makes sense to refactor the common
> code into a helper function, to avoid code duplication.
> 
> Signed-off-by: Andre Guedes <andre.guedes@intel.com>
> Signed-off-by: Vedang Patel <vedang.patel@intel.com>
> Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
> Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_main.c | 56 +++++++++++------------
>   1 file changed, 28 insertions(+), 28 deletions(-)
> 
Tested-by: Dvora Fuxbrumer <dvorax.fuxbrumer@linux.intel.com>
