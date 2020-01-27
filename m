From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Mon, 27 Jan 2020 21:31:53 +0000
Subject: [Intel-wired-lan] [PATCH v3] e1000e: Add support for Alder Lake
In-Reply-To: <835b1769-42e3-f8f2-fc5f-ed811328e3e2@intel.com>
References: <20200119115713.12710-1-sasha.neftin@intel.com>
 <309B89C4C689E141A5FF6A0C5FB2118B971CC502@ORSMSX103.amr.corp.intel.com>
 <835b1769-42e3-f8f2-fc5f-ed811328e3e2@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B971CD85C@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Neftin, Sasha <sasha.neftin@intel.com>
> Sent: Saturday, January 25, 2020 11:51 PM
> To: Brown, Aaron F <aaron.f.brown@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: Re: [Intel-wired-lan] [PATCH v3] e1000e: Add support for Alder Lake
> 
> On 1/25/2020 04:50, Brown, Aaron F wrote:
> >> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of
> >> Sasha Neftin
> >> Sent: Sunday, January 19, 2020 3:57 AM
> >> To: intel-wired-lan at lists.osuosl.org
> >> Subject: [Intel-wired-lan] [PATCH v3] e1000e: Add support for Alder Lake
> >>
> >> Add devices ID's for the next LOM generations that will be
> >> available on the next Intel Client platform (Alder Lake)
> >> This patch provides the initial support for these devices
> >>
> >> v1->v2:
> >> Address community comments
> >> v2->v3:
> >> Fix minor typo
> >>
> >> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> >> ---
> >>   drivers/net/ethernet/intel/e1000e/ethtool.c | 2 ++
> >>   drivers/net/ethernet/intel/e1000e/hw.h      | 5 +++++
> >>   drivers/net/ethernet/intel/e1000e/ich8lan.c | 7 +++++++
> >>   drivers/net/ethernet/intel/e1000e/netdev.c  | 6 ++++++
> >>   drivers/net/ethernet/intel/e1000e/ptp.c     | 1 +
> >>   5 files changed, 21 insertions(+)
> >>

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
> >> <snip>
...
> > Something seems to be missing.  After building and booting to the kernel
> with this patch included I do not see the a 1a1e, 1a1f, 1a1c or 1a1d device
> from modinfo:
> > u1519:[1]/usr/src/kernels/next-queue> modinfo igc|grep -i 1a1
> > u1519:[1]/usr/src/kernels/next-queue>
> >
> you might run run modinfo e1000e | grep -i 0x1a1*

Yes of course, thanks.  End of a long week ://)

u1459:[1]/usr/src/kernels/next-queue> modinfo e1000e | grep -i 1a1
alias:          pci:v00008086d00001A1Dsv*sd*bc*sc*i*
alias:          pci:v00008086d00001A1Csv*sd*bc*sc*i*
alias:          pci:v00008086d00001A1Fsv*sd*bc*sc*i*
alias:          pci:v00008086d00001A1Esv*sd*bc*sc*i*
u1459:[1]/usr/src/kernels/next-queue>
