From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Wed, 24 Apr 2019 02:14:35 +0000
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Cleanup the redundant code
In-Reply-To: <309B89C4C689E141A5FF6A0C5FB2118B97039325@ORSMSX103.amr.corp.intel.com>
References: <20190421081723.34232-1-sasha.neftin@intel.com>
 <309B89C4C689E141A5FF6A0C5FB2118B97039325@ORSMSX103.amr.corp.intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B9703933A@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Brown, Aaron F
> Sent: Tuesday, April 23, 2019 7:08 PM
> To: Neftin, Sasha <sasha.neftin@intel.com>; intel-wired-lan at lists.osuosl.org
> Subject: Re: [Intel-wired-lan] [PATCH v1 1/1] igc: Cleanup the redundant
> code
> 
> > From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> > Behalf Of Sasha Neftin
> > Sent: Sunday, April 21, 2019 1:17 AM
> > To: intel-wired-lan at lists.osuosl.org
> > Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Cleanup the redundant code
> >
> > The default flow control settings for the i225 device is both
> > 'rx' and 'tx' pause frames. There is no depend on the NVM value.
> > This patch comes to fix this and clean up the driver code.
> >
> > Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> > ---
> >  drivers/net/ethernet/intel/igc/igc_mac.c | 23 +++--------------------
> >  1 file changed, 3 insertions(+), 20 deletions(-)
> 
> Tested-by: Aaron Brown <aaron.f.brown@intel.com>

Ignore this, it was meant for a different igc patch with a similar title (Remove the obsolete workaround.)


