From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Date: Tue, 22 Jun 2021 21:04:51 -0400
Subject: [Intel-wired-lan] [PATCH net-next 07/12] ice: setting and
 releasing switchdev environment
In-Reply-To: <6b4044c85a27076d4ce8a0a4f96a04e72abcc63a.camel@intel.com>
References: <20210617234413.104069-1-michal.swiatkowski@linux.intel.com>
 <20210617234413.104069-8-michal.swiatkowski@linux.intel.com>
 <a6a0b9064847e6106cca2ae4a9669b84f4322926.camel@intel.com>
 <YNEwV42hOSAhtbiX@localhost.localdomain>
 <YNE6gDaubIydNmGz@localhost.localdomain>
 <6b4044c85a27076d4ce8a0a4f96a04e72abcc63a.camel@intel.com>
Message-ID: <YNKIs8QbWusOKzXp@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Jun 22, 2021 at 03:14:58PM +0000, Nguyen, Anthony L wrote:
> On Mon, 2021-06-21 at 21:18 -0400, Michal Swiatkowski wrote:
> > On Mon, Jun 21, 2021 at 08:35:35PM -0400, Michal Swiatkowski wrote:
> > > On Mon, Jun 21, 2021 at 06:21:15PM +0000, Nguyen, Anthony L wrote:
> > > > On Fri, 2021-06-18 at 01:44 +0200, Michal Swiatkowski wrote:
> > > > > From: Grzegorz Nitka <grzegorz.nitka@intel.com>
> > > > > 
> > > > > Switchdev environment has to be set up when user create VFs
> > > > > and eswitch mode is switchdev. Release is done when user
> > > > > delete all VFs.
> > > > > 
> > > > > Data path in this implementation is based on control plane VSI.
> > > > > This VSI is used to pass traffic from port representors to
> > > > > coresponfing VFs and vice versa. Default TX rule has to be
> > > > > added to forward packet to control plane VSI. This will
> > > > > redirect
> > > > > packets from VFs which don't match other rules to control plane
> > > > > VSI.
> > > > > 
> > > > > On RX site default rule is added on uplink VSI to receive all
> > > > > traffic that doesn't match other rules. When setting switchdev
> > > > > environment all other rules from VFs should be removed. Packet
> > > > > to
> > > > > VFs will be forwarded by control plane VSI.
> > > > > 
> > > > > As VF without any mac rules can't send any packet because of
> > > > > antispoof mechanism, VSI antispoof should be turned off on each
> > > > > VFs.
> > > > > 
> > > > > To send packet from representor to correct VSI, destintion VSI
> > > > > field in TX descriptor will have to be filled. Allow that by
> > > > > setting destination override bit in control plane VSI security
> > > > > config.
> > > > > 
> > > > > Packet from VFs will be received on control plane VSI. Driver
> > > > > should decide to which netdev forward the packet. Decision is
> > > > > made based on src_vsi field from descriptor. There is a target
> > > > > netdev list in control plane VSI struct which choose netdev
> > > > > based on src_vsi number.
> > > > > 
> > > > > Co-developed-by: Michal Swiatkowski <
> > > > > michal.swiatkowski at linux.intel.com>
> > > > > Signed-off-by: Michal Swiatkowski <
> > > > > michal.swiatkowski at linux.intel.com
> > > > > Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
> > > > > ---
> > > > 
> > > > <snip>
> > > > 
> > > > > +/**
> > > > > + * ice_eswitch_vsi_setup - configure switchdev control VSI
> > > > > + * @pf: pointer to PF structure
> > > > > + * @pi: pointer to port_info structure
> > > > > + */
> > > > > +static struct ice_vsi *
> > > > > +ice_eswitch_vsi_setup(struct ice_pf *pf, struct ice_port_info
> > > > > *pi)
> > > > > +{
> > > > > +	return ice_vsi_setup(pf, pi, ICE_VSI_SWITCHDEV_CTRL,
> > > > > ICE_INVAL_VFID);
> > > > 
> > > > This doesn't build; the switchdev VSI doesn't get introduced
> > > > until the
> > > > next patch. 
> > > > 
> > > 
> > > Sorry, I missed that, will fix it in next version.
> > > 
> > 
> > This patchset is already on your dev-queue branch, what should I do
> > in
> > this case? You will reveret this, or I should send fixed version
> > without
> > applying it on top of the dev-queue?
> 
> I forgot to drop the patches from dev-queue. Everything should be clear
> now.
> 

Yeah, everything is fine now, thanks
> > 
> > > > drivers/net/ethernet/intel/ice/ice_eswitch.c: In function
> > > > ice_eswitch_vsi_setup:
> > > > drivers/net/ethernet/intel/ice/ice_eswitch.c:263:31: error:
> > > > ICE_VSI_SWITCHDEV_CTRL undeclared (first use in this function)
> > > >   263 |  return ice_vsi_setup(pf, pi, ICE_VSI_SWITCHDEV_CTRL,
> > > > ICE_INVAL_VFID);
> > > >       |                               ^~~~~~~~~~~~~~~~~~~~~~
> > > > drivers/net/ethernet/intel/ice/ice_eswitch.c:263:31: note: each
> > > > undeclared identifier is reported only once for each function it
> > > > appears in
> > > > drivers/net/ethernet/intel/ice/ice_eswitch.c:264:1: error:
> > > > control
> > > > reaches end of non-void function [-Werror=return-type]
> > > >   264 | }
> > > > 
> > > _______________________________________________
> > > Intel-wired-lan mailing list
> > > Intel-wired-lan at osuosl.org
> > > https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
