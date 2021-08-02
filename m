From: Arnd Bergmann <arnd@kernel.org>
Date: Mon, 2 Aug 2021 22:59:20 +0200
Subject: [Intel-wired-lan] [PATCH net-next v2] ethernet/intel: fix
 PTP_1588_CLOCK dependencies
In-Reply-To: <CO1PR11MB50892367410160A8364DBF69D6EF9@CO1PR11MB5089.namprd11.prod.outlook.com>
References: <20210802145937.1155571-1-arnd@kernel.org>
 <20210802164907.GA9832@hoboy.vegasvil.org>
 <bd631e36-1701-b120-a9b0-8825d14cc694@intel.com>
 <CAK8P3a3P6=ZROxT8daW83mRp7z5rYAQydetWFXQoYF7Y5_KLHA@mail.gmail.com>
 <CO1PR11MB50892367410160A8364DBF69D6EF9@CO1PR11MB5089.namprd11.prod.outlook.com>
Message-ID: <CAK8P3a379=Qi7g7Hmf299GgM-6g32Them81uYXPqRDZDro_azg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Aug 2, 2021 at 10:46 PM Keller, Jacob E
<jacob.e.keller@intel.com> wrote:

> > You can do something like it for a particular symbol though, such as
> >
> > config MAY_USE_PTP_1588_CLOCK
> >        def_tristate PTP_1588_CLOCK || !PTP_1588_CLOCK
> >
> >  config E1000E
> >         tristate "Intel(R) PRO/1000 PCI-Express Gigabit Ethernet support"
> >         depends on PCI && (!SPARC32 || BROKEN)
> > +       depends on MAY_USE_PTP_1588_CLOCK
> >         select CRC32
> > -       imply PTP_1588_CLOCK
>
> What about "integrates"?

Maybe, we'd need to look at whether that fits for the other users of the
"A || !A" trick.

> Or.. what if we just changed "implies" to also include the dependencies
> automatically? i.e. "implies PTP_1588_CLOCK" also means the depends
> trick which ensures that you can't have it as module if this is built-in.
>
> I.e. we still get the nice "this will turn on automatically in the menu if you
> enable this" and we enforce that you can't have it as a module since it
> would be a dependency if it's on"?

I don't want to mess with the semantics of the keyword any further.
The original meaning was meant to avoid circular dependencies
by making it a softer version of 'select' that would not try to select
anything that has unmet dependencies. The current version made
it even softer by only having an effect during 'make defconfig'
and 'make oldconfig' but not preventing it from being soft-disabled
any more. Changing it yet again is guarantee to break lots of the
existing users, while probably also bringing back the original problem
of the circular dependencies.

         Arnd
