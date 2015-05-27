From: Skidmore, Donald C <donald.c.skidmore@intel.com>
Date: Wed, 27 May 2015 16:00:32 +0000
Subject: [Intel-wired-lan] [PATCH v5 3/3] ixgbe: Add new ndo to trust VF
In-Reply-To: <C5551D9AAB213A418B7FD5E4A6F30A07892FCD87@ORSMSX108.amr.corp.intel.com>
References: <7F861DC0615E0C47A872E6F3C5FCDDBD05EB28F4@BPXM14GP.gisp.nec.co.jp>
 <F6FB0E698C9B3143BDF729DF22286646912FB5E4@ORSMSX110.amr.corp.intel.com>
 <7F861DC0615E0C47A872E6F3C5FCDDBD05EB3B4A@BPXM14GP.gisp.nec.co.jp>
 <F6FB0E698C9B3143BDF729DF22286646912FBBEC@ORSMSX110.amr.corp.intel.com>
 <7F861DC0615E0C47A872E6F3C5FCDDBD05EB4EE6@BPXM14GP.gisp.nec.co.jp>
 <C5551D9AAB213A418B7FD5E4A6F30A07892F9481@ORSMSX108.amr.corp.intel.com>
 <F6FB0E698C9B3143BDF729DF22286646912FC2E3@ORSMSX110.amr.corp.intel.com>
 <7F861DC0615E0C47A872E6F3C5FCDDBD05EB8A65@BPXM14GP.gisp.nec.co.jp>
 <F6FB0E698C9B3143BDF729DF22286646912FDC17@ORSMSX110.amr.corp.intel.com>
 <C5551D9AAB213A418B7FD5E4A6F30A07892FC8C7@ORSMSX108.amr.corp.intel.com>
 <7F861DC0615E0C47A872E6F3C5FCDDBD05EB9DA7@BPXM14GP.gisp.nec.co.jp>
 <C5551D9AAB213A418B7FD5E4A6F30A07892FCD87@ORSMSX108.amr.corp.intel.com>
