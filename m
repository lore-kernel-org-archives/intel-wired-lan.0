From: Nicolas Pitre <nico@fluxnic.net>
Date: Mon, 2 Aug 2021 17:22:18 -0400 (EDT)
Subject: [Intel-wired-lan] [PATCH net-next v2] ethernet/intel: fix
 PTP_1588_CLOCK dependencies
In-Reply-To: <CAK8P3a379=Qi7g7Hmf299GgM-6g32Them81uYXPqRDZDro_azg@mail.gmail.com>
References: <20210802145937.1155571-1-arnd@kernel.org>
 <20210802164907.GA9832@hoboy.vegasvil.org>
 <bd631e36-1701-b120-a9b0-8825d14cc694@intel.com>
 <CAK8P3a3P6=ZROxT8daW83mRp7z5rYAQydetWFXQoYF7Y5_KLHA@mail.gmail.com>
 <CO1PR11MB50892367410160A8364DBF69D6EF9@CO1PR11MB5089.namprd11.prod.outlook.com>
 <CAK8P3a379=Qi7g7Hmf299GgM-6g32Them81uYXPqRDZDro_azg@mail.gmail.com>
Message-ID: <7q2p5954-3062-po4-ps5r-9n30n5663ns3@syhkavp.arg>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 2 Aug 2021, Arnd Bergmann wrote:

> On Mon, Aug 2, 2021 at 10:46 PM Keller, Jacob E
> <jacob.e.keller@intel.com> wrote:
> 
> > > You can do something like it for a particular symbol though, such as
> > >
> > > config MAY_USE_PTP_1588_CLOCK
> > >        def_tristate PTP_1588_CLOCK || !PTP_1588_CLOCK
> > >
> > >  config E1000E
> > >         tristate "Intel(R) PRO/1000 PCI-Express Gigabit Ethernet support"
> > >         depends on PCI && (!SPARC32 || BROKEN)
> > > +       depends on MAY_USE_PTP_1588_CLOCK
> > >         select CRC32
> > > -       imply PTP_1588_CLOCK
> >
> > What about "integrates"?
> 
> Maybe, we'd need to look at whether that fits for the other users of the
> "A || !A" trick.

I implemented "conditional dependencies" at the time, which is syntactic 
sugar to express the above as:

	depends on A if A != n

	depends on A if A

etc.

http://lkml.iu.edu/hypermail/linux/kernel/2004.2/09783.html

But Masahiro shut it down.


Nicolas
