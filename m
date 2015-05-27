From: Rose, Gregory V <gregory.v.rose@intel.com>
Date: Wed, 27 May 2015 15:55:02 +0000
Subject: [Intel-wired-lan] [PATCH v5 3/3] ixgbe: Add new ndo to trust VF
In-Reply-To: <F6FB0E698C9B3143BDF729DF22286646912FE16E@ORSMSX110.amr.corp.intel.com>
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
 <5565887B.5010808@solarflare.com>
 <F6FB0E698C9B3143BDF729DF22286646912FE16E@ORSMSX110.amr.corp.intel.com>
Message-ID: <C5551D9AAB213A418B7FD5E4A6F30A07892FD632@ORSMSX108.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Skidmore, Donald C
> Sent: Wednesday, May 27, 2015 8:34 AM
> To: Edward Cree; Hiroshi Shimamoto
> Cc: Rose, Gregory V; Kirsher, Jeffrey T; intel-wired-lan at lists.osuosl.org;
> nhorman at redhat.com; jogreene at redhat.com; Linux Netdev List; Choi, Sy Jong;
> Rony Efraim; David Miller; Or Gerlitz; sassmann at redhat.com
> Subject: RE: [PATCH v5 3/3] ixgbe: Add new ndo to trust VF
> 
> 
> 
> > -----Original Message-----
> > From: Edward Cree [mailto:ecree at solarflare.com]
> > Sent: Wednesday, May 27, 2015 2:04 AM
> > To: Hiroshi Shimamoto
> > Cc: Rose, Gregory V; Skidmore, Donald C; Kirsher, Jeffrey T;
> > intel-wired- lan at lists.osuosl.org; nhorman at redhat.com;
> > jogreene at redhat.com; Linux Netdev List; Choi, Sy Jong; Rony Efraim;
> > David Miller; Or Gerlitz; sassmann at redhat.com
> > Subject: Re: [PATCH v5 3/3] ixgbe: Add new ndo to trust VF
> >
> > On 27/05/15 01:27, Hiroshi Shimamoto wrote:
> > >>> I think the VF shouldn't directly know whether it is trusted or
> > >>> not
> > >> That's completely irrevelant.  The person administering the PF will
> > >> be the person who provided trusted privileges to the VF.  He'll
> > >> then
> > >> *tell* or somehow other communicate to the person administering the
> > VF (probably himself/herself) and then proceed to execute commands on
> > that VF that require trusted privileges.
> > >>
> > >> If the VF does not have trusted privileges then the commands to add
> > >> VLAN filters, set promiscuous modes, and any other privileged
> > >> commands
> > will fail.
> > >>
> > >> Let's not get too fancy with this.  It's simple - the host VMM
> > >> admin provides trusted privileges to the VF.  The person
> > >> administering the VF (if in fact it is not the same person, it
> > >> usually will be) will proceed to do
> > things that require VF trusted privileges.
> > > Now I think that it's better to have an interface between PF and VF
> > > to
> > know the VF is trusted.
> > > Otherwise VM cannot know whether its VF is trusted, that prevents
> > automatic operations.
> > I don't think this is right.  The approach to VF trust/permissions
> > issues we took in sfc (and that I'd recommend following) was that all
> > drivers will always _attempt_ actions on the assumption they have
> > privilege, then if they in fact don't, they get an EPERM (either from
> > the firmware or from some proxy in the PF driver) and they deal with
> that appropriately.
> >
> > So in this case the VF would say "I have more than 30 mcast addrs, I
> > need promisc", it would try to set promisc, the PF would decide "it's
> > not trusted, Denied" and the VF would get an EPERM back.  At which
> > point the VF would presumably insert as many mcast addresses as it
> > could and warn that it hadn't got them all (or, if the whole thing was
> > triggered by adding a new mcast addr, it might be able to pass EPERM
> back to whoever requested it).
> >
> > Then if the VF's privilege is changed, VFLR it so that it re-does all
> > of its setup this time subject to the new permissions.
> > (Alternatively, if the privilege is strictly increased, you can choose
> > not to do this and instead the VF driver may be told from userspace to
> > re-do the relevant setup, in which case traffic interruption may be
> > able to be avoided.)
> >
> > The advantage of this model is that the VF driver doesn't have to know
> > what permissions different operations require; that knowledge can live
> > in one place only (in our case the firmware, in your case it sounds
> > like the PF driver) allowing the policy to be changed without problems
> with version skew.
> >
> > The disadvantages are that the amount of control-plane traffic is
> > increased (try, fail, try something else), and reinitialisation on
> > privilege change may cause traffic interruption.  But the former isn't
> > a worry since the control plane traffic volume is so small.  The
> > latter would still have to happen on privilege decrease in any case, as
> Greg stated.
> 
> This is how I had envisioned it working as well.  The VF can ask for what
> it wants, whether it receives it is dependent on if the PF considers it
> trusted or not.  As Hiroshi already mentioned (among others) we may need
> to have the mailbox protocol extended to allow the PF to tell the VF it
> didn't get what was asked for.

Hmm... well I think it's easier in the Intel case to just tell the VF it has privileges and it reduces complexity of all the additional NAKs and retries.  That said, if other vendors wish to go that route then they do not *have* to tell the VF that it has additional privileges and then they can add all the additional complexity of the NAKs and retries.  There's nothing to prevent any vendor from notifying a VF that it has privileges and there's nothing that require that they do.  This should be a vendor specific detail.

In the case of Intel controllers - I prefer that we create an Intel specific mailbox message that tells the VF it's got privileges and cuts down on the amount of hand shaking that goes on in mailbox (igb, ixgbe) or admin queue (i40e) messaging.

So now that I've stated my preference let me also state that I do not want to hold up acceptance of the Hiroshi's if_link patch that sets the trusted/privileged state for the VF while we further discuss this driver specific detail.

- Greg

