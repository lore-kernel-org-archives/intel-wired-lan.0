From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 13 Jan 2016 19:13:05 +0000
Subject: [Intel-wired-lan] [next PATCH S26 06/12] i40e: fix: do not
 sleep in	netdev_ops
In-Reply-To: <1451932392-15538-7-git-send-email-deepthi.kavalur@intel.com>
References: <1451932392-15538-1-git-send-email-deepthi.kavalur@intel.com>
 <1451932392-15538-7-git-send-email-deepthi.kavalur@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9801D0@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Deepthi Kavalur
> Sent: Monday, January 04, 2016 10:33 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S26 06/12] i40e: fix: do not sleep in
> netdev_ops
> 
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> The driver was being called by vlan, bonding, teaming operations that
> expected to be able to hold locks like rcu_read_lock().
> 
> This causes the driver to be held to the requirement to not sleep, and was
> found by the kernel debug options for checking sleep inside critical section,
> and the locking validator.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Reviewed-by: Nelson, Shannon <shannon.nelson@intel.com>
> Change-ID: Ibc68c835f5ffa8ffe0638ffe910a66fc5649a7f7
> ---
> Testing-Hints:
> Add and remove vlan, over and under bonding and teaming driver, add and
> delete mac address, run debug kernel with lock validator.
> 
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied, no lock errors reported with lock validator
