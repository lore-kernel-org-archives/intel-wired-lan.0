From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 16 Jul 2020 18:21:09 +0000
Subject: [Intel-wired-lan] [PATCH v1 5/5] e100: use generic power
 management
In-Reply-To: <20200629092943.227910-6-vaibhavgupta40@gmail.com>
References: <20200629092943.227910-1-vaibhavgupta40@gmail.com>
 <20200629092943.227910-6-vaibhavgupta40@gmail.com>
Message-ID: <DM6PR11MB2890D1376FC0E846C455E87DBC7F0@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Vaibhav Gupta
> Sent: Monday, June 29, 2020 2:30 AM
> To: Bjorn Helgaas <helgaas@kernel.org>; Bjorn Helgaas
> <bhelgaas@google.com>; bjorn at helgaas.com; Vaibhav Gupta
> <vaibhav.varodek@gmail.com>; David S. Miller <davem@davemloft.net>;
> Jakub Kicinski <kuba@kernel.org>; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>
> Cc: Vaibhav Gupta <vaibhavgupta40@gmail.com>; netdev at vger.kernel.org;
> linux-kernel at vger.kernel.org; intel-wired-lan at lists.osuosl.org;
> skhan at linuxfoundation.org; linux-kernel-mentees at lists.linuxfoundation.org
> Subject: [Intel-wired-lan] [PATCH v1 5/5] e100: use generic power management
> 
> With legacy PM hooks, it was the responsibility of a driver to manage PCI
> states and also the device's power state. The generic approach is to let
> PCI core handle the work.
> 
> e100_suspend() calls __e100_shutdown() to perform intermediate tasks.
> __e100_shutdown() calls pci_save_state() which is not recommended.
> 
> e100_suspend() also calls __e100_power_off() which is calling PCI helper
> functions, pci_prepare_to_sleep(), pci_set_power_state(), along with
> pci_wake_from_d3(...,false). Hence, the functin call is removed and wol is
> disabled as earlier using device_wakeup_disable().
> 
> Compile-tested only.
> 
> Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
> ---
>  drivers/net/ethernet/intel/e100.c | 31 +++++++++++++------------------
>  1 file changed, 13 insertions(+), 18 deletions(-)

I do have several e100 based adapters still working and a few old systems with plain old PCI that still function, however all of these older systems have broken power management.  Regardless of if I use the kernel before or after this patch is applied, or even if the e100 driver is loaded or not I can't get a reliable suspend / resume cycle to work on them.

I did run some basic regression with this patch against the remaining pro100 cards I could scrounge up and aside from broken power management (again with or without patch) the system seems good, so (hesitantly) from a regression perspective I will go ahead and say...
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
