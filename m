From: Brelinski, Tony <tony.brelinski@intel.com>
Date: Wed, 27 Oct 2021 20:55:29 +0000
Subject: [Intel-wired-lan] [PATCH net-next v1 1/2] i40e: Fix changing
 previously set num_queue_pairs for PFs
In-Reply-To: <20210423114326.22393-2-eryk.roch.rybak@intel.com>
References: <20210423114326.22393-1-eryk.roch.rybak@intel.com>
 <20210423114326.22393-2-eryk.roch.rybak@intel.com>
Message-ID: <MN2PR11MB42244C849644036FA11758AF82859@MN2PR11MB4224.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH net-next v1 1/2] i40e: Fix changing
> previously set num_queue_pairs for PFs
> 
> Currently, the i40e_vsi_setup_queue_map is basing the count of queues in
> TCs on a VSI's alloc_queue_pairs member which is not changed throughout
> any user's action (for example via ethtool's set_channels callback).
> 
> This implies that vsi->tc_config.tc_info[n].qcount value that is given to the
> kernel via netdev_set_tc_queue() that notifies about the count of queues
> per particular traffic class is constant even if user has changed the total count
> of queues.
> 
> This in turn caused the kernel warning after setting the queue count to the
> lower value than the initial one:
> 
> $ ethtool -l ens801f0
> Channel parameters for ens801f0:
> Pre-set maximums:
> RX:             0
> TX:             0
> Other:          1
> Combined:       64
> Current hardware settings:
> RX:             0
> TX:             0
> Other:          1
> Combined:       64
> 
> $ ethtool -L ens801f0 combined 40
> 
> [dmesg]
> Number of in use tx queues changed invalidating tc mappings. Priority traffic
> classification disabled!
> 
> Reason was that vsi->alloc_queue_pairs stayed at 64 value which was used
> to set the qcount on TC0 (by default only TC0 exists so all of the existing
> queues are assigned to TC0). we update the offset/qcount via
> netdev_set_tc_queue() back to the old value but then the
> netif_set_real_num_tx_queues() is using the vsi->num_queue_pairs as a
> value which got set to 40.
> 
> Fix it by using vsi->req_queue_pairs as a queue count that will be distributed
> across TCs. Do it only for non-zero values, which implies that user actually
> requested the new count of queues.
> 
> For VSIs other than main, stay with the vsi->alloc_queue_pairs as we only
> allow manipulating the queue count on main VSI.
> 
> Fixes: bc6d33c8d93f ("i40e: Fix the number of queues available to be mapped
> for use")
> Co-developed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Co-developed-by: Przemyslaw Patynowski
> <przemyslawx.patynowski@intel.com>
> Signed-off-by: Przemyslaw Patynowski
> <przemyslawx.patynowski@intel.com>
> Signed-off-by: Eryk Rybak <eryk.roch.rybak@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 35 ++++++++++++++-------
>  1 file changed, 23 insertions(+), 12 deletions(-)

Tested-by: Tony Brelinski <tony.brelinski@intel.com>


