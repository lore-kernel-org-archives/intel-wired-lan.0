From: Machnikowski, Maciej <maciej.machnikowski@intel.com>
Date: Tue, 9 Nov 2021 10:50:14 +0000
Subject: [Intel-wired-lan] [PATCH v2 net-next 6/6] docs: net: Add
 description of SyncE interfaces
In-Reply-To: <20211108090302.64ca86a5@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <20211105205331.2024623-1-maciej.machnikowski@intel.com>
 <20211105205331.2024623-7-maciej.machnikowski@intel.com>
 <YYfd7DCFFtj/x+zQ@shredder>
 <MW5PR11MB58120F585A5CF1BCA1E7E958EA919@MW5PR11MB5812.namprd11.prod.outlook.com>
 <YYlQfm3eW/jRS4Ra@shredder>
 <20211108090302.64ca86a5@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Message-ID: <MW5PR11MB58121891B56004F5AB3DE922EA929@MW5PR11MB5812.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Monday, November 8, 2021 6:03 PM
> To: Ido Schimmel <idosch@idosch.org>
> Subject: Re: [PATCH v2 net-next 6/6] docs: net: Add description of SyncE
> interfaces
> 
> On Mon, 8 Nov 2021 18:29:50 +0200 Ido Schimmel wrote:
> > I also want to re-iterate my dissatisfaction with the interface being
> > netdev-centric. By modelling the EEC as a standalone object we will be
> > able to extend it to set the source of the EEC to something other than a
> > netdev in the future. If we don't do it now, we will end up with two
> > ways to report the source of the EEC (i.e., EEC_SRC_PORT and something
> > else).
> >
> > Other advantages of modelling the EEC as a separate object include the
> > ability for user space to determine the mapping between netdevs and EECs
> > (currently impossible) and reporting additional EEC attributes such as
> > SyncE clockIdentity and default SSM code. There is really no reason to
> > report all of this identical information via multiple netdevs.
> 
> Indeed, I feel convinced. I believe the OCP timing card will benefit
> from such API as well. I pinged Jonathan if he doesn't have cycles
> I'll do the typing.
> 
> What do you have in mind for driver abstracting away pin selection?
> For a standalone clock fed PPS signal from a backplate this will be
> impossible, so we may need some middle way.

Me too! Yet it'll take a lot of time to implement it. My thinking was to
implement the simplest usable EEC state possible that is applicable to all
solutions (like 1GBaseT that doesn't always require external DPLL to enable
SyncE) and have an option to return the state for netdev-specific use cases
And easily enable the new path when it's available. We can just check if the
driver is connected to the DPLL in the future DPLL subsystem and reroute
the GET_EECSTATE call there.

We can also fix the mapping by adding the DPLL_IDX attribute.

The DPLL subsystem will require very flexible pin model as there are a lot to
configure inside the DPLL to enable many use cases.
