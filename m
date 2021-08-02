From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Mon, 2 Aug 2021 20:46:00 +0000
Subject: [Intel-wired-lan] [PATCH net-next v2] ethernet/intel: fix
 PTP_1588_CLOCK dependencies
In-Reply-To: <CAK8P3a3P6=ZROxT8daW83mRp7z5rYAQydetWFXQoYF7Y5_KLHA@mail.gmail.com>
References: <20210802145937.1155571-1-arnd@kernel.org>
 <20210802164907.GA9832@hoboy.vegasvil.org>
 <bd631e36-1701-b120-a9b0-8825d14cc694@intel.com>
 <CAK8P3a3P6=ZROxT8daW83mRp7z5rYAQydetWFXQoYF7Y5_KLHA@mail.gmail.com>
Message-ID: <CO1PR11MB50892367410160A8364DBF69D6EF9@CO1PR11MB5089.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Arnd Bergmann <arnd@kernel.org>
> Sent: Monday, August 02, 2021 1:32 PM
> To: Keller, Jacob E <jacob.e.keller@intel.com>
> Cc: Richard Cochran <richardcochran@gmail.com>; Nicolas Pitre
> <nicolas.pitre@linaro.org>; Brandeburg, Jesse <jesse.brandeburg@intel.com>;
> Nguyen, Anthony L <anthony.l.nguyen@intel.com>; David S. Miller
> <davem@davemloft.net>; Jakub Kicinski <kuba@kernel.org>; Arnd Bergmann
> <arnd@arndb.de>; Kurt Kanzenbach <kurt@linutronix.de>; Saleem, Shiraz
> <shiraz.saleem@intel.com>; Ertman, David M <david.m.ertman@intel.com>;
> intel-wired-lan at lists.osuosl.org; netdev at vger.kernel.org; linux-
> kernel at vger.kernel.org
> Subject: Re: [PATCH net-next v2] ethernet/intel: fix PTP_1588_CLOCK
> dependencies
> 
> On Mon, Aug 2, 2021 at 9:54 PM Keller, Jacob E <jacob.e.keller@intel.com>
> wrote:
> >
> > So go back to "select"?
> >
> > It looks like Arnd proposed in the thread a solution that did a sort of
> > "please enable this" but still let you disable it.
> >
> > An alternative (unfortunately per-driver...) solution was to setup the
> > drivers so that they gracefully fall back to disabling PTP if the PTP
> > core support is not reachable.. but that obviously requires that drivers
> > do the right thing, and at least Intel drivers have not tested this
> > properly.
> >
> > I'm definitely in favor of removing "implies" entirely. The semantics
> > are unclear, and the fact that it doesn't handle the case of "i'm
> > builtin, so my implies can't be modules"...
> >
> > I don't really like the syntax of the double "depends on A || !A".. I'd
> > prefer if we had some keyword for this, since it would be more obvious
> > and not run against the standard logic (A || !A is a tautology!)
> 
> I think the main reason we don't have a keyword for it is that nobody
> so far has come up with an English word that expresses what it is
> supposed to mean.
> 

Right. I don't have a great example that's a single word either.

> You can do something like it for a particular symbol though, such as
> 
> config MAY_USE_PTP_1588_CLOCK
>        def_tristate PTP_1588_CLOCK || !PTP_1588_CLOCK
> 
>  config E1000E
>         tristate "Intel(R) PRO/1000 PCI-Express Gigabit Ethernet support"
>         depends on PCI && (!SPARC32 || BROKEN)
> +       depends on MAY_USE_PTP_1588_CLOCK
>         select CRC32
> -       imply PTP_1588_CLOCK

What about "integrates"?

Or.. what if we just changed "implies" to also include the dependencies automatically? i.e. "implies PTP_1588_CLOCK" also means the depends trick which ensures that you can't have it as module if this is built-in.

I.e. we still get the nice "this will turn on automatically in the menu if you enable this" and we enforce that you can't have it as a module since it would be a dependency if it's on"?

> 
> 
>           Arnd
