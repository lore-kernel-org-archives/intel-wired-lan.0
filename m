From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Wed, 23 Oct 2019 02:09:41 +0000
Subject: [Intel-wired-lan] [next-queue PATCH v2 1/2] e1000e: Use
 rtnl_lock to prevent race conditions between net and pci/pm
In-Reply-To: <20191011153452.22313.70522.stgit@localhost.localdomain>
References: <20191011153219.22313.60179.stgit@localhost.localdomain>
 <20191011153452.22313.70522.stgit@localhost.localdomain>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B97154DF9@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: netdev-owner at vger.kernel.org <netdev-owner@vger.kernel.org>
> On Behalf Of Alexander Duyck
> Sent: Friday, October 11, 2019 8:35 AM
> To: alexander.h.duyck at linux.intel.com; intel-wired-lan at lists.osuosl.org;
> Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
> Cc: netdev at vger.kernel.org; zdai at us.ibm.com; zdai at linux.vnet.ibm.com
> Subject: [next-queue PATCH v2 1/2] e1000e: Use rtnl_lock to prevent race
> conditions between net and pci/pm
> 
> From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> 
> This patch is meant to address possible race conditions that can exist
> between network configuration and power management. A similar issue was
> fixed for igb in commit 9474933caf21 ("igb: close/suspend race in
> netif_device_detach").
> 
> In addition it consolidates the code so that the PCI error handling code
> will essentially perform the power management freeze on the device prior to
> attempting a reset, and will thaw the device afterwards if that is what it
> is planning to do. Otherwise when we call close on the interface it should
> see it is detached and not attempt to call the logic to down the interface
> and free the IRQs again.
> 
> >From what I can tell the check that was adding the check for
> __E1000_DOWN
> in e1000e_close was added when runtime power management was added.
> However
> it should not be relevant for us as we perform a call to
> pm_runtime_get_sync before we call e1000_down/free_irq so it should
> always
> be back up before we call into this anyway.
> 
> Reported-by: Morumuri Srivalli <smorumu1@in.ibm.com>
> Tested-by: David Dai <zdai@linux.vnet.ibm.com>
> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> ---
>  drivers/net/ethernet/intel/e1000e/netdev.c |   68 ++++++++++++++---------
> -----
>  1 file changed, 35 insertions(+), 33 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>

