From: David Laight <David.Laight@ACULAB.COM>
Date: Fri, 25 Sep 2020 08:50:30 +0000
Subject: [Intel-wired-lan] [PATCH v2] e1000e: Increase iteration on
 polling MDIC ready bit
In-Reply-To: <8A08B3A7-8368-48EC-A2DD-B5D5F3EA94C5@canonical.com>
References: <20200923074751.10527-1-kai.heng.feng@canonical.com>
 <20200924150958.18016-1-kai.heng.feng@canonical.com>
 <20200924155355.GC3821492@lunn.ch>
 <8A08B3A7-8368-48EC-A2DD-B5D5F3EA94C5@canonical.com>
Message-ID: <2f48175dce974ea689bfd26b9fc2245a@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Kai-Heng Feng
> Sent: 24 September 2020 17:04
...
> > I also don't fully understand the fix. You are now looping up to 6400
> > times, each with a delay of 50uS. So that is around 12800 times more
> > than it actually needs to transfer the 64 bits! I've no idea how this
> > hardware works, but my guess would be, something is wrong with the
> > clock setup?
> 
> It's probably caused by Intel ME. This is not something new, you can find many polling codes in e1000e
> driver are for ME, especially after S3 resume.
> 
> Unless Intel is willing to open up ME, being patient and wait for a longer while is the best approach
> we got.

There is some really broken code in the e1000e driver that affect my
Ivy bridge platform were it is trying to avoid hardware bugs in
the ME interface.

It seems that before EVERY write to a MAC register it must check
that the ME isn't using the interface - and spin until it isn't.
This causes massive delays in the TX path because it includes
the write that tells the MAC engine about a new packet.

The code is completely broken though.
Interrupts and processes switches can happen between the
test for the ME being idle and the actual write.

AFAICT the only reliable way to get ethernet access on such
systems is to use a different ethernet interface.

Also, from what I remember, the broken workaround is missing
from some of the setup code paths.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

