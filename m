From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Tue, 21 Apr 2015 03:15:03 +0000
Subject: [Intel-wired-lan] [net-next v2] e1000e: fix call to do_div() to
 use u64 arg
In-Reply-To: <552700ED.3030009@redhat.com>
References: <20150409214405.27465.51380.stgit@gmw-smvitp108.amr.corp.intel.com>
 <552700ED.3030009@redhat.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B78DA68CB@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Thursday, April 09, 2015 3:45 PM
> To: Kirsher, Jeffrey T; intel-wired-lan at lists.osuosl.org
> Cc: david.laight at aculab.com; Jin, Yanjiang (Wind River)
> Subject: Re: [Intel-wired-lan] [net-next v2] e1000e: fix call to do_div()
> to use u64 arg
> 
> 
> 
> On 04/09/2015 02:45 PM, Jeff Kirsher wrote:
> > We were using s64 for lat_ns (latency nano-second value) since in
> > our calculations a negative value could be a resultant.  For negative
> > values, we then assign lat_ns to be zero, so the value passed to
> > do_div() was never negative, but do_div() expects the argument type
> > to be u64, so do a cast to resolve a compile warning seen on
> > PowerPC.
> >
> > CC: Yanjiang Jin <yanjiang.jin@windriver.com>
> > CC: Yanir Lubetkin <yanirx.lubetkin@intel.com>
> > Reported-by: Yanjiang Jin <yanjiang.jin@windriver.com>
> > Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> > ---
> > v2: fixed the patch to not use a cast to resolve the PowerPC compile
> >      warning
> > ---
> >   drivers/net/ethernet/intel/e1000e/ich8lan.c |   13 +++++++------
> >   1 file changed, 7 insertions(+), 6 deletions(-)

<snip>
> 
> Honestly the whole signed/unsigned thing is kind of a waste anyway.  You
> could probably rewrite it to something like this and drop lat_ns entirely.
> 
> rxa *= 512;
> value = (rxa > hw->adapter->max_frame_size) ?
> 	(rxa - hw->adapter->max_frame_size) * (16000 / speed) : 0;
> 
> That should give you the same result without any need for the do_div or
> the signed values.
> 
> - Alex

Anyone want to take a stab at striking out the signed / unsigned thing per Alex's suggestion?

Meanwhile I've run tons of tests with this in the queue and don't want to old things up, so...

Tested-by: Aaron Brown <aaron.f.brown@intel.com>

> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at lists.osuosl.org
> http://lists.osuosl.org/mailman/listinfo/intel-wired-lan
