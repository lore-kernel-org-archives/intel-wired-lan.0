From: =?unknown-8bit?q?Micha=C5=82_Miros=C5=82aw?= <michal.miroslaw@atendesoftware.pl>
Date: Thu, 21 Apr 2016 17:29:09 +0200
Subject: [Intel-wired-lan] [E1000-devel] i40e: Deadly GRE packet
In-Reply-To: <D38E8E86660E514AB505863C19C9287C8CBF7487@ORSMSX102.amr.corp.intel.com>
References: <CAFzSZ++22adGYpR09vpx2rTh=bu1jgBz7wpB762Ampu0eEcVxg@mail.gmail.com>
 <D38E8E86660E514AB505863C19C9287C8CBF73A4@ORSMSX102.amr.corp.intel.com>
 <CAFzSZ+JFLN-TVRwSC5om13OUk0NvSXaETe931h0SEkkTxMfhGA@mail.gmail.com>
 <D38E8E86660E514AB505863C19C9287C8CBF7487@ORSMSX102.amr.corp.intel.com>
Message-ID: <CAFzSZ+KCSZZ+LSCX0c4++6zTtv_OjGHpbSC2aC9rU=N_pCRE0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear John,

The issue also manifests itself with the Sourceforge driver.

# ethtool -i eth4
driver: i40e
version: 1.5.18
firmware-version: 5.02 0x80002283 0.0.0
bus-info: 0000:01:00.2
supports-statistics: yes
supports-test: yes
supports-eeprom-access: yes
supports-register-dump: yes
supports-priv-flags: yes

Best Regards,
Micha? Miros?aw

2016-04-21 17:19 GMT+02:00 Ronciak, John <john.ronciak@intel.com>:

> Thanks, Please get us the other information we have asked for.
>
>
>
> Cheers,
>
> John
>
>
>
> *From:* Micha? Miros?aw [mailto:michal.miroslaw at atendesoftware.pl]
> *Sent:* Thursday, April 21, 2016 8:04 AM
> *To:* Ronciak, John <john.ronciak@intel.com>
> *Cc:* e1000-devel at lists.sourceforge.net; intel-wired-lan at lists.osuosl.org;
> Pawel Malachowski <pawel.malachowski@atendesoftware.pl>;
> mirq-linux at rere.qmqm.pl
> *Subject:* Re: [E1000-devel] i40e: Deadly GRE packet
>
>
>
> Dear John,
>
>
>
> We found the problem using our DPDK application, but later on we
> reproduced the same issue using in-kernel drivers (even after fresh reboot).
>
>
>
> Best Regards,
>
> Micha? Miros?aw
>
>
>
> 2016-04-21 16:54 GMT+02:00 Ronciak, John <john.ronciak@intel.com>:
>
> > -----Original Message-----
> > From: Micha? Miros?aw [mailto:michal.miroslaw at atendesoftware.pl]
> > Sent: Thursday, April 21, 2016 5:45 AM
> > To: e1000-devel at lists.sourceforge.net; intel-wired-lan at lists.osuosl.org
> > Cc: Pawe? Ma?achowski <pawel.malachowski@atendesoftware.pl>; mirq-
> > linux at rere.qmqm.pl
> > Subject: [E1000-devel] i40e: Deadly GRE packet
> >
>
> > Dear Developers,
> >
> > I have a setup of a pair of SuperMicro-branded XL710s connected with
> > passive crossover cable, one (eth4) is using firmware 5.0, the other
> (eth7) is
> > using fw 4.33. When I send couple of packets with no payload in GRE over
> IP
> > over ETH from eth7 to eth4, the receiving card stops processing further
> > packets. It seems that 4 empty-GRE packets in succession are enough to
> kill
> > the card's receivers (all ports stop working), more if there are other
> packets
> > inbetween. Transmit direction is not affected. After reboot, the card
> comes
> > back, reloading the driver (or unbind/bind) is not enough to fix the
> problem.
> >
> > 14:31:24.299203 00:00:00:00:00:00 > ff:ff:ff:ff:ff:ff, ethertype IPv4
> (0x0800),
> > length 60: (tos 0x0, ttl 64, id 1, offset 0, flags [none], proto GRE
> (47), length
> > 24)
> >     127.0.0.1 > 127.0.0.1: GREv0, Flags [none], proto unknown (0x0000),
> length
> > 4
> >         gre-proto-0x0
> >         0x0000:  4500 0018 0001 0000 402f 7cb4 7f00 0001  E.......@/|
> .....
> >         0x0010:  7f00 0001 0000 0000 0000 0000 0000 0000
> ................
> >         0x0020:  0000 0000 0000 0000 0000 0000 0000       ..............
> >
> > scapy 2.2.0 generates this packet from: Ether()/IP()/GRE()
> >
> > Tested on stock Debian kernel, with in-kernel driver and one from
> DPDK-2.2.
> > Linux lab1 3.16.0-4-amd64 #1 SMP Debian 3.16.7-ckt25-2 (2016-04-08)
> x86_64
> > GNU/Linux
> >
> > Best Regards,
> > Micha? Miros?aw
>
> How exactly is DPDK involved?  Is it running in all instances where the
> issue is seen?  Have you tried the latest i40e driver from our Sourceforge
> site (http://e1000.sf.net)?
>
> Cheers,
> John
>
>
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160421/0d5c822c/attachment-0001.html>
