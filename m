From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 21 Apr 2017 18:07:51 +0000
Subject: [Intel-wired-lan] [next PATCH S71 03/10] i40e: amortize wait
 time	when disabling lots of VFs
In-Reply-To: <20170419132559.20459-3-alice.michael@intel.com>
References: <20170419132559.20459-1-alice.michael@intel.com>
 <20170419132559.20459-3-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DA1268@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alice Michael
> Sent: Wednesday, April 19, 2017 6:26 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S71 03/10] i40e: amortize wait time
> when disabling lots of VFs
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> Just as we do in i40e_reset_all_vfs, save some time when freeing VFs by
> amortizing the wait time for stopping queues. We can use
> i40e_vsi_stop_rings_no_wait() to begin the process of stopping all the VF
> rings at once. Then, once we've started the process on each VF we can begin
> waiting for the VFs to stop. This helps reduce the total wait time by a large
> factor.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


