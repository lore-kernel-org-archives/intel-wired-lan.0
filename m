From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Mon, 27 Jan 2020 21:29:58 +0000
Subject: [Intel-wired-lan] [PATCH v1] e1000e: Add support to 0x15F5
 Device Id of Tiger Lake
In-Reply-To: <3b5bb66d-949e-e190-56c1-c067a2f3bb9b@intel.com>
References: <20200119100809.38869-1-vitaly.lifshits@intel.com>
 <309B89C4C689E141A5FF6A0C5FB2118B971CC4E7@ORSMSX103.amr.corp.intel.com>
 <3b5bb66d-949e-e190-56c1-c067a2f3bb9b@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B971CD843@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Lifshits, Vitaly <vitaly.lifshits@intel.com>
> Sent: Saturday, January 25, 2020 4:22 AM
> To: Brown, Aaron F <aaron.f.brown@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: Re: [Intel-wired-lan] [PATCH v1] e1000e: Add support to 0x15F5
> Device Id of Tiger Lake
> 
> On 1/25/2020 04:45, Brown, Aaron F wrote:
> >> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of
> >> Vitaly Lifshits
> >> Sent: Sunday, January 19, 2020 2:08 AM
> >> To: intel-wired-lan at lists.osuosl.org
> >> Subject: [Intel-wired-lan] [PATCH v1] e1000e: Add support to 0x15F5
> Device
> >> Id of Tiger Lake
> >>
> >> Added support to 0x15F5 Device ID which is part of Intel Tiger Lake
> >> Platforms. This patch follows commit:
> >> 776f5d57ee ("e1000e: Add support for Tiger Lake").
> >>
> >> Signed-off-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
> >> ---
> >>   drivers/net/ethernet/intel/e1000e/hw.h     | 1 +
> >>   drivers/net/ethernet/intel/e1000e/netdev.c | 1 +
> >>   2 files changed, 2 insertions(+)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>

> >>  <snip>
> >
> > Something seems to be missing.  After building and booting to the kernel
> with this patch included I do not see the 15f5 device from modinfo:
> > u1519:[1]/usr/src/kernels/next-queue> modinfo igc|grep -i 15f5
> > u1519:[1]/usr/src/kernels/next-queue>
> >
> 
> If I understand your test correctly, I think you should run:
>  > modinfo e1000e | grep -i 15f5
> 
> Since the patch is to e1000e module and not igc.
Yes of course, thanks.  End of a long week ://)

u1459:[1]/usr/src/kernels/next-queue> modinfo e1000e | grep -i 15f5
alias:          pci:v00008086d000015F5sv*sd*bc*sc*i*
u1459:[1]/usr/src/kernels/next-queue>
