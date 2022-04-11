From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Mon, 11 Apr 2022 13:20:03 +0000
Subject: [Intel-wired-lan] [PATCH net v1] iavf: Fix error when changing
 ring parameters on ice PF
In-Reply-To: <20220330195036.1319631-1-michal.maloszewski@intel.com>
References: <20220330195036.1319631-1-michal.maloszewski@intel.com>
Message-ID: <DM8PR11MB5621FD32D8F77F7477A0B205ABEA9@DM8PR11MB5621.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Michal Maloszewski
> Sent: Wednesday, March 30, 2022 9:51 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Sylwester Dziedziuch <sylwesterx.dziedziuch@intel.com>; Maloszewski,
> Michal <michal.maloszewski@intel.com>
> Subject: [Intel-wired-lan] [PATCH net v1] iavf: Fix error when changing ring
> parameters on ice PF
> 
> Reset is triggered when ring parameters are being changed through ethtool
> and queues are reconfigured for VF's VSI. If ring is changed again
> immediately, then the next reset could be executed before queues could be
> properly reinitialized on VF's VSI. It caused ice PF to mess up the VSI resource
> tree.
> 
> Add a check in iavf_set_ringparam for adapter and VF's queue state. If VF is
> currently resetting or queues are disabled for the VF return with EAGAIN
> error.
> 
> Fixes: d732a1844507 ("i40evf: fix crash when changing ring sizes")
> Title: iavf: Fix error when changing ring parameters on ice PF
> Change-type: DefectResolution
> HSDES-Number: 18021295299
> HSDES-Tenant: server_platf_lan.bug
> Signed-off-by: Sylwester Dziedziuch <sylwesterx.dziedziuch@intel.com>
> Signed-off-by: Michal Maloszewski <michal.maloszewski@intel.com>
> ---
>  drivers/net/ethernet/intel/iavf/iavf_ethtool.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
> b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
> index 3bb56714beb0..762ef6fb5585 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c

Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>
