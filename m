From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Sat, 2 Feb 2019 00:26:31 +0000
Subject: [Intel-wired-lan] [PATCH] intel-ethernet: warn when fatal read
 failure happens
In-Reply-To: <5f4afeda-a154-eff6-208e-85f789b8818d@intel.com>
References: <1547015454-77750-1-git-send-email-feng.tang@intel.com>
 <5f4afeda-a154-eff6-208e-85f789b8818d@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B96621315@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Neftin, Sasha
> Sent: Thursday, January 10, 2019 12:19 AM
> To: intel-wired-lan at osuosl.org
> Subject: Re: [Intel-wired-lan] [PATCH] intel-ethernet: warn when fatal read
> failure happens
> 
> On 1/9/2019 08:30, Feng Tang wrote:
> > Failed in read the HW register is very serious for igb/igc driver,
> > as its hw_addr will be set to NULL and cause the adapter be seen as
> > "REMOVED".
> >
> > We saw the error only a few times in the MTBF test for suspend/resume,
> > but can hardly get any useful info to debug.
> >
> > Adding WARN() so that we can get the necessary information about
> > where and how it happens, and use it for root causing and fixing
> > this "PCIe link lost issue"
> >
> > This affects igb, igc.
> >
> > Signed-off-by: Feng Tang <feng.tang@intel.com>
> > ---
> >   drivers/net/ethernet/intel/igb/igb_main.c | 1 +
> >   drivers/net/ethernet/intel/igc/igc_main.c | 1 +
> >   2 files changed, 2 insertions(+)

With the caveat of recognizing Sasha's suggestion to add a "\n"...
Tested-by: Aaron Brown <aaron.f.brown@intel.com>


