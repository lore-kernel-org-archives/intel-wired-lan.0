From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 8 Dec 2016 15:55:23 +0000
Subject: [Intel-wired-lan] [PATCH v4] ixgbevf: handle race between close
 and suspend on shutdown
In-Reply-To: <20161111181251.17498.91161.stgit@localhost6.localdomain6>
References: <20161111181251.17498.91161.stgit@localhost6.localdomain6>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA39A3B@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Emil Tantilov
> Sent: Friday, November 11, 2016 10:13 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v4] ixgbevf: handle race between close and
> suspend on shutdown
> 
> When an interface is part of a namespace it is possible that
> ixgbevf_close() may be called while ixgbevf_suspend() is running which ends
> up in a double free WARN and/or a BUG in free_msi_irqs()
> 
> To handle this situation we extend the rtnl_lock() to protect the call to
> netif_device_detach() and check for !netif_device_present() to avoid
> entering close while in suspend.
> 
> Also added rtnl locks to ixgbevf_queue_reset_subtask().
> 
> -v2 handle the race with netif_device_detach/present() and rtnl locks as
> suggested by Alex Duyck
> 
> -v3 add rtnl locks and check in ixgbevf_remove()
> 
> -v4 revert the ixgbevf_remove() changes from v3, I will submit a separate
> patch to deal with the PCIe AER issue on failed recovery
> 
> CC: Alexander Duyck <alexander.h.duyck@intel.com>
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |   11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


