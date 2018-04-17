From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Tue, 17 Apr 2018 21:13:31 +0000
Subject: [Intel-wired-lan] [PATCH] ice: Fix initialization for
 num_nodes_added
In-Reply-To: <20180410174949.8141-1-anirudh.venkataramanan@intel.com>
References: <20180410174949.8141-1-anirudh.venkataramanan@intel.com>
Message-ID: <C25D919FD1849B409D8D987DDC7FCD26194B3A58@ORSMSX109.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Tuesday, April 10, 2018 10:50 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] ice: Fix initialization for
> num_nodes_added
> 
> ice_sched_add_nodes_to_layer is used recursively, and so we start with
> num_nodes_added being 0. This way, in case of an error or if num_nodes is
> NULL, the function just returns 0 to indicate that no nodes were added.
> 
> Fixes commit 5513b920a4f7 ("ice: Update Tx scheduler tree for VSI multi-Tx
> queue support")
> 
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_sched.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com>


