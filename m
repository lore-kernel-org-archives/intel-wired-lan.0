From: Machnikowski, Maciej <maciej.machnikowski@intel.com>
Date: Mon, 13 Dec 2021 08:53:36 +0000
Subject: [Intel-wired-lan] [PATCH v5 net-next 0/4] Add ethtool interface
 for RClocks
In-Reply-To: <20211210081654.233a41b6@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <20211210134550.1195182-1-maciej.machnikowski@intel.com>
 <20211210081654.233a41b6@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Message-ID: <MW5PR11MB58126A8F6466A8EAD1293D5EEA749@MW5PR11MB5812.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Friday, December 10, 2021 5:17 PM
> To: Machnikowski, Maciej <maciej.machnikowski@intel.com>
> Cc: netdev at vger.kernel.org; intel-wired-lan at lists.osuosl.org; Kubalewski,
> Arkadiusz <arkadiusz.kubalewski@intel.com>; richardcochran at gmail.com;
> Byagowi, Ahmad <abyagowi@fb.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; davem at davemloft.net; linux-
> kselftest at vger.kernel.org; idosch at idosch.org; mkubecek at suse.cz;
> saeed at kernel.org; michael.chan at broadcom.com; petrm at nvidia.com;
> Vadim Fedorenko <vfedorenko@novek.ru>
> Subject: Re: [PATCH v5 net-next 0/4] Add ethtool interface for RClocks
> 
> On Fri, 10 Dec 2021 14:45:46 +0100 Maciej Machnikowski wrote:
> > Synchronous Ethernet networks use a physical layer clock to syntonize
> > the frequency across different network elements.
> >
> > Basic SyncE node defined in the ITU-T G.8264 consist of an Ethernet
> > Equipment Clock (EEC) and have the ability to synchronize to reference
> > frequency sources.
> >
> > This patch series is a prerequisite for EEC object and adds ability
> > to enable recovered clocks in the physical layer of the netdev object.
> > Recovered clocks can be used as one of the reference signal by the EEC.
> >
> > Further work is required to add the DPLL subsystem, link it to the
> > netdev object and create API to read the EEC DPLL state.
> 
> You missed CCing Vadim. I guess Ccing the right people may be right up
> there with naming things as the hardest things in SW development..
> 
> Anyway, Vadim - do you have an ETA on the first chunk of the PLL work?

Sounds about right :) thanks for adding Vadim!
