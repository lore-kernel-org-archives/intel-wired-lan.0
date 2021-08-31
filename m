From: Machnikowski, Maciej <maciej.machnikowski@intel.com>
Date: Tue, 31 Aug 2021 22:09:18 +0000
Subject: [Intel-wired-lan] [RFC v2 net-next 1/2] rtnetlink: Add new
 RTM_GETSYNCESTATE message to get SyncE status
In-Reply-To: <20210831161927.GA10747@hoboy.vegasvil.org>
References: <20210829080512.3573627-1-maciej.machnikowski@intel.com>
 <20210829080512.3573627-2-maciej.machnikowski@intel.com>
 <20210829151017.GA6016@hoboy.vegasvil.org>
 <PH0PR11MB495126A63998DABA5B5DE184EACA9@PH0PR11MB4951.namprd11.prod.outlook.com>
 <20210830205758.GA26230@hoboy.vegasvil.org>
 <20210830162909.110753ec@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <20210831161927.GA10747@hoboy.vegasvil.org>
Message-ID: <SJ0PR11MB4958D55CB9EDD459AF076525EACC9@SJ0PR11MB4958.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Richard Cochran <richardcochran@gmail.com>
> Sent: Tuesday, August 31, 2021 6:19 PM
> To: Jakub Kicinski <kuba@kernel.org>
> Subject: Re: [RFC v2 net-next 1/2] rtnetlink: Add new RTM_GETSYNCESTATE
> message to get SyncE status
> 
> On Mon, Aug 30, 2021 at 04:29:09PM -0700, Jakub Kicinski wrote:
> > Can we add a genetlink family for clock info/configuration? From
> > what I understood discussing this with Jonathan it sounded like most
> > clocks today have a vendor-specific character device for configuration
> > and reading status.
> >
> > I'm happy to write the plumbing if this seems like an okay idea
> > but too much work for anyone to commit.
> 
> This sounds nice.
> 
> As you said later on in this thread, any API we merge now will have to
> last.  That is why I'm being so picky here.  We want new APIs to cover
> current HW _and_ be reasonable for the future.
> 
> I don't see a DPLL as either a PTP Hardware Clock or a Network
> Device.  It is a PLL.
> 
> The kernel can and should have a way to represent the relationship
> between these three different kind of IP block.  We already have a
> way to get from PHC to netdev interface.

OK I can strip down the RTNL EEC state interface to only report 
the state without any extras, like pin. Next step would be to add 
the control over recovered clock also to the netdev subsystem.

The EEC state read is needed for recovered/source clock validation
and that's why I think it belongs to the RTNL part as it gates the QL
for each port.

Those two interfaces will allow a minimalistic ESMC support
(receive the packet, extract the SSM from it, check if my clock is
recovered and my clock is in locked state, if all are good - pass
the message along to other related ports)

In parallel let's work on a proper clock generator subsystem. 
For starter It should handle:

 - reference configuration
 - reference status
 - reference priorities
 - output settings

Optionally:
 - NCO mode (here we'll duplicate the functionality of PHC in some 
    deployments)

Once we have that in place we can simply 
- reroute the internals of the EEC state the clock generator subsystem 
  on more complex systems,
- keeping the simple state-read for those who use other simpler
  Implementations of EEC.
- be able to support any hybrid between 1 and 2

Once we get there we'll know what else should this RTNL return and
extend it if needed.

Regards
Maciek
