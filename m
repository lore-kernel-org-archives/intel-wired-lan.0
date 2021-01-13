From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Date: Wed, 13 Jan 2021 11:34:37 +0100
Subject: [Intel-wired-lan] [PATCH] i40e: Add error message when MTU on
 device is out of the range
In-Reply-To: <CY4PR11MB162180D89412D92EBBF263AFBFA90@CY4PR11MB1621.namprd11.prod.outlook.com>
References: <20201218165255.6393-1-eryk.roch.rybak@intel.com>
 <e983a9eb-3d87-8fb4-3221-1f012e04d5a6@molgen.mpg.de>
 <20210107092828.GA30484@ranger.igk.intel.com>
 <CY4PR11MB162177CD462300F781703059BFAE0@CY4PR11MB1621.namprd11.prod.outlook.com>
 <CY4PR11MB162180D89412D92EBBF263AFBFA90@CY4PR11MB1621.namprd11.prod.outlook.com>
Message-ID: <20210113103437.GA30103@ranger.igk.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Jan 13, 2021 at 10:41:35AM +0000, Rybak, Eryk Roch wrote:
> Guys,
> 
> Friendy reminder.
> 
> IMHO, double the log message is not the best solution here. However, I suggest to prepare string on stack earlier and send it as extrack then.
> What do you think guys, Maciej/Paul?

I like the idea. It's slow path so it won't hurt us.
FYI it's 'extack', comes from 'extended ACK' netlink's feature :)

> 
> Thanks,
> -Eryk
> 
> >-----Original Message-----
> >From: Rybak, Eryk Roch
> >Sent: Friday, January 8, 2021 12:19 PM
> >To: Fijalkowski, Maciej <maciej.fijalkowski@intel.com>; Paul Menzel <pmenzel@molgen.mpg.de>
> >Cc: intel-wired-lan at lists.osuosl.org
> >Subject: RE: [Intel-wired-lan] [PATCH] i40e: Add error message when MTU on device is out of the range
> >
> >>-----Original Message-----
> >>From: Fijalkowski, Maciej <maciej.fijalkowski@intel.com>
> >>Sent: Thursday, January 7, 2021 10:28 AM
> >>To: Paul Menzel <pmenzel@molgen.mpg.de>
> >>Cc: Rybak, Eryk Roch <eryk.roch.rybak@intel.com>;
> >>intel-wired-lan at lists.osuosl.org
> >>Subject: Re: [Intel-wired-lan] [PATCH] i40e: Add error message when MTU
> >>on device is out of the range
> >>
> >>On Wed, Jan 06, 2021 at 10:36:23AM +0100, Paul Menzel wrote:
> >>> Dear Eryk,
> >>
> >>Eryk, you still haven't specified the tree that this patch is supposed
> >>to land (nit - it will be net-next :))
> >>
> >Sure I will add to the second version of patch, thanks for hint.
> >>>
> >>>
> >>> Am 18.12.20 um 17:52 schrieb Eryk Rybak:
> >>>
> >>> Maybe a shorter summary:
> >>>
> >>> > i40e: Log error for oversized MTU on device
> >>>
> >>> > When attempting to link XDP prog with MTU larger than supported,
> >>> > user is not informed why XDP linking fails. Adding proper
> >>>
> >>> Nit: Imperative mood could be used instead: Add proper ?
> >>
> >>+1, thanks Paul!
> >Thanks guys, expect better commit message in next version of this patch.
> >>
> >>>
> >>> > error message.
> >>>
> >>> Personally, when adding new log message, I find it nice to see them
> >>> in the commit message too.
> >>>
> >>> > Signed-off-by: Arkadiusz Kubalewski
> >>> > <arkadiusz.kubalewski@intel.com>
> >>> > Signed-off-by: Eryk Rybak <eryk.roch.rybak@intel.com>
> >>> > ---
> >>> >   drivers/net/ethernet/intel/i40e/i40e_main.c | 11 +++++++----
> >>> >   1 file changed, 7 insertions(+), 4 deletions(-)
> >>> >
> >>> > diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c
> >>> > b/drivers/net/ethernet/intel/i40e/i40e_main.c
> >>> > index 630258e..4fdef00 100644
> >>> > --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> >>> > +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> >>> > @@ -12933,9 +12933,10 @@ static netdev_features_t i40e_features_check(struct sk_buff *skb,
> >>> >    * i40e_xdp_setup - add/remove an XDP program
> >>> >    * @vsi: VSI to changed
> >>> >    * @prog: XDP program
> >>> > + * @extack: netlink extended ack
> >>> >    **/
> >>> > -static int i40e_xdp_setup(struct i40e_vsi *vsi,
> >>> > -  struct bpf_prog *prog)
> >>> > +static int i40e_xdp_setup(struct i40e_vsi *vsi, struct bpf_prog *prog,
> >>> > +  struct netlink_ext_ack *extack)
> >>> >   {
> >>> >   int frame_size = vsi->netdev->mtu + ETH_HLEN + ETH_FCS_LEN + VLAN_HLEN;
> >>> >   struct i40e_pf *pf = vsi->back;
> >>> > @@ -12944,8 +12945,10 @@ static int i40e_xdp_setup(struct i40e_vsi *vsi,
> >>> >   int i;
> >>> >   /* Don't allow frames that span over multiple buffers */
> >>> > -if (frame_size > vsi->rx_buf_len)
> >>> > +if (frame_size > vsi->rx_buf_len) {
> >>> > +NL_SET_ERR_MSG_MOD(extack, "MTU too large to enable XDP");
> >>>
> >>> Could you please also print out both values? Maybe (unsure about the units):
> >>>
> >>>    MTU of %u bytes(?) too large to enable XDP (maximum: %u bytes)
> >>
> >>No, extack does not support printf-like format specifiers,
> >>unfortunately :<
> >>
> >>Maybe we can double the message and have a separate dev_info() in here?
> >
> >IMHO, double the log message is not the best solution here. However, I suggest to prepare string on stack earlier and send it as extrack then.
> >What do you think guys, Maciej/Paul?
> >
> >>
> >>>
> >>>
> >>> Kind regards,
> >>>
> >>> Paul
> >>>
> >>>
> >>> >   return -EINVAL;
> >>> > +}
> >>> >   /* When turning XDP on->off/off->on we reset and rebuild the rings. */
> >>> >   need_reset = (i40e_enabled_xdp_vsi(vsi) != !!prog); @@ -13254,7
> >>> > +13257,7 @@ static int i40e_xdp(struct net_device *dev,
> >>> >   switch (xdp->command) {
> >>> >   case XDP_SETUP_PROG:
> >>> > -return i40e_xdp_setup(vsi, xdp->prog);
> >>> > +return i40e_xdp_setup(vsi, xdp->prog, xdp->extack);
> >>> >   case XDP_SETUP_XSK_POOL:
> >>> >   return i40e_xsk_pool_setup(vsi, xdp->xsk.pool,
> >>> >      xdp->xsk.queue_id);
> >>> >
> >>> > base-commit: d2c2bbad93b818020657a82121a147e9ace1230d
> >>> _______________________________________________
> >>> Intel-wired-lan mailing list
> >>> Intel-wired-lan at osuosl.org
> >>> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
