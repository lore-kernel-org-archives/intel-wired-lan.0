From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 31 Jan 2017 19:29:27 +0000
Subject: [Intel-wired-lan] [next PATCH S58-V3 4/4] i40e: don't add
	more	vectors to num_lan_msix than number of CPUs
In-Reply-To: <1485282241-3579-4-git-send-email-bimmy.pujari@intel.com>
References: <1485282241-3579-1-git-send-email-bimmy.pujari@intel.com>
 <1485282241-3579-4-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA5D781@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Tuesday, January 24, 2017 10:24 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S58-V3 4/4] i40e: don't add more
> vectors to num_lan_msix than number of CPUs
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> This is a solution to avoid adding too many queues to num_lan_msix.
> A recent refactor of queue pairs accidentally added all remaining vectors to
> the num_lan_msix which can have adverse performance issues, due to
> enabling more queues than the number of CPU cores.
> 
> This patch removes the old calculation, and replaces it with a simple
> algorithm.
> 
> 1) add queue pairs up to num_online_cpus(), but capped at half of total
>    vectors
> 2) then add alternative features such as flow directory and similar
> 3) finally, add the remaining vectors back to queue pairs, but capped
>    such that the total number of queue pairs does not exceed
>    num_online_cpus().
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
> Signed-off-by: Carolyn Wyborny <carolyn.wyborny@intel.com>
> Change-ID: I668abf67d5011a1248866daba8885f4ff00cb8d9
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 30
> ++++++++++++++++++++++++++---
>  1 file changed, 27 insertions(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


