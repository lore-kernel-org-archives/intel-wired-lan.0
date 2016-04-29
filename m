From: =?unknown-8bit?q?Micha=C5=82_Miros=C5=82aw?= <michal.miroslaw@atendesoftware.pl>
Date: Fri, 29 Apr 2016 14:25:28 +0200
Subject: [Intel-wired-lan] [E1000-devel] i40e: Deadly GRE packet
In-Reply-To: <CALgsdbdsaE51GgGZX4hq8XrVcTKRbkWifKAxegtr44heOWAEpQ@mail.gmail.com>
References: <CAFzSZ++22adGYpR09vpx2rTh=bu1jgBz7wpB762Ampu0eEcVxg@mail.gmail.com>
 <D38E8E86660E514AB505863C19C9287C8CBF73A4@ORSMSX102.amr.corp.intel.com>
 <CAFzSZ+JFLN-TVRwSC5om13OUk0NvSXaETe931h0SEkkTxMfhGA@mail.gmail.com>
 <9BBC4E0CF881AA4299206E2E1412B626501B94A5@ORSMSX102.amr.corp.intel.com>
 <CAFzSZ++BR3zXA59skNU=bnGhgJBy_J+f+WuMgWJ7-giHYPcAnQ@mail.gmail.com>
 <CAFzSZ+KqDJ1sLjo1GLMzceNEvH=hhY=3e-7PHf+aP4v=Aj5+-w@mail.gmail.com>
 <CALgsdbdsaE51GgGZX4hq8XrVcTKRbkWifKAxegtr44heOWAEpQ@mail.gmail.com>
Message-ID: <CAFzSZ+LgL3q2YLy1Wmd6kLU_d_BcZV_U+CSu1oWQAcHQA082zw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

And I tried so hard to avoid including such scary Google keywords in my
report... ;-)

But point taken - I should have not sent all the details publicly at once.
Sorry about that.

Best Regards,
Micha? Miros?aw

2016-04-29 11:24 GMT+02:00 Pavel Odintsov <pavel.odintsov@gmail.com>:

