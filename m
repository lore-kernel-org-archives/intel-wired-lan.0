From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Tue, 21 Aug 2018 21:16:28 +0000
Subject: [Intel-wired-lan] [PATCH v3 02/15] ice: Updates to Tx scheduler
 code
In-Reply-To: <20180809132958.23036-3-anirudh.venkataramanan@intel.com>
References: <20180809132958.23036-1-anirudh.venkataramanan@intel.com>
 <20180809132958.23036-3-anirudh.venkataramanan@intel.com>
Message-ID: <C25D919FD1849B409D8D987DDC7FCD26195459AE@ORSMSX109.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Thursday, August 9, 2018 6:30 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v3 02/15] ice: Updates to Tx scheduler code
> 
> 1) The maximum device nodes is a global value and shared by the whole
>    device. Add element AQ command would fail if there is no space to
>    add new nodes so the check for max nodes isn't required. So remove
>    ice_sched_get_num_nodes_per_layer and ice_sched_val_max_nodes.
> 
> 2) In ice_sched_add_elems, set default node's CIR/EIR bandwidth weight.
> 
> 3) Fix default scheduler topology buffer size as the firmware expects
>    a 4KB buffer at all times, and will error out if one of any other
>    size is provided.
> 
> 4) In the latest spec, max children per node per layer is replaced by
>    max sibling group size. Now it provides the max children of the below
>    layer node, not the current layer node.
> 
> 5) Fix some newline/whitespace issues for consistency.
> 
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  .../net/ethernet/intel/ice/ice_adminq_cmd.h   |   5 +-
>  drivers/net/ethernet/intel/ice/ice_common.c   |   7 +
>  drivers/net/ethernet/intel/ice/ice_sched.c    | 161 ++++++------------
>  drivers/net/ethernet/intel/ice/ice_type.h     |   2 +
>  4 files changed, 61 insertions(+), 114 deletions(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com>


