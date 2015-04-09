From: David Laight <David.Laight@ACULAB.COM>
Date: Thu, 9 Apr 2015 09:04:57 +0000
Subject: [Intel-wired-lan] [PATCH] e1000e: fix call to do_div() to use
	u64 arg
In-Reply-To: <20150408205837.4329.94829.stgit@jtkirshe-mobl.jf.intel.com>
References: <20150408205837.4329.94829.stgit@jtkirshe-mobl.jf.intel.com>
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D1CB177C8@AcuExch.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jeff Kirsher
> Sent: 08 April 2015 21:59
> We were using s64 for lat_ns (latency nano-second value) since in
> our calculations a negative value could be a resultant.  For negative
> values, we then assign lat_ns to be zero, so the value passed to
> do_div() was never negative, but do_div() expects the argument type
> to be u64, so do a cast to resolve a compile warning seen on
> PowerPC.
...
> -			do_div(lat_ns, speed);
> +			do_div((u64)lat_ns, speed);

Personally I think that adding casts to avoid warnings
from integer promotions and function arguments isn't a good idea.
The problem is that C casts are too powerful and can hide other bugs.
In the past I've been bitten by a cast inside a (badly written) #define
function.

The above is a typical case where the compiler should really be doing
value domain checks before reporting anything at all - if at all.

	David


