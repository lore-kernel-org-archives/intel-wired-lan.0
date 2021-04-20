From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Tue, 20 Apr 2021 17:09:01 +0000
Subject: [Intel-wired-lan] [PATCH 2/2 net v2] i40e: Fix ping is lost
 after configuring ADq on VF
In-Reply-To: <20210416134054.58330-2-eryk.roch.rybak@intel.com>
References: <20210416134054.58330-1-eryk.roch.rybak@intel.com>
 <20210416134054.58330-2-eryk.roch.rybak@intel.com>
Message-ID: <44579dfd8c0d0147020b0437a45440134d5259b3.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 2021-04-16 at 15:40 +0200, Eryk Rybak wrote:
> Properly reconfigure VF VSIs after VF request ADq.
> Created new function to update queue mapping and queue pairs per TC
> with AQ update VSI. This sets proper RSS size on NIC.
> VFs num_queue_pairs should not be changed during setup of queue maps.
> Previously, VF main VSI in ADq had configured too many queues and had
> wrong RSS size, which lead to packets not being consumed and drops in
> connectivity.

This patch doesn't apply. Since this is for net, please be sure you are
using net-queue/dev-queue.

> Fixes: bc6d33c8d93f ("i40e: Fix the number of queues available to be
> mapped for use")
> Signed-off-by: Eryk Rybak <eryk.roch.rybak@intel.com>

As submitter, you're Signed-off-by should be last. Same comment for
patch 1.

> Co-developed-by: Przemyslaw Patynowski <
> przemyslawx.patynowski at intel.com>
> Signed-off-by: Przemyslaw Patynowski <
> przemyslawx.patynowski at intel.com>
> ---

<snip>

> @@ -5434,6 +5440,56 @@ static void i40e_vsi_update_queue_map(struct
> i40e_vsi *vsi,
>  	       sizeof(vsi->info.tc_mapping));
>  }
>  
> +/**
> + * i40e_update_adq_vsi_queues - update queue mapping for ADq VSI
> + * @vsi: the VSI being reconfigured
> + * @vsi_offset: offset from main VF VSI
> + */
> +int i40e_update_adq_vsi_queues(struct i40e_vsi *vsi, int vsi_offset)
> +{
> +	struct i40e_pf *pf = vsi->back;
> +	struct i40e_hw *hw = &pf->hw;
> +	struct i40e_vsi_context ctxt = {};
> +	int ret = 0;

Reverse Christmas tree.
