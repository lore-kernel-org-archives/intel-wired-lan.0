From: Dave Airlie <airlied@gmail.com>
Date: Wed, 28 Jun 2017 05:28:42 +1000
Subject: [Intel-wired-lan] [PATCH v2 1/1] e1000e: Undo e1000e_pm_freeze
 if __e1000_shutdown fails
In-Reply-To: <20170620084958.7fxdn57p3o6eexbj@phenom.ffwll.local>
References: <20170531.110833.1362264472730468352.davem@davemloft.net>
 <20170531155043.3596-1-jani.nikula@intel.com>
 <20170531155043.3596-2-jani.nikula@intel.com>
 <20170602.141426.713378366601051907.davem@davemloft.net>
 <1496781986.86439.3.camel@intel.com>
 <309B89C4C689E141A5FF6A0C5FB2118B8C61D137@ORSMSX101.amr.corp.intel.com>
 <20170620084958.7fxdn57p3o6eexbj@phenom.ffwll.local>
Message-ID: <CAPM=9tzdpEDoMNYj7Z_ZM3Z0JsCpjfNW1Z+y-1p5z3HssJ5aaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 20 June 2017 at 18:49, Daniel Vetter <daniel@ffwll.ch> wrote:
> On Wed, Jun 07, 2017 at 01:07:33AM +0000, Brown, Aaron F wrote:
>> > From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On Behalf
>> > Of Jeff Kirsher
>> > Sent: Tuesday, June 6, 2017 1:46 PM
>> > To: David Miller <davem@davemloft.net>; Nikula, Jani
>> > <jani.nikula@intel.com>
>> > Cc: Ursulin, Tvrtko <tvrtko.ursulin@intel.com>; daniel.vetter at ffwll.ch; intel-
>> > gfx at lists.freedesktop.org; linux-kernel at vger.kernel.org;
>> > jani.nikula at linux.intel.com; chris at chris-wilson.co.uk; Ertman, David M
>> > <david.m.ertman@intel.com>; intel-wired-lan at lists.osuosl.org; dri-
>> > devel at lists.freedesktop.org; netdev at vger.kernel.org; airlied at gmail.com
>> > Subject: Re: [Intel-wired-lan] [PATCH v2 1/1] e1000e: Undo
>> > e1000e_pm_freeze if __e1000_shutdown fails
>> >
>> > On Fri, 2017-06-02 at 14:14 -0400, David Miller wrote:
>> > > From: Jani Nikula <jani.nikula@intel.com>
>> > > Date: Wed, 31 May 2017 18:50:43 +0300
>> > >
>> > > > From: Chris Wilson <chris@chris-wilson.co.uk>
>> > > >
>> > > > An error during suspend (e100e_pm_suspend),
>> > >
>> > >  ...
>> > > > lead to complete failure:
>> > >
>> > >  ...
>> > > > The unwind failures stems from commit 2800209994f8 ("e1000e:
>> > > > Refactor PM
>> > > > flows"), but it may be a later patch that introduced the non-
>> > > > recoverable
>> > > > behaviour.
>> > > >
>> > > > Fixes: 2800209994f8 ("e1000e: Refactor PM flows")
>> > > > Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=99847
>> > > > Cc: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
>> > > > Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
>> > > > Cc: Dave Ertman <davidx.m.ertman@intel.com>
>> > > > Cc: Bruce Allan <bruce.w.allan@intel.com>
>> > > > Cc: intel-wired-lan at lists.osuosl.org
>> > > > Cc: netdev at vger.kernel.org
>> > > > Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
>> > > > [Jani: bikeshed repainted]
>> > > > Signed-off-by: Jani Nikula <jani.nikula@intel.com>
>> > >
>> > > Jeff, please make sure this gets submitted to me soon.
>> >
>> > Expect it later tonight, just finishing up testing.
>>
>> Tested-by: Aaron Brown <aaron.f.brown@intel.com>
>
> Hm, I seem to be blind, but I can't find it anywhere in -rc6. Does someone
> have the sha1 from Linus' git for this patch?

Guys this is a pretty serious regression, just left blowing in the
wind, is anyone responsible for e1000e?

Dave.
