From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 30 Oct 2017 22:02:39 +0000
Subject: [Intel-wired-lan] [next PATCH S81-V3 2/9] i40evf: don't rely
	on	netif_running() outside rtnl_lock()
In-Reply-To: <20171027150656.68250-2-alice.michael@intel.com>
References: <20171027150656.68250-1-alice.michael@intel.com>
 <20171027150656.68250-2-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EADC3D@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Friday, October 27, 2017 8:07 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S81-V3 2/9] i40evf: don't rely on
> netif_running() outside rtnl_lock()
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> In i40evf_reset_task we use netif_running() to determine whether or not
> the device is currently up. This allows us to properly free queue memory and
> shut down things before we request the hardware reset.
> 
> It turns out that we cannot be guaranteed of netif_running() returning false
> until the device is fully up, as the kernel core code sets __LINK_STATE_START
> prior to calling .ndo_open. Since we're not holding the rtnl_lock(), it's
> possible that the driver's i40evf_open handler function is currently being
> called while we're resetting.
> 
> We can't simply hold the rtnl_lock() while checking netif_running() as this
> could cause a deadlock with the i40evf_open() function.
> Additionally, we can't avoid the deadlock by holding the rtnl_lock() over the
> whole reset path, as this essentially serializes all resets, and can cause
> massive delays if we have multiple VFs on a system.
> 
> Instead, lets just check our own internal state __I40EVF_RUNNING state
> field. This allows us to ensure that the state is correct and is only set after
> we've finished bringing the device up.
> 
> Without this change we might free data structures about device queues and
> other memory before they've been fully allocated.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c | 20
> +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


