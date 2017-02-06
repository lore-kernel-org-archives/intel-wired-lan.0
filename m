From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Mon, 6 Feb 2017 23:20:36 +0000
Subject: [Intel-wired-lan] [next PATCH v3 6/9] igb: Add support for
 padding packet
In-Reply-To: <CAKgT0UcEdhJ_sAWgk4Enaa2TsnjoupqQZwHOV7F4CAi1=3cPVQ@mail.gmail.com>
References: <20170123165647.13402.1254.stgit@localhost.localdomain>
 <20170123165906.13402.80385.stgit@localhost.localdomain>
 <309B89C4C689E141A5FF6A0C5FB2118B8C588006@ORSMSX101.amr.corp.intel.com>
 <CAKgT0Uf2uZZOgX_2w7bpBbuFv4_VcTAJ0GnWyZAejEVVvtKBdA@mail.gmail.com>
 <309B89C4C689E141A5FF6A0C5FB2118B8C5887B6@ORSMSX101.amr.corp.intel.com>
 <CAKgT0UcEdhJ_sAWgk4Enaa2TsnjoupqQZwHOV7F4CAi1=3cPVQ@mail.gmail.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B8C58964B@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Alexander Duyck [mailto:alexander.duyck at gmail.com]
> Sent: Sunday, February 5, 2017 8:45 PM
> To: Brown, Aaron F <aaron.f.brown@intel.com>
> Cc: intel-wired-lan at lists.osuosl.org; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>
> Subject: Re: [Intel-wired-lan] [next PATCH v3 6/9] igb: Add support for
> padding packet
> 
> On Fri, Feb 3, 2017 at 4:39 PM, Brown, Aaron F <aaron.f.brown@intel.com>
> wrote:
> >> From: Alexander Duyck [mailto:alexander.duyck at gmail.com]
> >> Sent: Friday, February 3, 2017 9:58 AM
> >> To: Brown, Aaron F <aaron.f.brown@intel.com>
> >> Cc: intel-wired-lan at lists.osuosl.org; Kirsher, Jeffrey T
> >> <jeffrey.t.kirsher@intel.com>
> >> Subject: Re: [Intel-wired-lan] [next PATCH v3 6/9] igb: Add support for
> >> padding packet
> >>
> >> On Thu, Feb 2, 2017 at 8:01 PM, Brown, Aaron F
> <aaron.f.brown@intel.com>
> >> wrote:
> >> >> From: Intel-wired-lan [mailto:intel-wired-lan-
> bounces at lists.osuosl.org]
> >> On
> >> >> Behalf Of Alexander Duyck
> >> >> Sent: Monday, January 23, 2017 8:59 AM
> >> >> To: intel-wired-lan at lists.osuosl.org; Kirsher, Jeffrey T
> >> >> <jeffrey.t.kirsher@intel.com>
> >> >> Subject: [Intel-wired-lan] [next PATCH v3 6/9] igb: Add support for
> >> padding
> >> >> packet
> >> >>
> >> >> From: Alexander Duyck <alexander.h.duyck@intel.com>
> >> >>
> >> >> With the size of the frame limited we can now write to an offset within
> >> the
> >> >> buffer instead of having to write at the very start of the buffer.  The
> >> >> advantage to this is that it allows us to leave padding room for things
> >> >> like supporting XDP in the future.
> >> >>
> >> >> One side effect of this patch is that we can end up using a larger buffer
> >> >> if jumbo frames is enabled.  The impact shouldn't be too great, but it
> >> >> could hurt small packet performance for UDP workloads if jumbo
> frames
> >> is
> >> >> enabled as the truesize of frames will be larger.
> >> >>
> >> >> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> >> >> ---
> >> >>

<snip>

> >>
> >> Well one thing you might try doing is running "ethtool
> >> --set-priv-flags <ethX> legacy-rx on" and seeing if you have the same
> >> problem or not.  Turning on legacy Rx with this patch applied should
> >> only have the effect of adding padding to the front of the frame and
> >> will help to eliminate some of the code as being potentially
> >> responsible for this.
> >
> > Well, I had wiped the old system before I got this message, but after
> rebuilding I still get a dump from running the same netperf_stress test.  The
> trace has changed to a GPF and if I turn on legacy RX as you suggested
> netperf_stress continues to run fine and I do NOT get the dump.  Here is a
> copy of the latest dump I got when running netperf_stress (and with legacy
> RX off.):
> 
> Okay so that gives me a bit to go on.  If I am not mistaken that
> system has support for VTd, do you have that enabled in your kernel or
> is it disabled?

Yes, the system is supposed to be capable of VTd, it was disable in BIOS and kernel when I was running into this last week.  I enabled in BIOS and added the intel_iommu=on line to the boot stanza and am still seeing the dump when I run it.
> 
> What I did is break the patch up into smaller steps.  If possible try
> the v4 set and if you still see the issue I would recommend trying a
> bisection between patches 6 and 10 to see at which point the issue
> starts to occur.  My theory is it will either be patch 7 or patch 10.
> The others shouldn't have an impact but it doesn't hurt to verify it.

Will do...

> 
> If nothing else I can probably come by the lab on Tuesday to take a
> look in person and do some further debugging.
> 
> Thanks.
> 
> - Alex
