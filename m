From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 13 Feb 2019 18:57:41 +0000
Subject: [Intel-wired-lan] [next PATCH S2-V2 01/12] i40e: Queues are
 reserved despite "Invalid argument" error.
In-Reply-To: <20190206230826.24970-1-alice.michael@intel.com>
References: <20190206230826.24970-1-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D365F1E@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Wednesday, February 6, 2019 3:08 PM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Ludkiewicz, Adam <adam.ludkiewicz@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S2-V2 01/12] i40e: Queues are
> reserved despite "Invalid argument" error.
> 
> From: Adam Ludkiewicz <adam.ludkiewicz@intel.com>
> 
> Added a new local variable in the i40e_setup_tc function named
> old_queue_pairs so num_queue_pairs can be restored to the correct value
> in case configuring queue channels fails. Additionally, moved the exit label in
> the i40e_setup_tc function so the if (need_reset) block can be executed.
> Also, fixed data packing in the i40e_setup_tc function.
> 
> Signed-off-by: Adam Ludkiewicz <adam.ludkiewicz@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 3 +++
>  1 file changed, 3 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


