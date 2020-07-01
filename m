From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 1 Jul 2020 17:00:50 +0000
Subject: [Intel-wired-lan] [PATCH v1 3/5] ixgbe: use generic power
 management
In-Reply-To: <20200629092943.227910-4-vaibhavgupta40@gmail.com>
References: <20200629092943.227910-1-vaibhavgupta40@gmail.com>
 <20200629092943.227910-4-vaibhavgupta40@gmail.com>
Message-ID: <BN6PR1101MB2145F17248D73BF3C751F99E8C6C0@BN6PR1101MB2145.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH v1 3/5] ixgbe: use generic power
> management
> 
> With legacy PM hooks, it was the responsibility of a driver to manage PCI
> states and also the device's power state. The generic approach is to let PCI
> core handle the work.
> 
> ixgbe_suspend() calls __ixgbe_shutdown() to perform intermediate tasks.
> __ixgbe_shutdown() modifies the value of "wake" (device should be
> wakeup enabled or not), responsible for controlling the flow of legacy PM.
> 
> Since, PCI core has no idea about the value of "wake", new code for generic
> PM may produce unexpected results. Thus, use
> "device_set_wakeup_enable()"
> to wakeup-enable the device accordingly.
> 
> Compile-tested only.
> 
> Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 61 +++++--------------
>  1 file changed, 15 insertions(+), 46 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


