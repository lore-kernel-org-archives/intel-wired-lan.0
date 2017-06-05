From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 5 Jun 2017 23:05:56 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: pci_set_drvdata must be
	called	before register_netdev
In-Reply-To: <12c75353-174a-d6de-27bc-83cebba68c13@suse.com>
References: <12c75353-174a-d6de-27bc-83cebba68c13@suse.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DAA4D3@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Jeff Mahoney
> Sent: Saturday, June 3, 2017 3:01 PM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] ixgbe: pci_set_drvdata must be called
> before register_netdev
> 
> We call pci_set_drvdata immediately after calling register_netdev, which
> leaves a window where tasks writing to the sriov_numvfs sysfs attribute can
> sneak in and crash the kernel.  register_netdev cleans up after itself so
> placing pci_set_drvdata immediately before it should preserve the intent of
> commit 0fb6a55cc31f (ixgbe: fix crash on rmmod after probe fail).
> 
> Fixes: 0fb6a55cc31f (ixgbe: fix crash on rmmod after probe fail)
> Signed-off-by: Jeff Mahoney <jeffm@suse.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


