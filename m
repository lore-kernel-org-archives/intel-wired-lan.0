From: Ido Schimmel <idosch@idosch.org>
Date: Wed, 22 Sep 2021 09:22:04 +0300
Subject: [Intel-wired-lan] [PATCH net-next 1/2] rtnetlink: Add new
 RTM_GETEECSTATE message to get SyncE status
In-Reply-To: <20210921141445.24ae714e@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <20210903151436.529478-1-maciej.machnikowski@intel.com>
 <20210903151436.529478-2-maciej.machnikowski@intel.com>
 <YUnbCzBOPP9hWQ5c@shredder>
 <PH0PR11MB4951E98FCEC0F1EA230BA1DAEAA19@PH0PR11MB4951.namprd11.prod.outlook.com>
 <YUny/edqnbdTFnBS@shredder>
 <20210921141445.24ae714e@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Message-ID: <YUrLjGJwMc/UpqOK@shredder>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Sep 21, 2021 at 02:14:45PM -0700, Jakub Kicinski wrote:
> On Tue, 21 Sep 2021 17:58:05 +0300 Ido Schimmel wrote:
> > > > The only source type above is 'port' with the ability to set the
> > > > relevant port, but more can be added. Obviously, 'devlink clock show'
> > > > will give you the current source in addition to other information such
> > > > as frequency difference with respect to the input frequency.  
> > > 
> > > We considered devlink interface for configuring the clock/DPLL, but a
> > > new concept was born at the list to add a DPLL subsystem that will
> > > cover more use cases, like a TimeCard.  
> > 
> > The reason I suggested devlink is that it is suited for device-wide
> > configuration and it is already used by both MAC drivers and the
> > TimeCard driver. If we have a good reason to create a new generic
> > netlink family for this stuff, then OK.
> 
> For NICs mapping between devlink instances and HW is not clear.
> Most register devlink per PCI dev which usually maps to a Eth port.
> So if we have one DPLL on a 2 port NIC mapping will get icky, no?

Yes, having to represent the same EEC in multiple devlink instances is
not nice.

> 
> Is the motivation to save the boilerplate code associated with new
> genetlink family or something more? 

I don't mind either way. I simply wanted to understand the motivation
for not using any existing framework. The above argument is convincing
enough, IMO.