Message-ID: <F6FB0E698C9B3143BDF729DF22286646912FE19D@ORSMSX110.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Rose, Gregory V
> Sent: Tuesday, May 26, 2015 7:01 PM
> To: Hiroshi Shimamoto; Skidmore, Donald C; Kirsher, Jeffrey T; intel-wired-
> lan at lists.osuosl.org
> Cc: nhorman at redhat.com; jogreene at redhat.com; Linux Netdev List; Choi,
> Sy Jong; Rony Efraim; David Miller; Edward Cree; Or Gerlitz;
> sassmann at redhat.com
> Subject: RE: [PATCH v5 3/3] ixgbe: Add new ndo to trust VF
> 
> 
> > -----Original Message-----
> > From: Hiroshi Shimamoto [mailto:h-shimamoto at ct.jp.nec.com]
> > Sent: Tuesday, May 26, 2015 5:28 PM
> > To: Rose, Gregory V; Skidmore, Donald C; Kirsher, Jeffrey T;
> > intel-wired- lan at lists.osuosl.org
> > Cc: nhorman at redhat.com; jogreene at redhat.com; Linux Netdev List; Choi,
> > Sy Jong; Rony Efraim; David Miller; Edward Cree; Or Gerlitz;
> > sassmann at redhat.com
> > Subject: RE: [PATCH v5 3/3] ixgbe: Add new ndo to trust VF
> >
> > > > -----Original Message-----
> > > > From: Skidmore, Donald C
> > > > Sent: Tuesday, May 26, 2015 10:46 AM
> > > > To: Hiroshi Shimamoto; Rose, Gregory V; Kirsher, Jeffrey T;
> > > > intel-wired- lan at lists.osuosl.org
> > > > Cc: nhorman at redhat.com; jogreene at redhat.com; Linux Netdev List;
> > > > Choi, Sy Jong; Rony Efraim; David Miller; Edward Cree; Or Gerlitz;
> > > > sassmann at redhat.com
> > > > Subject: RE: [PATCH v5 3/3] ixgbe: Add new ndo to trust VF
> > > >
> > > >
> > >
> > > [snip]
> > >
> > > >
> > > > > -----Original Message-----
> > > > > From: Hiroshi Shimamoto [mailto:h-shimamoto at ct.jp.nec.com]
> > > > > Sent: Monday, May 25, 2015 6:00 PM
> > > > > To: Skidmore, Donald C; Rose, Gregory V; Kirsher, Jeffrey T;
> > > > > intel-wired- lan at lists.osuosl.org
> > > > > Cc: nhorman at redhat.com; jogreene at redhat.com; Linux Netdev List;
> > > > > Choi, Sy Jong; Rony Efraim; David Miller; Edward Cree; Or
> > > > > Gerlitz; sassmann at redhat.com
> > > > > Subject: RE: [PATCH v5 3/3] ixgbe: Add new ndo to trust VF
> > > > >
> > > > >
> > > > > Do you mean that VF should care about it is trusted or not?
> > > > > Should VF request MC Promisc again when it's trusted?
> > > > > Or, do you mean VF never be trusted during its (or VM's) lifetime?
> > > >
> > > > I think the VF shouldn't directly know whether it is trusted or
> > > > not
> > >
> > > That's completely irrevelant.  The person administering the PF will
> > > be the person who provided trusted privileges to the VF.  He'll then
> > > *tell* or somehow other communicate to the person administering the
> > > VF
> > (probably himself/herself) and then proceed to execute commands on
> > that VF that require trusted privileges.
> > >
> > > If the VF does not have trusted privileges then the commands to add
> > > VLAN filters, set promiscuous modes, and any other privileged
> > > commands
> > will fail.
> > >
> > > Let's not get too fancy with this.  It's simple - the host VMM admin
> > > provides trusted privileges to the VF.  The person administering the
> > > VF (if in fact it is not the same person, it usually will be) will
> > proceed to do things that require VF trusted privileges.
> >
> > Now I think that it's better to have an interface between PF and VF to
> > know the VF is trusted.
> > Otherwise VM cannot know whether its VF is trusted, that prevents
> > automatic operations.
> 
> Agreed, it would be silly for the VF to have privileges but not know that it can
> use them!
> 
> > Or add another communicating interface outside of ixgbe PF-VF mbox API?
> 
> We can't depend on any given vendor specific interface.  I'd add a very clear
> comment in the Physical Function ndo op that gives a VF trusted privileges
> that it is up to the driver to notify the VF driver.  But yes, in the case of Intel
> drivers the mailbox or admin queue (for i40e) would be the mechanism to do
> that.  I know you have some ixgbe patches that coincide with this patch so
> that's a good place to look.
>

Now why I am not against this (VF knowing it is "trusted") happening I don't see the need for it either.  I believe the same could be accomplished by allowing the PF to ask for whatever configuration it wants and some requests will not be granted by the PF unless the VF is trusted.  Given, this may require an extension of the mailbox messages to allow for NAK's to make it clear to the VF the request wasn't granted.

However like Greg mentions above this need not be requirement, different drivers could implement this way or not.
 
> >
> > >
> > >
> > > .  It
> > > > should request MC Promisc and get it if it is trusted and not if
> > > > it is not trusted.  So if you (as the system admin know you have a
> > > > VF that will need to request MC Promisc make sure you promote that
> > > > VF to trusted before assigning it to a VM.  That way when it
> > > > requests MC Promisc the PF will be able to grant it.
> > > >
> > >
> > > Multicast promiscuous should be allowed for the VFs.  We already
> > > allow VFs to set whatever multicast filters they want so if they
> > > want to go into MPE then so what?  We don't care.  It's not a security risk.
> > > Right now, without any modification, the VF can set 30 multicast
> > > filters and listen.  It can then remove those and set another 30
> > > filters
> > and listen.  And so on and so on.  So if a VF can already listen on
> > any MC filter it wants then why this artificial restriction on MC
> > promiscuous mode.
> >
> > I'm fine with that, previously I mentioned about that.
> > Without resetting PF, we can listen every MC packet which hash was set.
> > PF reset will restore the last 30 MC addresses per VF.
> >
> > Also there is a single hash entries table, all VFs will got a MC
> > packet which hash was set in the table. If a VF user set a filter,
> > other users will receive that MC packet.
> >
> > >
> > > We don't care about this case. Unicast promiscuous is the security
> > > risk
> > and I think we've handled that.
> >
> > So, should we separate the discussion, about trusting VF operation and
> > about MC promiscuous?
> 
> Yes.  And to my mind it shouldn't really be in the context of virtual function
> privilege or trust.

If I remember correct the reasoning behind requiring a VF to be "trusted" to enter MC Promiscuous mode was not for security as much as the very real potential that it would have a large negative impact on all the other VF due to  frame duplication.  So rather than allow any VF to enter this mode and adversely affect all the other VF's we require that the VF be "trusted", implying that PF understands this risk and is ok with it.  

> 
> >
> > >
> > > >
> > > > >
> > > > > And what do you think about being untrusted from trusted state?
> > > >
> > > > This is an interesting question.  If we allowed a VM to go from
> > > > trusted -> untrusted we would have to turn off any "special"
> > > > configuration that trusted allowed.  Maybe in such cases we could
> > > > reset the PF?  And of course require all the "special"
> > > > configuration (MC Promisc) to default to off after being reset.
> > > >
> > >
> > > To remove privileges from a VF that you're already set to privileged
> > > will require destruction of the VF VSI and VFLR to the VF - after it
> > comes up it can't do any further privileged operations.
> >
> > yeah, sounds good to reset VF on changing privilege.
> >
> > >
> > > [snip
> > >
> > > > This too is a valid point.  Currently we would just not do it (MC
> > > > Promisc) and the VF would have to figure that out for itself.
> > > > Passing a NAK back to the VF might be nicer. :)  Of course I
> > > > assumed the sysadm would know that he/she wanted to give a VF
> > > > trusted status and would do that before the VF was even assigned
> > > > to a VM, so the issue would never come up.  Maybe that is not valid for
> your use case?
> > >
> > > Let's not worry about MC promiscuous mode.  As I pointed out above
> > > we already let VFs set any MC address filters they want so that
> > > horse has
> > already left the barn.
> >
> > Do you think that VF MC promiscuous mode isn't needed to handle under
> > trusted mode, right?
> 
> Correct, that's my opinion on it given the fact that historically there has never
> been any restriction on setting MC addresses by the VF. See my comments
> above in the respect.
> 
> Thanks and regards Hiroshi,
> 
> - Greg
> 
> >
> > thanks,
> > Hiroshi
> >
> > >
> > > Focus on getting the VF privileged mode configuration going and then
> > > we're well on our way to accomplishing what we need to do.
> > >
> > > - Greg

