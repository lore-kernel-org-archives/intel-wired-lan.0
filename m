From: Flavio Suligoi <f.suligoi@asem.it>
Date: Fri, 1 Mar 2019 08:15:39 +0000
Subject: [Intel-wired-lan] [PATCH v3] net: e1000e: add MAC address
 kernel cmd line parameter
In-Reply-To: <20190228.114707.11382969767373748.davem@davemloft.net>
References: <20190228163729.GB17912@lunn.ch>
 <6a7a37813e71420b929c769dd1e77664@asem.it>
 <20190228192958.GA24085@lunn.ch>
 <20190228.114707.11382969767373748.davem@davemloft.net>
Message-ID: <a9381ec45e9b4e5a8388c8414aadda98@asem.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> >> > Hi Flavio
> >> >
> >> > u-boot should be able to write the MAC address in the correct part of
> >> > device tree. Boards have been doing this a long time.
> >> >
> >> > Module parameters are considered bad. You should only do it if you
> >> > have no other option. Here you do have another options, so it is
> going
> >> > to be a hard sell getting David to access your patch.
> >> >
> >> > You will have more success by adding a call to
> >> > eth_platform_get_mac_address() to the e1000e driver.
> >>
> >> You have right, and thanks for your suggestions,
> >> but with a kernel parameter I can use the same method
> >> for any board where the NVM is missed, independently of any
> architecture
> >> (with or without the device tree presence - ARM or x86 or others).
> >
> > Hi Flavio
> >
> > Well, lets wait for David to say what he thinks about the module
> > parameter.
> 
> I already rejected this, no way... Drivers that already have the
> unacceptable module parameter are no an argument for spreading this
> mistake further.

Hi David and Andrew,

ok, thank you for your suggestions and your time!

Flavio
