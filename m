From: Rose, Gregory V <gregory.v.rose@intel.com>
Date: Wed, 27 May 2015 16:19:04 +0000
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
Message-ID: <C5551D9AAB213A418B7FD5E4A6F30A07892FD723@ORSMSX108.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


> -----Original Message-----
> From: Skidmore, Donald C
> Sent: Wednesday, May 27, 2015 9:01 AM
> To: Rose, Gregory V; Hiroshi Shimamoto; Kirsher, Jeffrey T; intel-wired-
> lan at lists.osuosl.org
> Cc: nhorman at redhat.com; jogreene at redhat.com; Linux Netdev List; Choi, Sy
> Jong; Rony Efraim; David Miller; Edward Cree; Or Gerlitz;
> sassmann at redhat.com
> Subject: RE: [PATCH v5 3/3] ixgbe: Add new ndo to trust VF
> 
> 
> 
> > -----Original Message-----
> > From: Rose, Gregory V
> > Sent: Tuesday, May 26, 2015 7:01 PM
> > To: Hiroshi Shimamoto; Skidmore, Donald C; Kirsher, Jeffrey T;
> > intel-wired- lan at lists.osuosl.org
> > Cc: nhorman at redhat.com; jogreene at redhat.com; Linux Netdev List; Choi,
> > Sy Jong; Rony Efraim; David Miller; Edward Cree; Or Gerlitz;
> > sassmann at redhat.com
> > Subject: RE: [PATCH v5 3/3] ixgbe: Add new ndo to trust VF

[snip]

> >
> >
> >
> > We can't depend on any given vendor specific interface.  I'd add a
> > very clear comment in the Physical Function ndo op that gives a VF
> > trusted privileges that it is up to the driver to notify the VF
> > driver.  But yes, in the case of Intel drivers the mailbox or admin
> > queue (for i40e) would be the mechanism to do that.  I know you have
> > some ixgbe patches that coincide with this patch so that's a good place
> to look.
> >
> 
> Now why I am not against this (VF knowing it is "trusted") happening I
> don't see the need for it either.  I believe the same could be
> accomplished by allowing the PF to ask for whatever configuration it wants
> and some requests will not be granted by the PF unless the VF is trusted.
> Given, this may require an extension of the mailbox messages to allow for
> NAK's to make it clear to the VF the request wasn't granted.
> 
> However like Greg mentions above this need not be requirement, different
> drivers could implement this way or not.
> 
> > >
> > > >
> > > >
> > > > .  It
> > > > > should request MC Promisc and get it if it is trusted and not if
> > > > > it is not trusted.  So if you (as the system admin know you have
> > > > > a VF that will need to request MC Promisc make sure you promote
> > > > > that VF to trusted before assigning it to a VM.  That way when
> > > > > it requests MC Promisc the PF will be able to grant it.
> > > > >
> > > >
> > > > Multicast promiscuous should be allowed for the VFs.  We already
> > > > allow VFs to set whatever multicast filters they want so if they
> > > > want to go into MPE then so what?  We don't care.  It's not a
> security risk.
> > > > Right now, without any modification, the VF can set 30 multicast
> > > > filters and listen.  It can then remove those and set another 30
> > > > filters
> > > and listen.  And so on and so on.  So if a VF can already listen on
> > > any MC filter it wants then why this artificial restriction on MC
> > > promiscuous mode.
> > >
> > > I'm fine with that, previously I mentioned about that.
> > > Without resetting PF, we can listen every MC packet which hash was
> set.
> > > PF reset will restore the last 30 MC addresses per VF.
> > >
> > > Also there is a single hash entries table, all VFs will got a MC
> > > packet which hash was set in the table. If a VF user set a filter,
> > > other users will receive that MC packet.
> > >
> > > >
> > > > We don't care about this case. Unicast promiscuous is the security
> > > > risk
> > > and I think we've handled that.
> > >
> > > So, should we separate the discussion, about trusting VF operation
> > > and about MC promiscuous?
> >
> > Yes.  And to my mind it shouldn't really be in the context of virtual
> > function privilege or trust.
> 
> If I remember correct the reasoning behind requiring a VF to be "trusted"
> to enter MC Promiscuous mode was not for security as much as the very real
> potential that it would have a large negative impact on all the other VF
> due to  frame duplication.  So rather than allow any VF to enter this mode
> and adversely affect all the other VF's we require that the VF be
> "trusted", implying that PF understands this risk and is ok with it.
> 

Allowing promiscuous mode operation by the VF was really a security concern during the initial design phases for SR-IOV way back in 2007/2008 but since Intel Virtual Functions for 1Gig and 10Gig didn't support promiscuous anyway it was a moot point.

Limitations on the number of multicast address filters available to a VF were simply an implementation detail due to the size of the mailbox - one that had nothing to do with security or worries about flooding the PCIe bus.

That said, if the community feels that allowing multicast promiscuous for VFs should be part of being "trusted" then I'm fine with that and have no objection to requiring "trusted" mode for enablement of multicast promiscuous mode.

- Greg
