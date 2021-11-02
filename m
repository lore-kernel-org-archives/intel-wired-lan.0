From: Brelinski, Tony <tony.brelinski@intel.com>
Date: Tue, 2 Nov 2021 23:04:37 +0000
Subject: [Intel-wired-lan] [PATCH net v1] i40e: Fix issue when maximum
 queues is exceeded
In-Reply-To: <20210823114344.7058-1-jedrzej.jagielski@intel.com>
References: <20210823114344.7058-1-jedrzej.jagielski@intel.com>
Message-ID: <MN2PR11MB4224908C1BEF0EDE97995C94828B9@MN2PR11MB4224.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Jagielski, Jedrzej
> Sent: Monday, August 23, 2021 4:44 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Gawin, JaroslawX <jaroslawx.gawin@intel.com>; Jagielski, Jedrzej
> <jedrzej.jagielski@intel.com>
> Subject: [Intel-wired-lan] [PATCH net v1] i40e: Fix issue when maximum
> queues is exceeded
> 
> Before this patch VF interface vanished when maximum queue number was
> exceeded. Driver tried to add next queues even if there was not enough
> space. PF sent incorrect number of queues to the VF when there were not
> enough of them.
> 
> Add an additional condition introduced to check available space in 'qp_pile'
> before proceeding.
> Also add the search for free space in PF queue pair piles.
> 
> Without this patch VF interfaces are not seen when available space for
> queues has been exceeded and following logs appears permanently in
> dmesg:
> "Unable to get VF config (-32)".
> "VF 62 failed opcode 3, retval: -5"
> "Unable to get VF config due to PF error condition, not retrying"
> 
> Fixes: 7daa6bf3294e ("i40e: driver core headers")
> Fixes: 41c445ff0f48 ("i40e: main driver core")
> Signed-off-by: Jaroslaw Gawin <jaroslawx.gawin@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h        |  2 +-
>  drivers/net/ethernet/intel/i40e/i40e_main.c   | 49 +++++++++++----
>  .../ethernet/intel/i40e/i40e_virtchnl_pf.c    | 59 +++++++++++++++++++
>  3 files changed, 96 insertions(+), 14 deletions(-)

Tested-by: Tony Brelinski <tony.brelinski@intel.com>


