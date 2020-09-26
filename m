From: David Laight <David.Laight@ACULAB.COM>
Date: Sat, 26 Sep 2020 10:08:47 +0000
Subject: [Intel-wired-lan] [PATCH v2] e1000e: Increase iteration on
 polling MDIC ready bit
In-Reply-To: <20200925132903.GB3850848@lunn.ch>
References: <20200923074751.10527-1-kai.heng.feng@canonical.com>
 <20200924150958.18016-1-kai.heng.feng@canonical.com>
 <20200924155355.GC3821492@lunn.ch>
 <8A08B3A7-8368-48EC-A2DD-B5D5F3EA94C5@canonical.com>
 <2f48175dce974ea689bfd26b9fc2245a@AcuMS.aculab.com>
 <20200925132903.GB3850848@lunn.ch>
Message-ID: <1b4fadba2e204f6abd4ef6e02d84beed@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Andrew Lunn
> Sent: 25 September 2020 14:29
> On Fri, Sep 25, 2020 at 08:50:30AM +0000, David Laight wrote:
> > From: Kai-Heng Feng
> > > Sent: 24 September 2020 17:04
> > ...
> > > > I also don't fully understand the fix. You are now looping up to 6400
> > > > times, each with a delay of 50uS. So that is around 12800 times more
> > > > than it actually needs to transfer the 64 bits! I've no idea how this
> > > > hardware works, but my guess would be, something is wrong with the
> > > > clock setup?
> > >
> > > It's probably caused by Intel ME. This is not something new, you can find many polling codes in
> e1000e
> > > driver are for ME, especially after S3 resume.
> > >
> > > Unless Intel is willing to open up ME, being patient and wait for a longer while is the best
> approach
> > > we got.
> >
> > There is some really broken code in the e1000e driver that affect my
> > Ivy bridge platform were it is trying to avoid hardware bugs in
> > the ME interface.
> >
> > It seems that before EVERY write to a MAC register it must check
> > that the ME isn't using the interface - and spin until it isn't.
> > This causes massive delays in the TX path because it includes
> > the write that tells the MAC engine about a new packet.
> 
> Hi David
> 
> Thanks for the information. This however does not really explain the
> issue.
> 
> The code busy loops waiting for the MDIO transaction to complete. If
> read/writes to the MAC are getting blocked, that just means less
> iterations of the loop are needed, not more, since the time to
> complete the transaction should be fixed.
> 
> If ME really is to blame, it means ME is completely hijacking the
> hardware? Stopping the clocks? Maybe doing its own MDIO transactions?
> How can you write a PHY driver if something else is also programming
> the PHY.
> 
> We don't understand what is going on here. We are just papering over
> the cracks. The commit message should say this, that the change fixes
> the symptoms but probably not the cause.

You may not have the same broken hardware as I have...

From what I could infer from the code and guess from the behaviour
I got the impression that if the ME was accessing any of the MAC
registers it was likely that writes from the kernel just got discarded.

I got the impression that a bug in the hardware was being worked
around by the ME setting a status bit before and access, waiting
a bit for the kernel to finish anything it was doing, then
doing its access and clearing the bit.

The kernel keeps having to wait for the bit to be clear.
These delays were long; sub ms - but far longer than
the rest of the code path for sending a packet.
But the code didn't check/disable pre-emption or interrupts
so the check was actually broken.
(If I removed it completely my system wouldn't boot!)

Thing is I don't want the ME.
I don't need the ME on that system.
The ME might be a security hole.
The ME breaks my system.
But I can't disable it at all.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

