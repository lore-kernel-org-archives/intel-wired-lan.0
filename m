From: Arnd Bergmann <arnd@kernel.org>
Date: Tue, 3 Aug 2021 19:00:49 +0200
Subject: [Intel-wired-lan] [PATCH net-next v2] ethernet/intel: fix
 PTP_1588_CLOCK dependencies
In-Reply-To: <20210803161434.GE32663@hoboy.vegasvil.org>
References: <20210802145937.1155571-1-arnd@kernel.org>
 <20210802164907.GA9832@hoboy.vegasvil.org>
 <bd631e36-1701-b120-a9b0-8825d14cc694@intel.com>
 <20210802230921.GA13623@hoboy.vegasvil.org>
 <CAK8P3a2XjgbEkYs6R7Q3RCZMV7v90gu_v82RVfFVs-VtUzw+_w@mail.gmail.com>
 <20210803155556.GD32663@hoboy.vegasvil.org>
 <20210803161434.GE32663@hoboy.vegasvil.org>
Message-ID: <CAK8P3a2Wt9gnO4Ts_4Jw1+qpBj8HQc50jU2szjmR8MmZL9wrgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Aug 3, 2021 at 6:14 PM Richard Cochran <richardcochran@gmail.com> wrote:
> On Tue, Aug 03, 2021 at 08:55:56AM -0700, Richard Cochran wrote:
> > On Tue, Aug 03, 2021 at 08:59:02AM +0200, Arnd Bergmann wrote:
> > > It may well be a lost cause, but a build fix is not the time to nail down
> > > that decision. The fix I proposed (with the added MAY_USE_PTP_1588_CLOCK
> > > symbol) is only two extra lines and leaves everything else working for the
> > > moment.
> >
> > Well, then we'll have TWO ugly and incomprehensible Kconfig hacks,
> > imply and MAY_USE.

I'm all in favor of removing imply elsewhere as well, but that needs much
broader consensus than removing it from PTP_1588_CLOCK.

It has already crept into cryto/ and sound/soc/codecs/, and at least in
the latter case it does seem to even make sense, so they are less
likely to remove it.

> > Can't we fix this once and for all?
> >
> > Seriously, "imply" has been nothing but a major PITA since day one,
> > and all to save 22 kb.  I can't think of another subsystem which
> > tolerates so much pain for so little gain.
>
> Here is what I want to have, in accordance with the KISS principle:
>
> config PTP_1588_CLOCK
>         bool "PTP clock support"
>         select NET
>         select POSIX_TIMERS
>         select PPS
>         select NET_PTP_CLASSIFY
>
> # driver variant 1:
>
> config ACME_MAC
>         select PTP_1588_CLOCK
>
> # driver variant 2:
>
> config ACME_MAC
>
> config ACME_MAC_PTP
>         depends on ACME_MAC
>         select PTP_1588_CLOCK
>
> Hm?

Selecting a subsystem (NET, POSIX_TIMES, PPS, NET_PTP_CLASSIFY)
from a device driver is the nightmare that 'imply' was meant to solve (but did
not): this causes dependency loops, and unintended behavior where you
end up accidentally enabling a lot more drivers than you actually need
(when other symbols depend on the selected ones, and default to y).

If you turn all those 'select' lines into 'depends on', this will work, but it's
not actually much different from what I'm suggesting. Maybe we can do it
in two steps: first fix the build failure by replacing all the 'imply'
statements
with the correct dependencies, and then you send a patch on top that
turns PPS and PTP_1588_CLOCK into bool options.

     Arnd
