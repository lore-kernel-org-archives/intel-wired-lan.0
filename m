From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 8 Jun 2017 18:09:13 +0000
Subject: [Intel-wired-lan] [next PATCH S72-V3 01/13] i40evf:
	assign	num_active_queues inside i40evf_alloc_queues
In-Reply-To: <20170607094313.32060-1-alice.michael@intel.com>
References: <20170607094313.32060-1-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DAA8A9@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Wednesday, June 7, 2017 2:43 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S72-V3 01/13] i40evf: assign
> num_active_queues inside i40evf_alloc_queues
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> The variable num_active_queues represents the number of active queues
> we have for the device. We assign this pretty early in i40evf_init_subtask.
> 
> Several code locations are written with loops over the tx_rings and rx_rings
> structures, which don't get allocated until i40evf_alloc_queues, and which
> get freed by i40evf_free_queues.
> 
> These call sites were written under the assumption that tx_rings and rx_rings
> would always be allocated at least when num_active_queues is non-zero.
> 
> Lets fix this by moving the assignment into the function where we allocate
> queues. We'll use a temporary variable for storage so that we don't assign
> the value in the adapter structure until after the rings have been set up.
> 
> Finally, when we free the queues, we'll clear the value to ensure that we do
> not loop over the rings memory that no longer exists.
> 
> This resolves a possible NULL pointer derference in i40evf_get_ethtool_stats
> which could occur if the VF fails to recover from a reset, and then a user
> requests statistics.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


