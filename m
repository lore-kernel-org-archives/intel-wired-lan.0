From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Mon, 14 Oct 2019 17:20:31 +0000
Subject: [Intel-wired-lan] [net-next v3 3/7] mv88e6xxx: reject
 unsupported external timestamp flags
In-Reply-To: <20191012232719.GA7148@localhost>
References: <20190926181109.4871-1-jacob.e.keller@intel.com>
 <20190926181109.4871-4-jacob.e.keller@intel.com>
 <20191012182409.GD3165@localhost>
 <02874ECE860811409154E81DA85FBB5896926B0B@ORSMSX121.amr.corp.intel.com>
 <20191012232719.GA7148@localhost>
Message-ID: <02874ECE860811409154E81DA85FBB589692862E@ORSMSX121.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Richard Cochran <richardcochran@gmail.com>
> Sent: Saturday, October 12, 2019 4:27 PM
> To: Keller, Jacob E <jacob.e.keller@intel.com>
> Cc: netdev at vger.kernel.org; Intel Wired LAN <intel-wired-lan@lists.osuosl.org>;
> Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; Brandon Streiff
> <brandon.streiff@ni.com>
> Subject: Re: [net-next v3 3/7] mv88e6xxx: reject unsupported external
> timestamp flags
> 
> On Sat, Oct 12, 2019 at 07:36:31PM +0000, Keller, Jacob E wrote:
> > Right, so in practice, unless it supports both edges, it should reject setting both
> RISING and FALLING together.
> 
> Enforcing that now *could* break existing user space, but I wonder
> whether any programs would actually be affected.
> 
> Maybe we can add a STRICT flag than requests strict checking.  If user
> space uses the "2" ioctl, then we would add this flag before invoking
> the driver callback.
> 
> Thanks,
> Richard

That could work. I don't know how much it's worth fixing it, but that would be the right way to fix it, I think.

I think the strict flag should do the following:

a) enforce that you must set at least one of the two edge flags (ensuring that a request to timestamp without one of the edges is rejected)
b) drivers *must* honor the edge flags or exit with a rejection if they can't support it. (unlike without 'strict', which would be like today and driver defined).
c) possibly: reject both flags at once since it doesn't really make sense to create a timestamp for each edge. At least, I think that makes it harder to actually use the timestamps since you need to be more careful to separate the two timestamps.

I'm not 100% sure on (c) but (b) can only be implemented in drivers, since the stack wouldn't know which modes the driver supports.

Thanks,
Jake
