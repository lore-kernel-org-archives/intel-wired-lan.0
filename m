From: David Laight <David.Laight@ACULAB.COM>
Date: Thu, 26 Mar 2020 11:08:52 +0000
Subject: [Intel-wired-lan] [PATCH net 1/1] e1000e: Stop tx/rx setup
 spinning for upwards of 300us.
In-Reply-To: <c84d4055e13f30edf7b79086c9ed8d7d1fe6523b.camel@intel.com>
References: <6ef1e257642743a786c8ddd39645bba3@AcuMS.aculab.com>
 <c84d4055e13f30edf7b79086c9ed8d7d1fe6523b.camel@intel.com>
Message-ID: <ed99e7c34aab4b0fafa20fc449e77510@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jeff Kirsher
> Sent: 04 March 2020 18:04
> On Tue, 2020-03-03 at 17:06 +0000, David Laight wrote:
> > Instead of spinning waiting for the ME to be idle defer the ring
> > tail updates until one of the following:
> > - The next update for that ring.
> > - The receive frame processing.
> > - The next timer tick.
> >
> > Reduce the delay between checks for the ME being idle from 50us
> > to uus.
> >
> > Part fix for bdc125f7.
> >
> > Signed-off-by: David Laight <david.laight@aculab.com>
> 
> Added intel-wired-lan at lists.osuosl.org mailing list, so the right
> people can review your patch.

I don't see any sign of anyone looking at this.
Is the code so bad everyone has buried their head in the sand?

Am I right in thinking that the actual hardware problem is
that PCIe writes are 'posted' in the hardware and then lost
if the ME does a write while the PCIe write is still pending?

In which case a much simpler patch that does a readback after
every write and retries if the value is different will solve
the problem without ever needing a delay().

The only 'problem' register would be the interrupt mask
which the hardware appears to change itself.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)
