From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Wed, 24 Jun 2020 04:09:19 +0000
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Add LPI counters
In-Reply-To: <5a821cd7-cd51-6725-34a3-2c4322ed35ba@intel.com>
References: <20200604112516.44949-1-sasha.neftin@intel.com>
 <DM6PR11MB2890D64AD6055EB780EF3885BC950@DM6PR11MB2890.namprd11.prod.outlook.com>
 <5a821cd7-cd51-6725-34a3-2c4322ed35ba@intel.com>
Message-ID: <DM6PR11MB2890D9D0EF6CBD2B0168BA88BC950@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Neftin, Sasha <sasha.neftin@intel.com>
> Sent: Tuesday, June 23, 2020 8:24 PM
> To: Brown, Aaron F <aaron.f.brown@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: Re: [Intel-wired-lan] [PATCH v1 1/1] igc: Add LPI counters
> 
> On 6/24/2020 04:05, Brown, Aaron F wrote:
> >> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of
> >> Sasha Neftin
> >> Sent: Thursday, June 4, 2020 4:25 AM
> >> To: intel-wired-lan at lists.osuosl.org
> >> Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Add LPI counters
> >>
> >> Add EEE TX LPI and EEE RX LPI counters. A EEE TX LPI event
> >> occurs when the transmitter enters EEE (IEEE 802.3az) LPI
> >> state. A EEE RX LPI event ocuurs when the receiver detect
> >> link partner entry into EEE(IEEE 802.3az) LPI state.
> >
> > Are these counters exposed anywhere I can view them?
> Just added relevant LPI registers. EEE support only in initial phase,
> many stuff will be added later.
Ok, thanks.
Tested-by: Aaron Brown <aaron.f.brown@intel.com>

