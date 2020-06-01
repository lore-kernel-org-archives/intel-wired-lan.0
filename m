From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Mon, 1 Jun 2020 17:15:54 +0000
Subject: [Intel-wired-lan] [PATCH v2] e1000: use generic power management
In-Reply-To: <20200525122710.25064-1-vaibhavgupta40@gmail.com>
References: <20200525122710.25064-1-vaibhavgupta40@gmail.com>
Message-ID: <DM6PR11MB2890EDBB6B1BE7705DF2AB3CBC8A0@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Vaibhav Gupta <vaibhavgupta40@gmail.com>
> Sent: Monday, May 25, 2020 5:27 AM
> To: Vaibhav Gupta <vaibhav.varodek@gmail.com>; Bjorn Helgaas
> <helgaas@kernel.org>; Bjorn Helgaas <bhelgaas@google.com>;
> bjorn at helgaas.com; Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; David S.
> Miller <davem@davemloft.net>; rjw at rjwysocki.net
> Cc: Vaibhav Gupta <vaibhavgupta40@gmail.com>; Brandeburg, Jesse
> <jesse.brandeburg@intel.com>; intel-wired-lan at lists.osuosl.org;
> netdev at vger.kernel.org; linux-kernel at vger.kernel.org; linux-kernel-
> mentees at lists.linuxfoundation.org; skhan at linuxfoundation.org
> Subject: [PATCH v2] e1000: use generic power management
> 
> compile-tested only
> 
> With legacy PM hooks, it was the responsibility of a driver to manage PCI
> states and also the device's power state. The generic approach is to let PCI
> core handle the work.
> 
> e1000_suspend() calls __e1000_shutdown() to perform intermediate tasks.
> __e1000_shutdown() modifies the value of "wake" (device should be wakeup
> enabled or not), responsible for controlling the flow of legacy PM.
> 
> Since, PCI core has no idea about the value of "wake", new code for generic
> PM may produce unexpected results. Thus, use "device_set_wakeup_enable()"
> to wakeup-enable the device accordingly.
> 
> Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
> ---
>  drivers/net/ethernet/intel/e1000/e1000_main.c | 49 +++++--------------
>  1 file changed, 13 insertions(+), 36 deletions(-)

I don't have many old PCI systems that handle power management properly before adding this patch.  However, the few ones that do continue to do so with the older e1000 parts I still have around.  So a small sample, but at least confirmed on _some_ real hardware
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
