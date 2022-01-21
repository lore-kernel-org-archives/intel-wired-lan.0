From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Fri, 21 Jan 2022 08:59:15 +0000
Subject: [Intel-wired-lan] [PATCH net v1] i40e: Fix reset path while
 removing the driver
In-Reply-To: <20220112091947.132769-1-karen.sornek@intel.com>
References: <20220112091947.132769-1-karen.sornek@intel.com>
Message-ID: <BYAPR11MB3367646A0992556E8F7161BFFC5B9@BYAPR11MB3367.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Karen Sornek
> Sent: Wednesday, January 12, 2022 2:50 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Laba, SlawomirX <slawomirx.laba@intel.com>; Sornek, Karen
> <karen.sornek@intel.com>; Sylwester Dziedziuch
> <sylwesterx.dziedziuch@intel.com>
> Subject: [Intel-wired-lan] [PATCH net v1] i40e: Fix reset path while removing
> the driver
> 
> Fix the crash in kernel while dereferencing the NULL pointer, when the driver
> is unloaded and simultaneously the vsi rings are being stopped.
> 
> The hardware requires 50msec in order to finish RX queues disable. For this
> purpose the driver spins in mdelay function for the operation to be
> completed.
> 
> For example changing number of queues which requires reset would fail in
> the following call stack:
> 
> 1) i40e_prep_for_reset
> 2) i40e_pf_quiesce_all_vsi
> 3) i40e_quiesce_vsi
> 4) i40e_vsi_close
> 5) i40e_down
> 6) i40e_vsi_stop_rings
> 7) i40e_vsi_control_rx -> disable requires the delay of 50msecs
> 8) continue back in i40e_down function where
>    i40e_clean_tx_ring(vsi->tx_rings[i]) is going to crash
> 
> When the driver was spinning vsi_release called i40e_vsi_free_arrays where
> the vsi->tx_rings resources were freed and the pointer was set to NULL.
> 
> Fixes: 5b6d4a7f20b0 ("i40e: Fix crash during removing i40e driver")
> Signed-off-by: Slawomir Laba <slawomirx.laba@intel.com>
> Signed-off-by: Sylwester Dziedziuch <sylwesterx.dziedziuch@intel.com>
> Signed-off-by: Karen Sornek <karen.sornek@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h      |  1 +
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 19 ++++++++++++++++++-
>  2 files changed, 19 insertions(+), 1 deletion(-)
> 

Tested-by: Gurucharan G <gurucharanx.g@intel.com> (A Contingent worker at Intel)
