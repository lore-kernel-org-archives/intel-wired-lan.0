From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Wed, 24 Jun 2020 04:08:25 +0000
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Remove TCP segmentation
 TX fail counter
In-Reply-To: <e85dca2a-0fae-d8de-f367-21050b694c8d@intel.com>
References: <20200607085127.29281-1-sasha.neftin@intel.com>
 <DM6PR11MB2890FCA0CC2C4D5BB701DB3ABC950@DM6PR11MB2890.namprd11.prod.outlook.com>
 <e85dca2a-0fae-d8de-f367-21050b694c8d@intel.com>
Message-ID: <DM6PR11MB289068AB8C5E4328133CB236BC950@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Neftin, Sasha <sasha.neftin@intel.com>
> Sent: Tuesday, June 23, 2020 8:22 PM
> To: Brown, Aaron F <aaron.f.brown@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: Re: [Intel-wired-lan] [PATCH v1 1/1] igc: Remove TCP segmentation
> TX fail counter
> 
> On 6/24/2020 04:15, Brown, Aaron F wrote:
> >
> >> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of
> >> Sasha Neftin
> >> Sent: Sunday, June 7, 2020 1:51 AM
> >> To: intel-wired-lan at lists.osuosl.org
> >> Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Remove TCP segmentation
> TX
> >> fail counter
> >>
> >> TCP segmentation TX context fail counter is not
> >> applicable for i225 devices.
> >> This patch comes to clean up this counter.
> >
> >
> > With this patch include I am seeing what appears to be the removed
> counter when I look at ethtool stats.
> > ----
> > u1322:[0]/usr/src/kernels/next-queue> ethtool -S eth1|grep seg
> >       tx_tcp_seg_good: 857
> >       tx_tcp_seg_failed: 0
> > u1322:[0]/usr/src/kernels/next-queue>
> > ----
> >
> > Does something need to be done to strip the counter display?  Or am I just
> looking at a similar counter.
> It is ok. You look at right counter exposed by ethtool. I've removed the
> "TCP Segmentation Context Tx" register not applicable to the i225 device.

Thanks for the explanation.

> >>
> >> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> >> ---
> >>   drivers/net/ethernet/intel/igc/igc_mac.c  | 1 -
> >>   drivers/net/ethernet/intel/igc/igc_main.c | 1 -
> >>   drivers/net/ethernet/intel/igc/igc_regs.h | 1 -
> >>   3 files changed, 3 deletions(-)
> >>
Tested-by: Aaron Brown<aaron.f.brown@intel.com>

