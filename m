From: Chen Yu <yu.c.chen@intel.com>
Date: Tue, 16 Jun 2020 15:01:01 +0800
Subject: [Intel-wired-lan] [PATCH 1/2] e1000e: Do not wake up the system
 via WOL if device wakeup is disabled
In-Reply-To: <SN6PR11MB2896298A90B37CEA0DC5A750BC9C0@SN6PR11MB2896.namprd11.prod.outlook.com>
References: <cover.1590081982.git.yu.c.chen@intel.com>
 <9f7ede2e2e8152704258fc11ba3755ae93f50741.1590081982.git.yu.c.chen@intel.com>
 <SN6PR11MB2896298A90B37CEA0DC5A750BC9C0@SN6PR11MB2896.namprd11.prod.outlook.com>
Message-ID: <20200616070101.GA24567@chenyu-office.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Jun 16, 2020 at 02:51:27AM +0800, Brown, Aaron F wrote:
> > From: Chen Yu <yu.c.chen@intel.com>
> > Sent: Thursday, May 21, 2020 10:59 AM
> > To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; David S. Miller
> > <davem@davemloft.net>; Jakub Kicinski <kuba@kernel.org>; Kok, Auke-jan H
> > <auke-jan.h.kok@intel.com>; Jeff Garzik <jeff@garzik.org>
> > Cc: intel-wired-lan at lists.osuosl.org; netdev at vger.kernel.org; linux-
> > kernel at vger.kernel.org; Brown, Len <len.brown@intel.com>; Rafael J. Wysocki
> > <rjw@rjwysocki.net>; Shevchenko, Andriy <andriy.shevchenko@intel.com>;
> > Neftin, Sasha <sasha.neftin@intel.com>; Lifshits, Vitaly
> > <vitaly.lifshits@intel.com>; Chen, Yu C <yu.c.chen@intel.com>;
> > Stable at vger.kernel.org
> > Subject: [PATCH 1/2] e1000e: Do not wake up the system via WOL if device
> > wakeup is disabled
> >
> > Currently the system will be woken up via WOL(Wake On Lan) even if the
> > device wakeup ability has been disabled via sysfs:
> >  cat /sys/devices/pci0000:00/0000:00:1f.6/power/wakeup
> >  disabled
> >
> > The system should not be woken up if the user has explicitly
> > disabled the wake up ability for this device.
> >
> > This patch clears the WOL ability of this network device if the
> > user has disabled the wake up ability in sysfs.
> >
> > Fixes: bc7f75fa9788 ("[E1000E]: New pci-express e1000 driver")
> > Reported-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Cc: <Stable@vger.kernel.org>
> > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > ---
> >  drivers/net/ethernet/intel/e1000e/netdev.c | 14 ++++++++++----
> >  1 file changed, 10 insertions(+), 4 deletions(-)
> >
> Tested-by: Aaron Brown <aaron.f.brown@intel.com>
> 
Thanks for testing, Aaron.

Best,
Chenyu
