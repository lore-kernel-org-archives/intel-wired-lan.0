From: Skidmore, Donald C <donald.c.skidmore@intel.com>
Date: Tue, 26 May 2015 17:45:58 +0000
Subject: [Intel-wired-lan] [PATCH v5 3/3] ixgbe: Add new ndo to trust VF
In-Reply-To: <7F861DC0615E0C47A872E6F3C5FCDDBD05EB8A65@BPXM14GP.gisp.nec.co.jp>
References: <7F861DC0615E0C47A872E6F3C5FCDDBD05EB28F4@BPXM14GP.gisp.nec.co.jp>
 <F6FB0E698C9B3143BDF729DF22286646912FB5E4@ORSMSX110.amr.corp.intel.com>
 <7F861DC0615E0C47A872E6F3C5FCDDBD05EB3B4A@BPXM14GP.gisp.nec.co.jp>
 <F6FB0E698C9B3143BDF729DF22286646912FBBEC@ORSMSX110.amr.corp.intel.com>
 <7F861DC0615E0C47A872E6F3C5FCDDBD05EB4EE6@BPXM14GP.gisp.nec.co.jp>
 <C5551D9AAB213A418B7FD5E4A6F30A07892F9481@ORSMSX108.amr.corp.intel.com>
 <F6FB0E698C9B3143BDF729DF22286646912FC2E3@ORSMSX110.amr.corp.intel.com>
 <7F861DC0615E0C47A872E6F3C5FCDDBD05EB8A65@BPXM14GP.gisp.nec.co.jp>
