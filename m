From: Brelinski, Tony <tony.brelinski@intel.com>
Date: Tue, 21 Dec 2021 00:23:59 +0000
Subject: [Intel-wired-lan] [PATCH net-next v1] i40e: Minimize amount of
 busy-waiting during AQ send
In-Reply-To: <20211116131329.626045-1-jedrzej.jagielski@intel.com>
References: <20211116131329.626045-1-jedrzej.jagielski@intel.com>
Message-ID: <DM6PR11MB421826531C4B6A51D270AE41827C9@DM6PR11MB4218.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Jedrzej Jagielski
> Sent: Tuesday, November 16, 2021 5:13 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Lukwinski, Dawid <dawid.lukwinski@intel.com>; Jagielski, Jedrzej
> <jedrzej.jagielski@intel.com>
> Subject: [Intel-wired-lan] [PATCH net-next v1] i40e: Minimize amount of
> busy-waiting during AQ send
> 
> The i40e_asq_send_command will now use a non blocking usleep_range if
> possible (non-atomic context), instead of busy-waiting udelay. The
> usleep_range function uses hrtimers to provide better performance and
> remove the negative impact of busy-waiting in time-critical environments.
> 
> 1. Rename i40e_asq_send_command to i40e_asq_send_command_atomic
>    and add 5th parameter to inform if called from an atomic context.
>    Call inside usleep_range (if non-atomic) or udelay (if atomic).
> 
> 2. Change i40e_asq_send_command to invoke
>    i40e_asq_send_command_atomic(..., false).
> 
> 3. Change two functions:
>     - i40e_aq_set_vsi_uc_promisc_on_vlan
>     - i40e_aq_set_vsi_mc_promisc_on_vlan
>    to explicitly use i40e_asq_send_command_atomic(..., true)
>    instead of i40e_asq_send_command, as they use spinlocks and do some
>    work in an atomic context.
>    All other calls to i40e_asq_send_command remain unchanged.
> 
> Title: Minimize amount of busy-waiting during AQ send
> Signed-off-by: Dawid Lukwinski <dawid.lukwinski@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_adminq.c | 29 ++++++++++++++-----
> drivers/net/ethernet/intel/i40e/i40e_common.c |  6 ++--
> .../net/ethernet/intel/i40e/i40e_prototype.h  | 14 +++++----
>  3 files changed, 35 insertions(+), 14 deletions(-)

Tested-by: Tony Brelinski <tony.brelinski@intel.com>


