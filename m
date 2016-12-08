From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 8 Dec 2016 15:55:06 +0000
Subject: [Intel-wired-lan] [PATCH v3] ixgbe: handle close/suspend race
 with netif_device_detach/present
In-Reply-To: <20161111180747.17123.27924.stgit@localhost6.localdomain6>
References: <20161111180747.17123.27924.stgit@localhost6.localdomain6>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA39A2E@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Emil Tantilov
> Sent: Friday, November 11, 2016 10:08 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v3] ixgbe: handle close/suspend race with
> netif_device_detach/present
> 
> When an interface is part of a namespace it is possible that
> ixgbe_close() may be called while __ixgbe_shutdown() is running which ends
> up in a double free WARN and/or a BUG in free_msi_irqs().
> 
> To handle this situation we extend the rtnl_lock() to protect the call to
> netif_device_detach() and ixgbe_clear_interrupt_scheme() in
> __ixgbe_shutdown() and check for netif_device_present() to avoid clearing
> the interrupts second time in ixgbe_close();
> 
> Also extend the rtnl lock in ixgbe_resume() to netif_device_attach().
> 
> v2 - add rtnl locks and a check in ixgbe_remove()
> 
> v3 - remove the check in ixgbe_remove(), I will submit a separate patch to
> address the case of failed PCIe error recovery
> 
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


