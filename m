From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Thu, 09 Apr 2015 14:02:49 -0700
Subject: [Intel-wired-lan] [PATCH] e1000e: fix call to do_div() to use
	u64 arg
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D1CB177C8@AcuExch.aculab.com>
References: <20150408205837.4329.94829.stgit@jtkirshe-mobl.jf.intel.com>
 <063D6719AE5E284EB5DD2968C1650D6D1CB177C8@AcuExch.aculab.com>
Message-ID: <1428613369.2729.34.camel@jtkirshe-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 2015-04-09 at 09:04 +0000, David Laight wrote:
> From: Jeff Kirsher
> > Sent: 08 April 2015 21:59
> > We were using s64 for lat_ns (latency nano-second value) since in
> > our calculations a negative value could be a resultant.  For
> negative
> > values, we then assign lat_ns to be zero, so the value passed to
> > do_div() was never negative, but do_div() expects the argument type
> > to be u64, so do a cast to resolve a compile warning seen on
> > PowerPC.
> ...
> > -                     do_div(lat_ns, speed);
> > +                     do_div((u64)lat_ns, speed);
> 
> Personally I think that adding casts to avoid warnings
> from integer promotions and function arguments isn't a good idea.
> The problem is that C casts are too powerful and can hide other bugs.
> In the past I've been bitten by a cast inside a (badly written)
> #define
> function.
> 
> The above is a typical case where the compiler should really be doing
> value domain checks before reporting anything at all - if at all.

I agree with you that I do not like casts because it can potentially
hide bugs.  On that note, I have a follow on patch that should resolve
the PowerPC compile warning without having to do a cast.  Just re-works
the existing code, expect a v2 shortly.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150409/d4cbbece/attachment.asc>
