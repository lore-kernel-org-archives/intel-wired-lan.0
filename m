From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Fri, 21 Jan 2022 10:40:45 +0000
Subject: [Intel-wired-lan] [PATCH net-next v2 4/4] i40e: Fix race
 condition while adding/deleting MAC/VLAN filters
In-Reply-To: <20220114131931.346687-5-jedrzej.jagielski@intel.com>
References: <20220114131931.346687-1-jedrzej.jagielski@intel.com>
 <20220114131931.346687-5-jedrzej.jagielski@intel.com>
Message-ID: <BYAPR11MB3367A8ADC8B930E59A7A8C5AFC5B9@BYAPR11MB3367.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Jagielski, Jedrzej
> Sent: Friday, January 14, 2022 6:50 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Sylwester Dziedziuch <sylwesterx.dziedziuch@intel.com>; Jagielski,
> Jedrzej <jedrzej.jagielski@intel.com>
> Subject: [Intel-wired-lan] [PATCH net-next v2 4/4] i40e: Fix race condition
> while adding/deleting MAC/VLAN filters
> 
> From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> 
> There was a race condition in access to hw->aq.asq_last_status while adding
> and deleting  MAC/VLAN filters causing incorrect error status to be printed as
> ERROR OK instead of the correct error.
> 
> Change calls to i40e_aq_add_macvlan in i40e_aqc_add_filters and
> i40e_aq_remove_macvlan in i40e_aqc_del_filters to  _v2 versions that
> return Admin Queue status on the stack to avoid race conditions in access to
> hw->aq.asq_last_status.
> 
> Fixes: 0093631966aa ("i40e: remove duplicate add/delete adminq command
> code for filters")
> Signed-off-by: Sylwester Dziedziuch <sylwesterx.dziedziuch@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 24 +++++++++++----------
>  1 file changed, 13 insertions(+), 11 deletions(-)
> 

Tested-by: Gurucharan G <gurucharanx.g@intel.com> (A Contingent worker at Intel)