Message-ID: <F6FB0E698C9B3143BDF729DF22286646912FDC17@ORSMSX110.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Hiroshi Shimamoto [mailto:h-shimamoto at ct.jp.nec.com]
> Sent: Monday, May 25, 2015 6:00 PM
> To: Skidmore, Donald C; Rose, Gregory V; Kirsher, Jeffrey T; intel-wired-
> lan at lists.osuosl.org
> Cc: nhorman at redhat.com; jogreene at redhat.com; Linux Netdev List; Choi,
> Sy Jong; Rony Efraim; David Miller; Edward Cree; Or Gerlitz;
> sassmann at redhat.com
> Subject: RE: [PATCH v5 3/3] ixgbe: Add new ndo to trust VF
> 
> > > -----Original Message-----
> > > From: Rose, Gregory V
> > > Sent: Friday, May 22, 2015 8:08 AM
> > > To: Hiroshi Shimamoto; Skidmore, Donald C; Kirsher, Jeffrey T;
> > > intel-wired- lan at lists.osuosl.org
> > > Cc: nhorman at redhat.com; jogreene at redhat.com; Linux Netdev List;
> > > Choi, Sy Jong; Rony Efraim; David Miller; Edward Cree; Or Gerlitz;
> > > sassmann at redhat.com
> > > Subject: RE: [PATCH v5 3/3] ixgbe: Add new ndo to trust VF
> > >
> > >
> > > > -----Original Message-----
> > > > From: Intel-wired-lan
> > > > [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of
> > > > Hiroshi Shimamoto
> > > > Sent: Thursday, May 21, 2015 7:31 PM
> > > > To: Skidmore, Donald C; Kirsher, Jeffrey T; intel-wired-
> > > > lan at lists.osuosl.org
> > > > Cc: nhorman at redhat.com; jogreene at redhat.com; Linux Netdev List;
> > > > Choi, Sy Jong; Rony Efraim; David Miller; Edward Cree; Or Gerlitz;
> > > > sassmann at redhat.com
> > > > Subject: Re: [Intel-wired-lan] [PATCH v5 3/3] ixgbe: Add new ndo
> > > > to trust VF
> > > >
> > >
> > > [big snip]
> > >
> > > > I think your concerns are related to some operational assumptions.
> > > > My basic concept is, not to change the behavior of VM, existing
> > > > user operation.
> > > > I mean that I didn't think it's better that the user should check
> > > > the both of the ixgbevf driver can deal with new API and the VF is
> trusted.
> > > >
> > > > Now, I think the point is who takes care whether the VF is trusted.
> Right?
> > > > It seems that you think the VF user should handle that user is
> > > > trusted and do something with a notice that "you're trusted or
> > > > untrusted" from the host.
> > > > Is that correct?
> > > > I made it in PF side, because it looks easy to handle it. If
> > > > something to do in VF side, I think ixgbevf driver should handle it.
> > >
> > > Setting the VF trusted mode feature should only be allowed through
> > > the PF as it is the only trusted entity from the start.  We do not
> > > want the VF being able to decide for itself to be trusted.
> > >
> > > - Greg
> > >
> >
> > I completely agree with Greg and never meant to imply anything else.
> >
> > The PF should be where a given VF is made "trusted".  Likewise a VF
> > can get promoted to MC Promiscuous buy requesting over 30 MC groups.  I
> like this and your patch currently does this.  So for example below:
> >
> > PF					VF
> > ----------				-----------
> > Set given VF as trusted
> > 					Request 30+ MC groups via Mail Box
> Put PF in MC Promiscuous mode
> >
> >
> > What I am concerned about is the following flow where we seem to store
> > the fact the VF requests more than 30+ MC groups so that we can
> automatically enter MC Promisc Mode if that VF is ever made trusted.
> >
> > PF					VF
> > -----------				----------
> > Currently VF is NOT trusted
> > 					Request 30+ MC groups via Mail Box
> Do NOT put PF in MC Promisc
> > (hw->mac.mc_promisc = true)
> >
> > < Some time later >
> >
> > Set given VF as trusted
> > (because mc_promisc set) Put PF in MC Promisc
> >
> >
> > I don't like the fact that the PF remembers that the VF was denied MC
> > Promiscuous mode in the past.  And because of that automatically put
> > the VF in MC Promiscuous mode when it becomes trusted.  Maybe
> showing
> > in code what I would like removed/added would be more helpful,
> > probably should have started doing that. :)
> 
> Do you mean that VF should care about it is trusted or not?
> Should VF request MC Promisc again when it's trusted?
> Or, do you mean VF never be trusted during its (or VM's) lifetime?

I think the VF shouldn't directly know whether it is trusted or not.  It should request MC Promisc and get it if it is trusted and not if it is not trusted.  So if you (as the system admin know you have a VF that will need to request MC Promisc make sure you promote that VF to trusted before assigning it to a VM.  That way when it requests MC Promisc the PF will be able to grant it.


> 
> And what do you think about being untrusted from trusted state?

This is an interesting question.  If we allowed a VM to go from trusted -> untrusted we would have to turn off any "special" configuration that trusted allowed.  Maybe in such cases we could reset the PF?  And of course require all the "special" configuration (MC Promisc) to default to off after being reset.

> 
> >
> > I would remove this bit of code from ixgbe_ndo_set_vf_trust():
> >
> > int ixgbe_ndo_set_vf_trust(struct net_device *netdev, int vf, bool
> > setting) {
> > 	struct ixgbe_adapter *adapter = netdev_priv(netdev);
> >
> > 	if (vf >= adapter->num_vfs)
> > 		return -EINVAL;
> >
> > 	/* nothing to do */
> > 	if (adapter->vfinfo[vf].trusted == setting)
> > 		return 0;
> >
> > 	adapter->vfinfo[vf].trusted = setting;
> >
> > -	/* Reconfigure features which are only allowed for trusted VF */
> > -	/* VF multicast promiscuous mode */
> > -	if (adapter->vfinfo[vf].mc_promisc)
> > -		ixgbe_enable_vf_mc_promisc(adapter, vf);
> 
> I understand, you don't think we need to have a capability to enable/disable
> MC Promisc on the fly.
> 
> >
> > 	return 0;
> > }
> >
> > This of course would be we should not set mc_promisc ever if we are
> > NOT trusted (adapter->vfinfo[vf].trusted) so in
> > ixgbe_set_vf_mc_promisc() I would add or something like it:
> >
> > static int ixgbe_set_vf_mc_promisc(struct ixgbe_adapter *adapter,
> > 				   u32 *msgbuf, u32 vf)
> > {
> > 	bool enable = !!msgbuf[1];	/* msgbuf contains the flag to enable
> */
> >
> > 	switch (adapter->vfinfo[vf].vf_api) {
> > 	case ixgbe_mbox_api_12:
> > 		break;
> > 	default:
> > 		return -1;
> > 	}
> >
> > +	/* have to be trusted */
> > +	If (!adapter->vfinfo[vf].trusted)
> > +		Return 0;
> 
> Should we return an error to VF to inform it isn't trusted?

This too is a valid point.  Currently we would just not do it (MC Promisc) and the VF would have to figure that out for itself.  Passing a NAK back to the VF might be nicer. :)  Of course I assumed the sysadm would know that he/she wanted to give a VF trusted status and would do that before the VF was even assigned to a VM, so the issue would never come up.  Maybe that is not valid for your use case?

Thanks,
-Don 

