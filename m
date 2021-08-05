From: Arnd Bergmann <arnd@kernel.org>
Date: Thu, 5 Aug 2021 10:11:33 +0200
Subject: [Intel-wired-lan] [PATCH net-next v3] ethernet: fix
 PTP_1588_CLOCK dependencies
In-Reply-To: <CO1PR11MB5089A77D5388203C4AA2F9E4D6F19@CO1PR11MB5089.namprd11.prod.outlook.com>
References: <20210804121318.337276-1-arnd@kernel.org>
 <CO1PR11MB5089A77D5388203C4AA2F9E4D6F19@CO1PR11MB5089.namprd11.prod.outlook.com>
Message-ID: <CAK8P3a2ZTmtkU9StyWMG=TwODxqAVEN_AFyGdyerr9C5vUMaVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Aug 4, 2021 at 10:52 PM Keller, Jacob E
<jacob.e.keller@intel.com> wrote:

> > diff --git a/drivers/net/ethernet/oki-semi/pch_gbe/Kconfig
> > b/drivers/net/ethernet/oki-semi/pch_gbe/Kconfig
> > index af84f72bf08e..4e18b64dceb9 100644
> > --- a/drivers/net/ethernet/oki-semi/pch_gbe/Kconfig
> > +++ b/drivers/net/ethernet/oki-semi/pch_gbe/Kconfig
> > @@ -6,6 +6,7 @@
> >  config PCH_GBE
> >       tristate "OKI SEMICONDUCTOR IOH(ML7223/ML7831) GbE"
> >       depends on PCI && (X86_32 || COMPILE_TEST)
> > +     depends on PTP_1588_CLOCK
> >       select MII
> >       select PTP_1588_CLOCK_PCH
> >       select NET_PTP_CLASSIFY
>
> I did notice this one driver which now directly depends on PTP_1558_CLOCK, but I
> suspect that's because it actually doesn't work if you disable PTP?

Yes, it's the 'select PTP_1588_CLOCK_PCH' and 'select NET_PTP_CLASSIFY'
that actually need it.

      Arnd
