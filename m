From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 16 Jul 2020 18:08:52 +0000
Subject: [Intel-wired-lan] [PATCH v1 2/5] igbvf: netdev: use generic
 power management
In-Reply-To: <20200629092943.227910-3-vaibhavgupta40@gmail.com>
References: <20200629092943.227910-1-vaibhavgupta40@gmail.com>
 <20200629092943.227910-3-vaibhavgupta40@gmail.com>
Message-ID: <DM6PR11MB28906BCEB8DF7B0F7B6C7B1ABC7F0@DM6PR11MB2890.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH v1 2/5] igbvf: netdev: use generic power
> management
> 
> Remove legacy PM callbacks and use generic operations. With legacy code,
> drivers were responsible for handling PCI PM operations like
> pci_save_state(). In generic code, all these hre andled by PCI core.
> 
> The generic suspend() and resume() are called at the same point the legacy
> ones were called. Thus, it does not affect the normal functioning of the
> driver.
> 
> __maybe_unused attribute is used with .resume() but not with .suspend(), as
> .suspend() is calleb by .shutdown().
> 
> Compile-tested only.
> 
> Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
> ---
>  drivers/net/ethernet/intel/igbvf/netdev.c | 37 +++++------------------
>  1 file changed, 8 insertions(+), 29 deletions(-)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
