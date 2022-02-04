From: Alexander Lobakin <alexandr.lobakin@intel.com>
Date: Fri,  4 Feb 2022 11:35:48 +0100
Subject: [Intel-wired-lan] [PATCH net-next 19/19] idpf: introduce idpf
 driver
In-Reply-To: <CO1PR11MB51868C7F24F8C0EE3F243C2E8F289@CO1PR11MB5186.namprd11.prod.outlook.com>
References: <20220128001009.721392-1-alan.brady@intel.com>
 <20220128001009.721392-20-alan.brady@intel.com>
 <20220128200819.31570-1-alexandr.lobakin@intel.com>
 <CO1PR11MB51868C7F24F8C0EE3F243C2E8F289@CO1PR11MB5186.namprd11.prod.outlook.com>
Message-ID: <20220204103548.79282-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Alan Brady <alan.brady@intel.com>
Date: Thu, 3 Feb 2022 04:07:10 +0100

> > -----Original Message-----
> > From: Lobakin, Alexandr <alexandr.lobakin@intel.com>
> > Sent: Friday, January 28, 2022 12:08 PM
> > To: Brady, Alan <alan.brady@intel.com>
> > Cc: Lobakin, Alexandr <alexandr.lobakin@intel.com>; intel-wired-
> > lan at lists.osuosl.org; Burra, Phani R <phani.r.burra@intel.com>; Chittim,
> > Madhu <madhu.chittim@intel.com>; Linga, Pavan Kumar
> > <pavan.kumar.linga@intel.com>
> > Subject: Re: [Intel-wired-lan] [PATCH net-next 19/19] idpf: introduce idpf
> > driver
> > 
> > From: Alan Brady <alan.brady@intel.com>
> > Date: Thu, 27 Jan 2022 16:10:09 -0800
> > 
> > > This adds the idpf driver which uses the iecm module to provide common
> > > functionality. Device specific behavior and registers are defined here
> > > and handed off to iecm which takes over the rest of the flow.
> > 
> > Ok I missed that before, so I say it now.
> > Multi-function networking devices (Ethernet, SFs, VF representors, RDMA,
> > storage offload etc.) nowadays kinda *must* be based on top of auxiliary
> > bus. Otherwise, maintaining of hundreds a direct call with recursive
> > dependencies between modules and stuff will become a burden.
> > All of the mentioned functionality will be added to the driver(s), that's a
> > fact, and as these are new drivers, it's way better to start off the right way
> > now than to bug your mind on how to refactor this later.
> > 
> 
> I suspect a refactor now will actually be more painful than later for other reasons and I believe we have other motivations for not using aux bus in this. It is however worth considering but we need some time to discuss. Will reply with something firm after some internal discussion.

The earlier the easier, it's always more difficult to remodel stuff
later than during the initial preparation. It then will start absorb
changes from both the community and a pool of Intel employees,
iecm/idpf maintainers will have to support the accepted in-tree
driver along with the internal dev tree, and nothing from those
eases any core changes.
I heard the phrase "we have a motivation" several times, but nobody
explained it to me yet (thus I'm kindly asking for this once again),
so I speak only from the development and feature-richness
perspective.

> 
> > >
> > > Signed-off-by: Phani Burra <phani.r.burra@intel.com>
> > > Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
> > > Signed-off-by: Madhu Chittim <madhu.chittim@intel.com>
> > > Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> > > Signed-off-by: Alan Brady <alan.brady@intel.com>
> > > ---
> > >  .../device_drivers/ethernet/intel/idpf.rst    |  47 ++++++
> > >  drivers/net/ethernet/intel/Kconfig            |  16 ++
> > >  drivers/net/ethernet/intel/Makefile           |   1 +
> > >  drivers/net/ethernet/intel/idpf/Makefile      |  15 ++
> > >  drivers/net/ethernet/intel/idpf/idpf_dev.h    |  17 +++
> > >  drivers/net/ethernet/intel/idpf/idpf_devids.h |  10 ++
> > >  drivers/net/ethernet/intel/idpf/idpf_main.c   | 140
> > ++++++++++++++++++
> > >  drivers/net/ethernet/intel/idpf/idpf_reg.c    | 130 ++++++++++++++++
> > >  .../ethernet/intel/include/iecm_lan_pf_regs.h | 131 ++++++++++++++++
> > >  9 files changed, 507 insertions(+)
> > >  create mode 100644
> > > Documentation/networking/device_drivers/ethernet/intel/idpf.rst
> > >  create mode 100644 drivers/net/ethernet/intel/idpf/Makefile
> > >  create mode 100644 drivers/net/ethernet/intel/idpf/idpf_dev.h
> > >  create mode 100644 drivers/net/ethernet/intel/idpf/idpf_devids.h
> > >  create mode 100644 drivers/net/ethernet/intel/idpf/idpf_main.c
> > >  create mode 100644 drivers/net/ethernet/intel/idpf/idpf_reg.c
> > >  create mode 100644
> > > drivers/net/ethernet/intel/include/iecm_lan_pf_regs.h
> > >

--- 8< ---

> > > --
> > > 2.33.0
> > 
> > Thanks,
> > Al

Al
