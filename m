From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 26 Jul 2021 10:41:50 +0800
Subject: [Intel-wired-lan] [PATCH net] i40e: introduce pseudo number of
 cpus for compatibility
In-Reply-To: <CAL+tcoAtFTmFtKR2QLY_UdQWkc9Avyw3ZtaA_cD_4cXAGXRBDQ@mail.gmail.com>
References: <20210707094133.24597-1-kerneljasonxing@gmail.com>
 <CAL+tcoCc+r96Bv8aDXTwY5h_OYTz8sHxdpPW7OuNfdDz+ssYYg@mail.gmail.com>
 <03b846e9906d27ef7a6e84196a0840fdd54ca13d.camel@intel.com>
 <CAL+tcoAtFTmFtKR2QLY_UdQWkc9Avyw3ZtaA_cD_4cXAGXRBDQ@mail.gmail.com>
Message-ID: <CAL+tcoBk=s_QZv08wetLG8jeUCX-ECddOWeOgeLnPB_X41juvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Anthony L,

Do you have any progress or any idea on the final patch? Or you could
point out some more detailed method to rework the calculation of the
queue pile.

I think it's critical and has an impact on all the old nics, which
means thousands of machines would crash if xdp-drv program is loaded.

Thanks,
Jason

On Thu, Jul 15, 2021 at 10:33 AM Jason Xing <kerneljasonxing@gmail.com> wrote:
>
> On Thu, Jul 15, 2021 at 4:52 AM Nguyen, Anthony L
> <anthony.l.nguyen@intel.com> wrote:
> >
> > On Fri, 2021-07-09 at 15:13 +0800, Jason Xing wrote:
> > > Oh, one more thing I missed in the last email is that all the
> > > failures
> > > are happening on the combination of X722 10GbE and 1GbE. So the value
> > > of @num_tx_qp  the driver fetches is 384 while the value is 768
> > > without x722 1GbE.
> > >
> > > I get that information back here:
> > > $ lspci | grep -i ether
> > > 5a:00.0 Ethernet controller: Intel Corporation Ethernet Connection
> > > X722 for 10GbE SFP+ (rev 09)
> > > 5a:00.1 Ethernet controller: Intel Corporation Ethernet Connection
> > > X722 for 10GbE SFP+ (rev 09)
> > > 5a:00.2 Ethernet controller: Intel Corporation Ethernet Connection
> > > X722 for 1GbE (rev 09)
> > > 5a:00.3 Ethernet controller: Intel Corporation Ethernet Connection
> > > X722 for 1GbE (rev 09)
> > >
> > > I know it's really stupid to control the number of online cpus, but
> > > finding a good way only to limit the @alloc_queue_pairs is not easy
> > > to
> > > go. So could someone point out a better way to fix this issue and
> > > take
> > > care of some relatively old nics with the number of cpus increasing?
> >
> > Hi Jason,
> >
> > Sorry for the slow response; I was trying to talk to the i40e team
> > about this.
>
> Thanks for your kind help really. It indeed has a big impact on thousands
> of machines.
>
> >
> > I agree, the limiting of number of online CPUs doesn't seem like a
> > solution we want to pursue. The team is working on a patch that deals
>
> As I said above, if the machine is equipped with only 10GbE nic, the maximum
> online cpus would be 256 and so on. For now, it depends on the num of cpus.
>
> > with the same, or similiar, issue; it is reworking the allocations of
> > the queue pile. I'll make sure that they add you on the patch when it
>
> It's not easy to cover all kinds of cases. But I still believe it's
> the only proper
> way to fix the issue. Looking forward to your patch :)
>
> > is sent so that you can try this and see if it resolves your issue.
> >
>
> Yeah, sure, I will double-check and then see if it's really fixed.
>
> Thanks,
> Jason
>
> > Thanks,
> > Tony
> >
