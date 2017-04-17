From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 17 Apr 2017 17:31:44 +0000
Subject: [Intel-wired-lan] [next PATCH S70 09/12] i40e: reset all VFs
	in	parallel when rebuilding PF
In-Reply-To: <20170413084555.6962-9-alice.michael@intel.com>
References: <20170413084555.6962-1-alice.michael@intel.com>
 <20170413084555.6962-9-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1040BF07@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alice Michael
> Sent: Thursday, April 13, 2017 1:46 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S70 09/12] i40e: reset all VFs in parallel
> when rebuilding PF
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> When there are a lot of active VFs, it can take multiple seconds to finish
> resetting all of them during certain flows., which can cause some VFs to fail to
> wait long enough for the reset to occur. The user might see messages like
> "Never saw reset" or "Reset never finished" and the VF driver will stop
> functioning properly.
> 
> The naive solution would be to simply increase the wait timer. We can get
> much more clever. Notice that i40e_reset_vf is run in a serialized fashion,
> and includes lots of delays.
> 
> There are two prominent delays which take most of the time. First, when we
> begin resetting VFs, we have multiple 10ms delays which accrue because we
> reset each VF in a serial fashion. These delays accumulate to almost 4
> seconds when handling the maximum number of VFs (128).
> 
> Secondly, there is a massive 50ms delay for each time we disable queues on
> a VSI. This delay is necessary to allow HW to finish disabling queues before
> we restore functionality. However, just like with the first case, we are paying
> the cost for each VF, rather than disabling all VFs and waiting once.
> 
> Both of these can be fixed, but required some previous refactoring to handle
> the special case. First, we will need the i40e_vsi_wait_queues_disabled
> function which was previously DCB specific. Second, we will need to
> implement our own i40e_vsi_stop_rings_no_wait function which will handle
> the stopping of rings without the delays.
> 
> Finally, implement an i40e_reset_all_vfs function, which will first start the
> reset of all VFs, and pay the wait cost all at once, rather than serially waiting
> for each VF before we start processing then next one. After the VF has been
> reset, we'll disable all the VF queues, and then wait for them to disable.
> Again, we'll organize the flow such that we pay the wait cost only once.
> 
> Finally, after we've disabled queues we'll go ahead and begin restoring VF
> functionality. The result is reducing the wait time by a large factor and
> ensuring that VFs do not timeout when waiting in the VF driver.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Change-ID: Ia6e8cf8d98131b78aec89db78afb8d905c9b12be
> ---
> Testing-hints:
>   "time echo 1 > /sys/class/net/<enpX>/device/reset" will trigger
>   a request for a reset in the driver. I used the "time" command to
>   measure how long it took for the reset to finish.
> 
>  drivers/net/ethernet/intel/i40e/i40e.h             |   2 +
>  drivers/net/ethernet/intel/i40e/i40e_main.c        |  32 +++++--
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 100
> +++++++++++++++++++++
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h |   1 +
>  4 files changed, 129 insertions(+), 6 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


