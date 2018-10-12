From: Jags N <jagsnn@gmail.com>
Date: Sat, 13 Oct 2018 00:49:20 +0530
Subject: [Intel-wired-lan] fm10k driver - flow control question
In-Reply-To: <02874ECE860811409154E81DA85FBB5884CD2A9E@ORSMSX115.amr.corp.intel.com>
References: <CALQkTo1P_QAyW+y_LE=LFK=y+oDfScqZJLxjdn7eifofNbycAQ@mail.gmail.com>
 <CAKgT0UetdOGsVPLu3Ji23FXq_dVVxWPSGsZjDLW9JX3q=CBSEQ@mail.gmail.com>
 <CALQkTo2eqJs0pJcjkGh3bs0yhJ5iz2SJ_e8G+9zYYm2H-k6HQw@mail.gmail.com>
 <CAKgT0Uf-oafDZR7yba1frBQ-iheD+qHg1Hb2G5rBvv4=fEgtzw@mail.gmail.com>
 <9BBC4E0CF881AA4299206E2E1412B6267C64AC16@ORSMSX102.amr.corp.intel.com>
 <CALQkTo03Eh85vmx2-Rt_1g8r9FpecQPh7bbE2-PjQnOu_yS+oQ@mail.gmail.com>
 <02874ECE860811409154E81DA85FBB5884CD29DD@ORSMSX115.amr.corp.intel.com>
 <02874ECE860811409154E81DA85FBB5884CD2A9E@ORSMSX115.amr.corp.intel.com>
Message-ID: <CALQkTo0grSAyR+ObLL3tSG9ev6b-XFVgHHZfjODRNU0MG7xO2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Jake,

Thanks much for clarifying.

"Basically, there is no method to flow control or equivalent between the
PEP (host interface) and the switch".

If the above is the case, can an Application on the Host, if able to send
Priority Flow Control Pause frames towards the switch, be able to pause the
Switch from transmitting frames towards Host ?

Regards,
Jagdish

On Thu, Oct 11, 2018 at 11:05 PM Keller, Jacob E <jacob.e.keller@intel.com>
wrote:

>
>
> > -----Original Message-----
> > From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of
> > Keller, Jacob E
> > Sent: Thursday, October 11, 2018 9:31 AM
> > To: Jags N <jagsnn@gmail.com>; Wyborny, Carolyn <
> carolyn.wyborny at intel.com>
> > Cc: intel-wired-lan at osuosl.org
> > Subject: Re: [Intel-wired-lan] fm10k driver - flow control question
> >
> > Hi,
> >
> > > -----Original Message-----
> > > From: Jags N [mailto:jagsnn at gmail.com]
> > > Sent: Wednesday, October 10, 2018 10:50 PM
> > > To: Wyborny, Carolyn <carolyn.wyborny@intel.com>
> > > Cc: Alexander Duyck <alexander.duyck@gmail.com>;
> intel-wired-lan at osuosl.org;
> > > Keller, Jacob E <jacob.e.keller@intel.com>
> > > Subject: Re: [Intel-wired-lan] fm10k driver - flow control question
> > >
> > > Thanks Alex, Carolyn.
> > >
> > > Hi Jake,
> > >
> > > The question I have is on fm10k pcie host interface to control host
> congestion,
> > >
> > > "PCIE_RXDCTL.DropOnEmpty" if not set, can hold the packet till
> > > "PCIE_DMA_CTRL.MaxHoldTime" expires, after which the queue is set to
> DROP to
> > > avoid future time out on this queue.
> > >
> > > "PCIE_DMA_CTRL.MaxHoldTime" is defined as log2() of maximum waiting
> time for
> > > descriptors to become available.The maximum time is 2^^31 * PCLK.
> > >
> >
> > Yes.
> >
> > > With PCLK at 500 MHz for Gen3.0, is the following calculation and
> understanding
> > > correct,
> > > (2^^31 * PCLK) means, 2^^31 * 2ns = 4294967296 ns = 4 sec, is the
> maximum hold
> > > time that the back pressure on the internal switch will be present
> after which the
> > > queue is set to Drop.
> >
> > The 4 second time is correct.
> >
> > > Kindly advice.
> >
> > However, I do not know how this backpressures (if any) to the switch.
> The RRC has an
> > internal cache of descriptors for which it will hold packets. Eventually
> these will fill up,
> > even as it waits for Rx descriptors from the host interface software
> memory. I do not
> > know if the switch internals actually do any "back pressuring" here.
> >
> > I'm going to ask somoene internally who knows the switch part better
> than I do. I
> > hope to have an answer.
> >
> > >
> > > Regards,
> > > Jagdish
> > >
>
> To follow up on this. I talked to one of the engineers who knows more
> about the switch hardware. Basically, there is no method to flow control or
> equivalent between the PEP (host interface) and the switch.
>
> Thanks,
> Jake
>
>
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20181013/5ce31338/attachment-0001.html>
