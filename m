From: =?unknown-8bit?q?Micha=C5=82_Miros=C5=82aw?= <michal.miroslaw@atendesoftware.pl>
Date: Thu, 21 Apr 2016 17:06:10 +0200
Subject: [Intel-wired-lan] [E1000-devel] i40e: Deadly GRE packet
In-Reply-To: <9BBC4E0CF881AA4299206E2E1412B626501B911A@ORSMSX102.amr.corp.intel.com>
References: <CAFzSZ++22adGYpR09vpx2rTh=bu1jgBz7wpB762Ampu0eEcVxg@mail.gmail.com>
 <9BBC4E0CF881AA4299206E2E1412B626501B911A@ORSMSX102.amr.corp.intel.com>
Message-ID: <CAFzSZ+J0HatJi6QGX56Q051wCAC-gPmDizrBwfQXDFXHm2vLVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Carolyn,

The ethtool info was attached to my original mail. Here it is inline in
case the attachment was stripped:

# ethtool -i eth4
driver: i40e
version: 0.4.10-k
firmware-version: f5.0 a1.5 n05.02 e80002283
bus-info: 0000:01:00.2
supports-statistics: yes
supports-test: yes
supports-eeprom-access: yes
supports-register-dump: yes
supports-priv-flags: no

# ethtool -i eth7
driver: i40e
version: 0.4.10-k
firmware-version: f4.33 a1.2 n04.42 e8000191c
bus-info: 0000:02:00.1
supports-statistics: yes
supports-test: yes
supports-eeprom-access: yes
supports-register-dump: yes
supports-priv-flags: no

Best Regards,
Micha? Miros?aw

2016-04-21 16:57 GMT+02:00 Wyborny, Carolyn <carolyn.wyborny@intel.com>:

> > -----Original Message-----
> > From: Micha? Miros?aw [mailto:michal.miroslaw at atendesoftware.pl]
> > Sent: Thursday, April 21, 2016 5:45 AM
> > To: e1000-devel at lists.sourceforge.net; intel-wired-lan at lists.osuosl.org
> > Cc: Pawe? Ma?achowski <pawel.malachowski@atendesoftware.pl>; mirq-
> > linux at rere.qmqm.pl
> > Subject: [E1000-devel] i40e: Deadly GRE packet
> >
> > Dear Developers,
> >
> > I have a setup of a pair of SuperMicro-branded XL710s connected with
> > passive crossover cable, one (eth4) is using firmware 5.0, the other
> (eth7)
> > is using fw 4.33. When I send couple of packets with no payload in GRE
> over
> > IP over ETH from eth7 to eth4, the receiving card stops processing
> further
> > packets. It seems that 4 empty-GRE packets in succession are enough to
> kill
> > the card's receivers (all ports stop working), more if there are other
> > packets inbetween. Transmit direction is not affected. After reboot, the
> > card comes back, reloading the driver (or unbind/bind) is not enough to
> fix
> > the problem.
> >
> Can you also provide the version of the driver you are using?  Ethtool -i
>
> Thanks,
>
> Carolyn
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160421/e5b7434e/attachment-0001.html>
