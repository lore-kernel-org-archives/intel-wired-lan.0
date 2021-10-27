From: Brelinski, Tony <tony.brelinski@intel.com>
Date: Wed, 27 Oct 2021 20:51:59 +0000
Subject: [Intel-wired-lan] [PATCH net-next v1 2/2] i40e: Fix ping is
 lost after configuring ADq on VF
In-Reply-To: <20210423114326.22393-3-eryk.roch.rybak@intel.com>
References: <20210423114326.22393-1-eryk.roch.rybak@intel.com>
 <20210423114326.22393-3-eryk.roch.rybak@intel.com>
Message-ID: <MN2PR11MB4224574EAFC486C9D099D0B782859@MN2PR11MB4224.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Rybak, Eryk Roch
> Sent: Friday, April 23, 2021 4:43 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Rybak, Eryk Roch <eryk.roch.rybak@intel.com>; Patynowski,
> PrzemyslawX <przemyslawx.patynowski@intel.com>
> Subject: [Intel-wired-lan] [PATCH net-next v1 2/2] i40e: Fix ping is lost after
> configuring ADq on VF
> 
> Properly reconfigure VF VSIs after VF request ADq.
> Created new function to update queue mapping and queue pairs per TC with
> AQ update VSI. This sets proper RSS size on NIC.
> VFs num_queue_pairs should not be changed during setup of queue maps.
> Previously, VF main VSI in ADq had configured too many queues and had
> wrong RSS size, which lead to packets not being consumed and drops in
> connectivity.
> 
> Fixes: bc6d33c8d93f ("i40e: Fix the number of queues available to be mapped
> for use")
> Co-developed-by: Przemyslaw Patynowski
> <przemyslawx.patynowski@intel.com>
> Signed-off-by: Przemyslaw Patynowski
> <przemyslawx.patynowski@intel.com>
> Signed-off-by: Eryk Rybak <eryk.roch.rybak@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h        |  1 +
>  drivers/net/ethernet/intel/i40e/i40e_main.c   | 62 ++++++++++++++++++-
>  .../ethernet/intel/i40e/i40e_virtchnl_pf.c    | 17 +++--
>  3 files changed, 72 insertions(+), 8 deletions(-)

Tested-by: Tony Brelinski <tony.brelinski@intel.com>



