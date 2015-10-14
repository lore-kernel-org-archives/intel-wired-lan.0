From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Wed, 14 Oct 2015 20:12:18 +0000
Subject: [Intel-wired-lan] [next-queue 13/17] fm10k: Update adaptive ITR
 algorithm
In-Reply-To: <561EA08C.8090705@gmail.com>
References: <1444779554-20464-1-git-send-email-jacob.e.keller@intel.com>
 <1444779554-20464-13-git-send-email-jacob.e.keller@intel.com>
 <561EA08C.8090705@gmail.com>
Message-ID: <1444853538.26286.42.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2015-10-14 at 11:35 -0700, Alexander Duyck wrote:
> On 10/13/2015 04:39 PM, Jacob Keller wrote:
> +	 */+#define FM10K_ITR_SCALE_SMALL	6
> > +#define FM10K_ITR_SCALE_MEDIUM	5
> > +#define FM10K_ITR_SCALE_LARGE	4
> > +
> > +	if (avg_wire_size < 300)
> > +		avg_wire_size *= FM10K_ITR_SCALE_SMALL;
> > +	else if ((avg_wire_size >= 300) && (avg_wire_size < 1200))
> > +		avg_wire_size *= FM10K_ITR_SCALE_MEDIUM;
> >   	else
> > -		avg_wire_size /= 2;
> > +		avg_wire_size *= FM10K_ITR_SCALE_LARGE;
> > +
> 
> Where is it these scaling values originated from?  Just looking
> through 
> the values I am not sure having this broken out like it is provides
> much 
> value.
> 

I am not really sure what exactly you mean here?

> What I am getting at is that the input is a packet size, and the
> output 
> is a value somewhere between 2 and 47.  (I think that 47 is still a
> bit 
> high by the way and probably should be something more like 25 which I
> believe you established as the minimum Tx interrupt rate in a later
> patch.)
> 

The input is two fold for calculation, packet size, and number of
packets.

> What you may want to do is look at pulling in the upper limit to 
> something more reasonable like 1536 for avg_wire_size, and then
> simplify 
> this logic a bit.  Specifically what is it you are trying to
> accomplish 
> by tweaking the scale factor like you are?  I assume you are wanting
> to 
> approximate a curve.  If so you might wan to look at possibly
> including 
> an offset value so that you can smooth out the points where your 
> intersections occur.
> 

I honestly don't know. I mostly took the original work from 6-7 months
ago, and added your suggestions from that series, but maybe that isn't
valid now?

> For example what you may want to consider doing would be to instead
> use 
> a multiplication factor for small, an addition value for medium, and
> for 
> large you simply cap it at a certain value.
> 

So, how would this look? The capping makes sense, we should probably
cap it at around 30 or something? I'm not sure that 25 is the limit,
since for some workloads I think we did calculate that we could use
that few interrupts.. maybe the CPU savings aren't worth it though if
it messes up too many other flows?

I could also try to take a completely different algorithm say from i40e
instead? This one really has limited testing.

> 
> > +	/* Round up average wire size, then perform bit shift, to
> > ensure that
> > +	 * the calculation will never get below 1. Account for
> > changes in ITR
> > +	 * value due to PCIe link speed.
> > +	 */
> > +	avg_wire_size += (1 << (ring_container->itr_scale + 8)) -
> > 1;
> > +	avg_wire_size >>= ring_container->itr_scale + 8;
> > 
> 
> You might want to store off the value for itr_scale + 8 somewhere. 
>  It 
> is likely you might save a cycle or two, especially if the compiler 
> thinks it has to read itr_scale twice.

Fair enough that seems reasonable change.
