From: Hiroshi Shimamoto <h-shimamoto@ct.jp.nec.com>
Date: Mon, 15 Jun 2015 10:39:37 +0000
Subject: [Intel-wired-lan] [PATCH v5 3/3] ixgbe: Add new ndo to trust VF
In-Reply-To: <F6FB0E698C9B3143BDF729DF22286646912FE19D@ORSMSX110.amr.corp.intel.com>
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
 <F6FB0E698C9B3143BDF729DF22286646912FE19D@ORSMSX110.amr.corp.intel.com>
Message-ID: <7F861DC0615E0C47A872E6F3C5FCDDBD05EDEF30@BPXM14GP.gisp.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> > -----Original Message-----
> > From: Rose, Gregory V
> > Sent: Tuesday, May 26, 2015 7:01 PM
> > To: Hiroshi Shimamoto; Skidmore, Donald C; Kirsher, Jeffrey T; intel-wired-
> > lan at lists.osuosl.org
> > Cc: nhorman at redhat.com; jogreene at redhat.com; Linux Netdev List; Choi,
> > Sy Jong; Rony Efraim; David Miller; Edward Cree; Or Gerlitz;
> > sassmann at redhat.com
> > Subject: RE: [PATCH v5 3/3] ixgbe: Add new ndo to trust VF
> >
> >
> > > -----Original Message-----
> > > From: Hiroshi Shimamoto [mailto:h-shimamoto at ct.jp.nec.com]
> > > Sent: Tuesday, May 26, 2015 5:28 PM
> > > To: Rose, Gregory V; Skidmore, Donald C; Kirsher, Jeffrey T;
> > > intel-wired- lan at lists.osuosl.org
> > > Cc: nhorman at redhat.com; jogreene at redhat.com; Linux Netdev List; Choi,
> > > Sy Jong; Rony Efraim; David Miller; Edward Cree; Or Gerlitz;
> > > sassmann at redhat.com
> > > Subject: RE: [PATCH v5 3/3] ixgbe: Add new ndo to trust VF
> > >
> > > > > -----Original Message-----
> > > > > From: Skidmore, Donald C
> > > > > Sent: Tuesday, May 26, 2015 10:46 AM
> > > > > To: Hiroshi Shimamoto; Rose, Gregory V; Kirsher, Jeffrey T;
> > > > > intel-wired- lan at lists.osuosl.org
> > > > > Cc: nhorman at redhat.com; jogreene at redhat.com; Linux Netdev List;
> > > > > Choi, Sy Jong; Rony Efraim; David Miller; Edward Cree; Or Gerlitz;
> > > > > sassmann at redhat.com
> > > > > Subject: RE: [PATCH v5 3/3] ixgbe: Add new ndo to trust VF
> > > > >
> > > > >
> > > >
> > > > [snip]
> > > >
> > > > >
> > > > > > -----Original Message-----
> > > > > > From: Hiroshi Shimamoto [mailto:h-shimamoto at ct.jp.nec.com]
> > > > > > Sent: Monday, May 25, 2015 6:00 PM
> > > > > > To: Skidmore, Donald C; Rose, Gregory V; Kirsher, Jeffrey T;
> > > > > > intel-wired- lan at lists.osuosl.org
> > > > > > Cc: nhorman at redhat.com; jogreene at redhat.com; Linux Netdev List;
> > > > > > Choi, Sy Jong; Rony Efraim; David Miller; Edward Cree; Or
> > > > > > Gerlitz; sassmann at redhat.com
> > > > > > Subject: RE: [PATCH v5 3/3] ixgbe: Add new ndo to trust VF
> > > > > >
> > > > > >
> > > > > > Do you mean that VF should care about it is trusted or not?
> > > > > > Should VF request MC Promisc again when it's trusted?
> > > > > > Or, do you mean VF never be trusted during its (or VM's) lifetime?
> > > > >
> > > > > I think the VF shouldn't directly know whether it is trusted or
> > > > > not
> > > >
> > > > That's completely irrevelant.  The person administering the PF will
> > > > be the person who provided trusted privileges to the VF.  He'll then
> > > > *tell* or somehow other communicate to the person administering the
> > > > VF
> > > (probably himself/herself) and then proceed to execute commands on
> > > that VF that require trusted privileges.
> > > >
> > > > If the VF does not have trusted privileges then the commands to add
> > > > VLAN filters, set promiscuous modes, and any other privileged
> > > > commands
> > > will fail.
> > > >
> > > > Let's not get too fancy with this.  It's simple - the host VMM admin
> > > > provides trusted privileges to the VF.  The person administering the
> > > > VF (if in fact it is not the same person, it usually will be) will
> > > proceed to do things that require VF trusted privileges.
> > >
> > > Now I think that it's better to have an interface between PF and VF to
> > > know the VF is trusted.
> > > Otherwise VM cannot know whether its VF is trusted, that prevents
> > > automatic operations.
> >
> > Agreed, it would be silly for the VF to have privileges but not know that it can
> > use them!
> >
> > > Or add another communicating interface outside of ixgbe PF-VF mbox API?
> >
> > We can't depend on any given vendor specific interface.  I'd add a very clear
> > comment in the Physical Function ndo op that gives a VF trusted privileges
> > that it is up to the driver to notify the VF driver.  But yes, in the case of Intel
> > drivers the mailbox or admin queue (for i40e) would be the mechanism to do
> > that.  I know you have some ixgbe patches that coincide with this patch so
> > that's a good place to look.
> >
> 
> Now why I am not against this (VF knowing it is "trusted") happening I don't see the need for it either.  I believe the
> same could be accomplished by allowing the PF to ask for whatever configuration it wants and some requests will not be
> granted by the PF unless the VF is trusted.  Given, this may require an extension of the mailbox messages to allow for
> NAK's to make it clear to the VF the request wasn't granted.
> 
> However like Greg mentions above this need not be requirement, different drivers could implement this way or not.
> 

Now I'm preparing a patchset to handle an error against VF MC promisc request.
I'm not sure that which is better to have new mailbox API which indicates VF is trusted.

I made a patchset which doesn't add new API but handles error against VF MC promisc request.
Will submit it.

thanks,
Hiroshi
