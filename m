From: Wyborny, Carolyn <carolyn.wyborny@intel.com>
Date: Wed, 10 Oct 2018 15:54:05 +0000
Subject: [Intel-wired-lan] fm10k driver - flow control question
In-Reply-To: <CAKgT0Uf-oafDZR7yba1frBQ-iheD+qHg1Hb2G5rBvv4=fEgtzw@mail.gmail.com>
References: <CALQkTo1P_QAyW+y_LE=LFK=y+oDfScqZJLxjdn7eifofNbycAQ@mail.gmail.com>
 <CAKgT0UetdOGsVPLu3Ji23FXq_dVVxWPSGsZjDLW9JX3q=CBSEQ@mail.gmail.com>
 <CALQkTo2eqJs0pJcjkGh3bs0yhJ5iz2SJ_e8G+9zYYm2H-k6HQw@mail.gmail.com>
 <CAKgT0Uf-oafDZR7yba1frBQ-iheD+qHg1Hb2G5rBvv4=fEgtzw@mail.gmail.com>
Message-ID: <9BBC4E0CF881AA4299206E2E1412B6267C64AC16@ORSMSX102.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On Behalf
> Of Alexander Duyck
> Sent: Wednesday, October 10, 2018 8:26 AM
> To: jagsnn at gmail.com
> Cc: intel-wired-lan at osuosl.org
> Subject: Re: [Intel-wired-lan] fm10k driver - flow control question
> 
> Hi Jagdish,
> 
> I think you have gotten beyond what I can handle from just memory.
> Hopefully somebody from the networking team can address the rest of
> the question as I have no recollection of the hold time logic.

Adding Jake explicitly for additional info.

Thanks,

Carolyn
> 
> Thanks.
> 
> - Alex
> 
> On Wed, Oct 10, 2018 at 6:40 AM Jags N <jagsnn@gmail.com> wrote:
> >
> > Hi Alex,
> >
> > Thank You ! That really helped me understand the scope of the
> implementation.
> >
> > If I may ask, I see that  "PCIE_RXDCTL.DropOnEmpty" if not set, can hold
> the packet till "PCIE_DMA_CTRL.MaxHoldTime" expires, after which the
> queue is set to DROP to avoid future time out on this queue.
> >
> > "PCIE_DMA_CTRL.MaxHoldTime" is defined as log2() of maximum waiting
> time for descriptors to become available.The maximum time is 2^^31 * PCLK.
> >
> > With PCLK at 500 MHz for Gen3.0, would the following calculation be
> correct :
> >
> > (2^^31 * PCLK) means, 2^^31 * 2ns = 4294967296 ns = 4 sec, is the
> maximum hold time that the back pressure on the internal switch will be
> present after which the queue is set to Drop.
> >
> > Appreciate much your kind response.
> >
> > Regards,
> > Jagdish
> >
> > On Tue, Oct 9, 2018 at 10:54 PM Alexander Duyck
> <alexander.duyck@gmail.com> wrote:
> >>
> >> On Tue, Oct 9, 2018 at 10:12 AM Jags N <jagsnn@gmail.com> wrote:
> >> >
> >> > Hi,
> >> >
> >> > In FM10k intel data sheet, I see that the PCIe End Point (PEP) does not
> support generation of link based flow control or class based/priority based
> flow control pause frames to prevent Host Congestion.
> >> >
> >> > The same behaviour is oberved in dpdk 18.08 fm10k driver, wherein
> there is no pfc get or set driver functions defined, which I believe is
> consistent with data sheet.
> >> >
> >> > But, in FM10K linux driver ver 0.26.1 (latest), there is code for setting dcb
> ets, pfc, dcbx. So I am a bit confused as to how the fm10k driver could
> support pfc if the hardware data sheet does not mention about it.
> >> >
> >> > Could someone help me understand or provide any pointers to
> documents that details what kind of support is present in 0.26.1 with respect
> to pfc on PEP, and if fm10k can support pfc setting/getting on PEP interface to
> protect Host Congestion.
> >> >
> >> > Regards,
> >> > Jagdish
> >>
> >> It has been a little over 4 years since I wrote the driver so my
> >> recollection on this could be a bit rusty, but I believe most of the
> >> DCB code in the fm10k linux driver is related to configuring queues
> >> associated with traffic classes. Also while the part doesn't support
> >> PFC from the PCIe End Point it does have a bit called "DROP_ON_EMPTY"
> >> in the RXDCTL register of each queue that determines if we just drop
> >> the packet or put backpressure on the internal switch if the Rx ring
> >> doesn't have available descriptors. I believe that is how the DCB
> >> implementation for the Linux driver is configured.
> >>
> >> Thanks.
> >>
> >> - Alex
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
