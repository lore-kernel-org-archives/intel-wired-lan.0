From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 4 Oct 2016 17:27:35 +0000
Subject: [Intel-wired-lan] [PATCH net] i40e: disable MSI-X interrupts if
 we	cannot reserve enough vectors
In-Reply-To: <1474549438-27468-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
References: <1474549438-27468-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA0F799@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Guilherme G. Piccoli
> Sent: Thursday, September 22, 2016 6:04 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: netdev at vger.kernel.org; gpiccoli at linux.vnet.ibm.com
> Subject: [Intel-wired-lan] [PATCH net] i40e: disable MSI-X interrupts if we
> cannot reserve enough vectors
> 
> If we fail on allocating enough MSI-X interrupts, we should disable them
> since they were previously enabled in this point of code.
> 
> Not disabling them can lead to WARN_ON() being triggered and subsequent
> failure in enabling MSI as a fallback; the below message was shown without
> this patch while we played with interrupt allocation in i40e driver:
> 
> [ 21.461346] sysfs: cannot create duplicate filename
> '/devices/pci0007:00/0007:00:00.0/0007:01:00.3/msi_irqs'
> [ 21.461459] ------------[ cut here ]------------ [ 21.461514] WARNING: CPU: 64
> PID: 1155 at fs/sysfs/dir.c:31 sysfs_warn_dup+0x88/0xc0
> 
> Also, we noticed that without this patch, if we modprobe the module
> without enough MSI-X interrupts (triggering the above warning), unload the
> module and re-load it again, we got a crash on the system.
> 
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 1 +
>  1 file changed, 1 insertion(+)

[net] i40e: disable MSI-X interrupts if we cannot reserve enough vectors
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


