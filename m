From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 6 Nov 2015 17:51:31 +0000
Subject: [Intel-wired-lan] [next PATCH 1/2] i40e: fix: do not sleep
	in	netdev_ops
In-Reply-To: <1446771662-36705-1-git-send-email-jesse.brandeburg@intel.com>
References: <1446771662-36705-1-git-send-email-jesse.brandeburg@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060DD455@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Jesse Brandeburg
> Sent: Thursday, November 05, 2015 5:01 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH 1/2] i40e: fix: do not sleep in
> netdev_ops
> 
> The driver was being called by vlan, bonding, teaming operations that
> expected to be able to hold locks like rcu_read_lock().
> 
> This causes the driver to be held to the requirement to not sleep, and was
> found by the kernel debug options for checking sleep inside critical section,
> and the locking validator.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Change-ID: Ibc68c835f5ffa8ffe0638ffe910a66fc5649a7f7
> 
> ---
> 
> Testing Hints (required if no HSD): add and remove vlan, over and under
> bonding and teaming driver, add and delete mac address, run debug kernel
> with lock validator.
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 44 +++++++++++++------------
> ----
>  1 file changed, 20 insertions(+), 24 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied,  add/delete mac/vlan operations lock and unlock normally
