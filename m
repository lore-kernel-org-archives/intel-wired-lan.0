From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Wed, 4 Aug 2021 20:45:28 +0000
Subject: [Intel-wired-lan] [PATCH net-next v3] ethernet: fix
 PTP_1588_CLOCK dependencies
In-Reply-To: <CAK8P3a1EBwd+DvqnQSHL03zqaoRz_bhxj6TGw2ivpWLDT7jorw@mail.gmail.com>
References: <20210804121318.337276-1-arnd@kernel.org>
 <20210804142814.GB1645@hoboy.vegasvil.org>
 <CAK8P3a1EBwd+DvqnQSHL03zqaoRz_bhxj6TGw2ivpWLDT7jorw@mail.gmail.com>
Message-ID: <CO1PR11MB50895017B516FB92DB9CD165D6F19@CO1PR11MB5089.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Arnd Bergmann <arnd@kernel.org>
> Sent: Wednesday, August 04, 2021 8:21 AM
> To: Richard Cochran <richardcochran@gmail.com>
> Cc: David S. Miller <davem@davemloft.net>; Jakub Kicinski <kuba@kernel.org>;
> Keller, Jacob E <jacob.e.keller@intel.com>; Arnd Bergmann <arnd@arndb.de>;
> Andrew Lunn <andrew@lunn.ch>; Vivien Didelot <vivien.didelot@gmail.com>;
> Florian Fainelli <f.fainelli@gmail.com>; Vladimir Oltean <olteanv@gmail.com>;
> Claudiu Manoil <claudiu.manoil@nxp.com>; Alexandre Belloni
> <alexandre.belloni@bootlin.com>; Microchip Linux Driver Support
> <UNGLinuxDriver@microchip.com>; Nicolas Ferre
> <nicolas.ferre@microchip.com>; Claudiu Beznea
> <claudiu.beznea@microchip.com>; Yisen Zhuang <yisen.zhuang@huawei.com>;
> Salil Mehta <salil.mehta@huawei.com>; Brandeburg, Jesse
> <jesse.brandeburg@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; Tariq Toukan <tariqt@nvidia.com>; Saeed
> Mahameed <saeedm@nvidia.com>; Leon Romanovsky <leon@kernel.org>; Jiri
> Pirko <jiri@nvidia.com>; Ido Schimmel <idosch@nvidia.com>; Shannon Nelson
> <snelson@pensando.io>; drivers at pensando.io; Sergei Shtylyov
> <sergei.shtylyov@gmail.com>; Edward Cree <ecree.xilinx@gmail.com>; Martin
> Habets <habetsm.xilinx@gmail.com>; Giuseppe Cavallaro
> <peppe.cavallaro@st.com>; Alexandre Torgue <alexandre.torgue@foss.st.com>;
> Jose Abreu <joabreu@synopsys.com>; Heiner Kallweit <hkallweit1@gmail.com>;
> Russell King <linux@armlinux.org.uk>; Yangbo Lu <yangbo.lu@nxp.com>; Randy
> Dunlap <rdunlap@infradead.org>; Simon Horman
> <simon.horman@netronome.com>; Networking <netdev@vger.kernel.org>;
> Linux Kernel Mailing List <linux-kernel@vger.kernel.org>; Intel Wired LAN <intel-
> wired-lan at lists.osuosl.org>
> Subject: Re: [PATCH net-next v3] ethernet: fix PTP_1588_CLOCK dependencies
> 
> On Wed, Aug 4, 2021 at 4:28 PM Richard Cochran <richardcochran@gmail.com>
> wrote:
> > > @@ -87,8 +87,8 @@ config E1000E_HWTS
> > >  config IGB
> > >       tristate "Intel(R) 82575/82576 PCI-Express Gigabit Ethernet support"
> > >       depends on PCI
> > > -     imply PTP_1588_CLOCK
> > > -     select I2C
> > > +     depends on PTP_1588_CLOCK_OPTIONAL
> > > +     depends on I2C
> >
> > This little i2c bit sneaks in, but I guess you considered any possible
> > trouble with it?
> 
> Good catch!
> 
> I did need this with v2, as it was causing a circular dependency against
> (IIRC) CONFIG_MLXSW_I2C, but I'm fairly sure it's not needed any
> more after everything else uses 'depends on' now.
> 
> I'm happy to resend a v4 without that change, as it doesn't belong in here,
> or we just leave it because it is correct after all, depending on what the Intel
> ethernet people prefer.
> 

I'm fine with keeping it in.

> > Acked-by: Richard Cochran <richardcochran@gmail.com>
> 
> Thanks,
> 
>       Arnd
