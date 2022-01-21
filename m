From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Fri, 21 Jan 2022 09:15:52 +0000
Subject: [Intel-wired-lan] [PATCH net-next v2 2/4] i40e: Add new
 versions of send ASQ command functions
In-Reply-To: <20220114131931.346687-3-jedrzej.jagielski@intel.com>
References: <20220114131931.346687-1-jedrzej.jagielski@intel.com>
 <20220114131931.346687-3-jedrzej.jagielski@intel.com>
Message-ID: <BYAPR11MB3367556C56A9C79CCC190384FC5B9@BYAPR11MB3367.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Jagielski, Jedrzej
> Sent: Friday, January 14, 2022 6:49 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Sylwester Dziedziuch <sylwesterx.dziedziuch@intel.com>; Jagielski,
> Jedrzej <jedrzej.jagielski@intel.com>
> Subject: [Intel-wired-lan] [PATCH net-next v2 2/4] i40e: Add new versions of
> send ASQ command functions
> 
> From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> 
> ASQ send command functions are returning only i40e status codes yet some
> calling functions also need Admin Queue status that is stored in hw-
> >aq.asq_last_status. Since hw object is stored on a heap it introduces a
> possibility for a race condition in access to hw if calling function is not fast
> enough to read hw->aq.asq_last_status before next send ASQ command is
> executed.
> 
> Add new versions of send ASQ command functions that return Admin Queue
> status on the stack to avoid race conditions in access to hw-
> >aq.asq_last_status.
> Add new _v2 version of i40e_aq_remove_macvlan that is using new _v2
> versions of ASQ send command functions and returns the Admin Queue
> status on the stack.
> 
> Signed-off-by: Sylwester Dziedziuch <sylwesterx.dziedziuch@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_adminq.c | 92 +++++++++++++++++--
> drivers/net/ethernet/intel/i40e/i40e_common.c | 46 ++++++++++
> .../net/ethernet/intel/i40e/i40e_prototype.h  | 20 ++++
>  3 files changed, 150 insertions(+), 8 deletions(-)
> 

Tested-by: Gurucharan G <gurucharanx.g@intel.com> (A Contingent worker at Intel)
