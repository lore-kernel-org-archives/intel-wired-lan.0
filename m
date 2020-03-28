From: David Laight <David.Laight@ACULAB.COM>
Date: Sat, 28 Mar 2020 10:55:59 +0000
Subject: [Intel-wired-lan] [PATCH] e1000e: bump up timeout to wait when
 ME un-configure ULP mode
In-Reply-To: <60A8493D-811B-4AD5-A8D3-82054B562A8C@canonical.com>
References: <20200323191639.48826-1-aaron.ma@canonical.com>
 <EC4F7F0B-90F8-4325-B170-84C65D8BBBB8@canonical.com>
 <2c765c59-556e-266b-4d0d-a4602db94476@intel.com>
 <899895bc-fb88-a97d-a629-b514ceda296d@canonical.com>
 <750ad0ad-816a-5896-de2f-7e034d2a2508@intel.com>
 <f9dc1980-fa8b-7df9-6460-b0944c7ebc43@molgen.mpg.de>
 <60A8493D-811B-4AD5-A8D3-82054B562A8C@canonical.com>
Message-ID: <8fa6ec1ce4ad4b89ae68107a55ce2381@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Kai-Heng Feng
> Sent: 26 March 2020 11:30
...
> > Regarding Intel Management Engine, only Intel knows what it does and what the error is, as the ME
> firmware is proprietary and closed.
> >
> > Lastly, there is no way to fully disable the Intel Management Engine.
> > The HAP stuff claims to stop
> > the Intel ME execution, but nobody knows, if it?s successful.

This isn't the only 'bug' caused by the ME logic.

Some systems occasionally spin for many multiples of 50us on any
write to any MAC register - eg to indicate there is a packet to tx.

I really don't understand WTF this ME is playing at on an unmanaged
desktop system - if it receives or sends a packet it is most likely
to be some kind of security attack.
I'm not even sure it needs access during the boot sequence.
Maybe there are some features to get the console output over
ethernet - but they have to be enabled in the BIOS.

We have some small server boards (for 1U systems) that have a
separate ethernet interface for (I think) the ME code.
Better - except you plug a cable in and wonder why is doesn't work.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)
