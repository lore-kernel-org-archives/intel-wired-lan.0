From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 1 Jul 2020 16:59:47 +0000
Subject: [Intel-wired-lan] [PATCH v1 1/5] iavf: use generic power
 management
In-Reply-To: <20200629092943.227910-2-vaibhavgupta40@gmail.com>
References: <20200629092943.227910-1-vaibhavgupta40@gmail.com>
 <20200629092943.227910-2-vaibhavgupta40@gmail.com>
Message-ID: <BN6PR1101MB21456FB6DC435BF22390B8478C6C0@BN6PR1101MB2145.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
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
> skhan at linuxfoundation.org; linux-kernel-
> mentees at lists.linuxfoundation.org
> Subject: [Intel-wired-lan] [PATCH v1 1/5] iavf: use generic power
> management
> 
> With the support of generic PM callbacks, drivers no longer need to use
> legacy .suspend() and .resume() in which they had to maintain PCI states
> changes and device's power state themselves. The required operations are
> done by PCI core.
> 
> PCI drivers are not expected to invoke PCI helper functions like
> pci_save/restore_state(), pci_enable/disable_device(),
> pci_set_power_state(), etc. Their tasks are completed by PCI core itself.
> 
> Compile-tested only.
> 
> Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
> ---
>  drivers/net/ethernet/intel/iavf/iavf_main.c | 45 ++++++---------------
>  1 file changed, 12 insertions(+), 33 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


