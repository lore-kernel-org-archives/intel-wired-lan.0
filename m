From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Mon, 31 Jan 2022 14:01:47 +0000
Subject: [Intel-wired-lan] [PATCH net-next v2 1/4] i40e: Add sending
 commands in atomic context
In-Reply-To: <20220114131931.346687-2-jedrzej.jagielski@intel.com>
References: <20220114131931.346687-1-jedrzej.jagielski@intel.com>
 <20220114131931.346687-2-jedrzej.jagielski@intel.com>
Message-ID: <BYAPR11MB3367563BE14B2BCB6EA01EF5FC259@BYAPR11MB3367.namprd11.prod.outlook.com>
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
> Cc: Witold Fijalkowski <witoldx.fijalkowski@intel.com>; Jagielski, Jedrzej
> <jedrzej.jagielski@intel.com>
> Subject: [Intel-wired-lan] [PATCH net-next v2 1/4] i40e: Add sending
> commands in atomic context
> 
> From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> 
> Change functions:
> - i40e_aq_add_macvlan
> - i40e_aq_remove_macvlan
> - i40e_aq_delete_element
> - i40e_aq_add_vsi
> - i40e_aq_update_vsi_params
> to explicitly use i40e_asq_send_command_atomic(..., true) instead of
> i40e_asq_send_command, as they use mutexes and do some work in an
> atomic context.
> Without this change setting vlan via netdev will fail with call trace cased by
> bug "BUG: scheduling while atomic".
> 
> Signed-off-by: Witold Fijalkowski <witoldx.fijalkowski@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_common.c | 21 +++++++++++--------
>  1 file changed, 12 insertions(+), 9 deletions(-)
> 

Tested-by: Gurucharan G <gurucharanx.g@intel.com> (A Contingent worker at Intel)
