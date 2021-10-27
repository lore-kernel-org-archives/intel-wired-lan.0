From: Brelinski, Tony <tony.brelinski@intel.com>
Date: Wed, 27 Oct 2021 20:39:58 +0000
Subject: [Intel-wired-lan] [PATCH net-next v1] i40e: Refactor arrow
 operator usage in i40e_update_adq_vsi_queues()
In-Reply-To: <20210611225435.95070-1-jedrzej.jagielski@intel.com>
References: <20210611225435.95070-1-jedrzej.jagielski@intel.com>
Message-ID: <MN2PR11MB42249EE0FE8F37774B0633F182859@MN2PR11MB4224.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Jagielski, Jedrzej
> Sent: Friday, June 11, 2021 3:55 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>; Jagielski, Jedrzej
> <jedrzej.jagielski@intel.com>
> Subject: [Intel-wired-lan] [PATCH net-next v1] i40e: Refactor arrow operator
> usage in i40e_update_adq_vsi_queues()
> 
> Use local pf & hw variables instead of multiple arrow operators.
> Move pf & hw variables initialization after checking if vsi is not NULL.
> 
> Co-developed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)

Tested-by: Tony Brelinski <tony.brelinski@intel.com>