> Hello!
>
> I'm not sure that's a right place for discussing zero-day
> vulnerabilities.  But actually, I do not know other ways how to reach
> Intel engineers with this sort of issues.
>
>
>
>
>
> On Fri, Apr 29, 2016 at 11:12 AM, Micha? Miros?aw
> <michal.miroslaw@atendesoftware.pl> wrote:
> > Hi,
> >
> > Were you able to reproduce the issue? Is there anything we can do to help
> > to a fix?
> >
> > Best Regards,
> > Micha? Miros?aw
> >
> > 2016-04-22 10:29 GMT+02:00 Micha? Miros?aw <
> > michal.miroslaw at atendesoftware.pl>:
> >
> >> There are no messages besides link up when the receiver is failing.
> >>
> >> Best Regards,
> >> Micha? Miros?aw
> >>
> >> [60757.845623] i40e: Intel(R) 40-10 Gigabit Ethernet Connection Network
> >> Driver - version 1.5.18
> >> [60757.845629] i40e: Copyright(c) 2013 - 2016 Intel Corporation.
> >> [...]
> >> [60758.316280] i40e 0000:01:00.1: fw 5.0.40043 api 1.5 nvm 5.02
> 0x80002283
> >> 0.0.0
> >> [60758.389654] i40e 0000:01:00.1: MAC address: 0c:c4:7a:bc:a1:89
> >> [60758.399911] i40e 0000:01:00.1: Query for DCB configuration failed,
> err
> >> I40E_ERR_ADMIN_QUEUE_ERROR aq_err I40E_AQ_RC_EPERM
> >> [60758.399917] i40e 0000:01:00.1: DCB init failed -53, disabled
> >> [60758.399975] i40e 0000:01:00.1: irq 107 for MSI/MSI-X
> >> [60758.399987] i40e 0000:01:00.1: irq 108 for MSI/MSI-X
> >> [60758.399998] i40e 0000:01:00.1: irq 109 for MSI/MSI-X
> >> [60758.400009] i40e 0000:01:00.1: irq 110 for MSI/MSI-X
> >> [60758.400020] i40e 0000:01:00.1: irq 111 for MSI/MSI-X
> >> [60758.400031] i40e 0000:01:00.1: irq 112 for MSI/MSI-X
> >> [60758.400042] i40e 0000:01:00.1: irq 113 for MSI/MSI-X
> >> [60758.400052] i40e 0000:01:00.1: irq 114 for MSI/MSI-X
> >> [60758.400064] i40e 0000:01:00.1: irq 116 for MSI/MSI-X
> >> [60758.400075] i40e 0000:01:00.1: irq 117 for MSI/MSI-X
> >> [60758.400086] i40e 0000:01:00.1: irq 118 for MSI/MSI-X
> >> [60758.400097] i40e 0000:01:00.1: irq 119 for MSI/MSI-X
> >> [60758.400108] i40e 0000:01:00.1: irq 120 for MSI/MSI-X
> >> [60758.400119] i40e 0000:01:00.1: irq 121 for MSI/MSI-X
> >> [60758.400130] i40e 0000:01:00.1: irq 122 for MSI/MSI-X
> >> [60758.400141] i40e 0000:01:00.1: irq 123 for MSI/MSI-X
> >> [60758.400151] i40e 0000:01:00.1: irq 124 for MSI/MSI-X
> >> [60758.400162] i40e 0000:01:00.1: irq 125 for MSI/MSI-X
> >> [60758.400173] i40e 0000:01:00.1: irq 126 for MSI/MSI-X
> >> [60758.400184] i40e 0000:01:00.1: irq 127 for MSI/MSI-X
> >> [60758.400195] i40e 0000:01:00.1: irq 128 for MSI/MSI-X
> >> [60758.400206] i40e 0000:01:00.1: irq 129 for MSI/MSI-X
> >> [60758.400217] i40e 0000:01:00.1: irq 130 for MSI/MSI-X
> >> [60758.400228] i40e 0000:01:00.1: irq 131 for MSI/MSI-X
> >> [60758.400238] i40e 0000:01:00.1: irq 132 for MSI/MSI-X
> >> [60758.400250] i40e 0000:01:00.1: irq 133 for MSI/MSI-X
> >> [60758.400260] i40e 0000:01:00.1: irq 134 for MSI/MSI-X
> >> [60758.400271] i40e 0000:01:00.1: irq 135 for MSI/MSI-X
> >> [60758.400293] i40e 0000:01:00.1: irq 136 for MSI/MSI-X
> >> [60758.400303] i40e 0000:01:00.1: irq 137 for MSI/MSI-X
> >> [60758.400313] i40e 0000:01:00.1: irq 138 for MSI/MSI-X
> >> [60758.400322] i40e 0000:01:00.1: irq 139 for MSI/MSI-X
> >> [60758.400331] i40e 0000:01:00.1: irq 140 for MSI/MSI-X
> >> [60758.400341] i40e 0000:01:00.1: irq 141 for MSI/MSI-X
> >> [60758.400351] i40e 0000:01:00.1: irq 142 for MSI/MSI-X
> >> [60758.400360] i40e 0000:01:00.1: irq 143 for MSI/MSI-X
> >> [60758.400370] i40e 0000:01:00.1: irq 144 for MSI/MSI-X
> >> [60758.400379] i40e 0000:01:00.1: irq 145 for MSI/MSI-X
> >> [60758.400388] i40e 0000:01:00.1: irq 146 for MSI/MSI-X
> >> [60758.400398] i40e 0000:01:00.1: irq 147 for MSI/MSI-X
> >> [60758.400408] i40e 0000:01:00.1: irq 148 for MSI/MSI-X
> >> [60758.400418] i40e 0000:01:00.1: irq 149 for MSI/MSI-X
> >> [60758.600290] i40e 0000:01:00.1: PCI-Express: Speed 8.0GT/s Width x8
> >> [60758.629802] i40e 0000:01:00.1: Features: PF-id[1] VFs: 32 VSIs: 34
> QP:
> >> 32 RSS FD_ATR FD_SB NTUPLE CloudF VxLAN NVGRE PTP VEPA
> >> [...]
> >> [60769.222107] i40e 0000:01:00.2 eth4: NIC Link is Up 10 Gbps Full
> Duplex,
> >> Flow Control: None
> >> [60771.217551] device eth4 entered promiscuous mode
> >> [...] test runs here, no messages during that time
> >> [60816.884307] device eth4 left promiscuous mode
> >>
> >>
> >>
> >> 2016-04-21 20:03 GMT+02:00 Wyborny, Carolyn <carolyn.wyborny@intel.com
> >:
> >>
> >>> Thanks Michal,
> >>>
> >>> Can we also get a full dmesg log from the receiving side during a
> repro?
> >>>
> >>> Carolyn
> >>>
> >>> > -----Original Message-----
> >>> > From: Micha? Miros?aw [mailto:michal.miroslaw at atendesoftware.pl]
> >>> > Sent: Thursday, April 21, 2016 8:04 AM
> >>> > To: Ronciak, John <john.ronciak@intel.com>
> >>> > Cc: e1000-devel at lists.sourceforge.net; mirq-linux at rere.qmqm.pl;
> >>> intel-wired-
> >>> > lan at lists.osuosl.org; Pawel Malachowski
> >>> > <pawel.malachowski@atendesoftware.pl>
> >>> > Subject: Re: [E1000-devel] i40e: Deadly GRE packet
> >>> >
> >>> > Dear John,
> >>> >
> >>> > We found the problem using our DPDK application, but later on we
> >>> reproduced
> >>> > the same issue using in-kernel drivers (even after fresh reboot).
> >>> >
> >>> > Best Regards,
> >>> > Micha? Miros?aw
> >>> >
> >>> > 2016-04-21 16:54 GMT+02:00 Ronciak, John <john.ronciak@intel.com>:
> >>> >
> >>> > > > -----Original Message-----
> >>> > > > From: Micha? Miros?aw [mailto:michal.miroslaw at atendesoftware.pl]
> >>> > > > Sent: Thursday, April 21, 2016 5:45 AM
> >>> > > > To: e1000-devel at lists.sourceforge.net;
> >>> intel-wired-lan at lists.osuosl.org
> >>> > > > Cc: Pawe? Ma?achowski <pawel.malachowski@atendesoftware.pl>;
> mirq-
> >>> > > > linux at rere.qmqm.pl
> >>> > > > Subject: [E1000-devel] i40e: Deadly GRE packet
> >>> > > >
> >>> > > > Dear Developers,
> >>> > > >
> >>> > > > I have a setup of a pair of SuperMicro-branded XL710s connected
> with
> >>> > > > passive crossover cable, one (eth4) is using firmware 5.0, the
> other
> >>> > > (eth7) is
> >>> > > > using fw 4.33. When I send couple of packets with no payload in
> GRE
> >>> over
> >>> > > IP
> >>> > > > over ETH from eth7 to eth4, the receiving card stops processing
> >>> further
> >>> > > > packets. It seems that 4 empty-GRE packets in succession are
> enough
> >>> to
> >>> > > kill
> >>> > > > the card's receivers (all ports stop working), more if there are
> >>> other
> >>> > > packets
> >>> > > > inbetween. Transmit direction is not affected. After reboot, the
> >>> card
> >>> > > comes
> >>> > > > back, reloading the driver (or unbind/bind) is not enough to fix
> the
> >>> > > problem.
> >>> > > >
> >>> > > > 14:31:24.299203 00:00:00:00:00:00 > ff:ff:ff:ff:ff:ff, ethertype
> >>> IPv4
> >>> > > (0x0800),
> >>> > > > length 60: (tos 0x0, ttl 64, id 1, offset 0, flags [none], proto
> GRE
> >>> > > (47), length
> >>> > > > 24)
> >>> > > >     127.0.0.1 > 127.0.0.1: GREv0, Flags [none], proto unknown
> >>> (0x0000),
> >>> > > length
> >>> > > > 4
> >>> > > >         gre-proto-0x0
> >>> > > >         0x0000:  4500 0018 0001 0000 402f 7cb4 7f00 0001
> E.......@
> >>> > > /|.....
> >>> > > >         0x0010:  7f00 0001 0000 0000 0000 0000 0000 0000
> >>> > > ................
> >>> > > >         0x0020:  0000 0000 0000 0000 0000 0000 0000
> >>>  ..............
> >>> > > >
> >>> > > > scapy 2.2.0 generates this packet from: Ether()/IP()/GRE()
> >>> > > >
> >>> > > > Tested on stock Debian kernel, with in-kernel driver and one from
> >>> > > DPDK-2.2.
> >>> > > > Linux lab1 3.16.0-4-amd64 #1 SMP Debian 3.16.7-ckt25-2
> (2016-04-08)
> >>> > > x86_64
> >>> > > > GNU/Linux
> >>> > > >
> >>> > > > Best Regards,
> >>> > > > Micha? Miros?aw
> >>> > > How exactly is DPDK involved?  Is it running in all instances where
> >>> the
> >>> > > issue is seen?  Have you tried the latest i40e driver from our
> >>> Sourceforge
> >>> > > site (http://e1000.sf.net)?
> >>> > >
> >>> > > Cheers,
> >>> > > John
> >>> > >
> >>> > >
> >>> > >
> >>>
> >>
> >>
> >
> >
> ------------------------------------------------------------------------------
> > Find and fix application performance issues faster with Applications
> Manager
> > Applications Manager provides deep performance insights into multiple
> tiers of
> > your business applications. It resolves application problems quickly and
> > reduces your MTTR. Get your free trial!
> > https://ad.doubleclick.net/ddm/clk/302982198;130105516;z
> > _______________________________________________
> > E1000-devel mailing list
> > E1000-devel at lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/e1000-devel
> > To learn more about Intel&#174; Ethernet, visit
> http://communities.intel.com/community/wired
> >
>
>
>
> --
> Sincerely yours, Pavel Odintsov
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160429/454330ea/attachment.html>
