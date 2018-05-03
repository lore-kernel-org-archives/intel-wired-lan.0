From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 3 May 2018 18:12:44 +0000
Subject: [Intel-wired-lan] [PATCH v3] ixgbe/ixgbevf: Free IRQ when PCI
 error recovery removes the device
In-Reply-To: <1525292788-22260-1-git-send-email-maurosr@linux.vnet.ibm.com>
References: <1525292788-22260-1-git-send-email-maurosr@linux.vnet.ibm.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1B75975E@ORSMSX106.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Mauro S. M. Rodrigues
> Sent: Wednesday, May 2, 2018 1:26 PM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; intel-wired-
> lan at lists.osuosl.org; alexander.duyck at gmail.com
> Cc: abdhalee at in.ibm.com; nbannoth at in.ibm.com
> Subject: [Intel-wired-lan] [PATCH v3] ixgbe/ixgbevf: Free IRQ when PCI error
> recovery removes the device
> 
> Since commit f7f37e7ff2b9 ("ixgbe: handle close/suspend race with
> netif_device_detach/present") ixgbe_close_suspend is called, from
> ixgbe_close, only if the device is present, i.e. if it isn't detached.
> That exposed a situation where IRQs weren't freed if a PCI error recovery
> system opts to remove the device. For such case the pci channel state is set
> to pci_channel_io_perm_failure and ixgbe_io_error_detected was returning
> PCI_ERS_RESULT_DISCONNECT before calling ixgbe_close_suspend
> consequentially not freeing IRQ and crashing when the remove handler calls
> pci_disable_device, hitting a BUG_ON at free_msi_irqs, which asserts that
> there is no non-free IRQ associated with the device to be removed:
> 
> BUG_ON(irq_has_action(entry->irq + i));
> 
> The issue is fixed by calling the ixgbe_close_suspend before evaluate the pci
> channel state.
> 
> Reported-by: Naresh Bannoth <nbannoth@in.ibm.com>
> Reported-by: Abdul Haleem <abdhalee@in.ibm.com>
> Signed-off-by: Mauro S. M. Rodrigues <maurosr@linux.vnet.ibm.com>
> ---
> v2: Extended the fix to ixgbevf driver.
> 
> v3: Improving the fix according to Alexander Duyck's review.
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c     | 6 +++---
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 6 +++---
>  2 files changed, 6 insertions(+), 6 deletions(-)


Tested-by: Andrew Bowers <andrewx.bowers@intel.com>

