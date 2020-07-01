From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 1 Jul 2020 17:01:38 +0000
Subject: [Intel-wired-lan] [PATCH v1 4/5] ixgbevf: use generic power
 management
In-Reply-To: <20200629092943.227910-5-vaibhavgupta40@gmail.com>
References: <20200629092943.227910-1-vaibhavgupta40@gmail.com>
 <20200629092943.227910-5-vaibhavgupta40@gmail.com>
Message-ID: <BN6PR1101MB2145E60BA3521C44510791B68C6C0@BN6PR1101MB2145.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH v1 4/5] ixgbevf: use generic power
> management
> 
> With legacy PM, drivers themselves were responsible for managing the
> device's power states and takes care of register states.
> 
> After upgrading to the generic structure, PCI core will take care of required
> tasks and drivers should do only device-specific operations.
> 
> The driver was invoking PCI helper functions like pci_save/restore_state(),
> and pci_enable/disable_device(), which is not recommended.
> 
> Compile-tested only.
> 
> Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
> ---
>  .../net/ethernet/intel/ixgbevf/ixgbevf_main.c | 44 +++++--------------
>  1 file changed, 10 insertions(+), 34 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


