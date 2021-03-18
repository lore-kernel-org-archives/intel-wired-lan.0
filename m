From: Dvora Fuxbrumer <dvorax.fuxbrumer@linux.intel.com>
Date: Thu, 18 Mar 2021 12:17:29 +0200
Subject: [Intel-wired-lan] [PATCH v5 1/9] igc: Move igc_xdp_is_enabled()
In-Reply-To: <20210226002308.2348-2-jithu.joseph@intel.com>
References: <20210226002308.2348-1-jithu.joseph@intel.com>
 <20210226002308.2348-2-jithu.joseph@intel.com>
Message-ID: <c2ef61f8-95e5-de99-5aab-4e5ec55a5353@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 26/02/2021 02:23, Jithu Joseph wrote:
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
