From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Tue, 21 Apr 2015 01:04:08 -0700
Subject: [Intel-wired-lan] [net-next v2] e1000e: fix call to do_div() to
 use u64 arg
In-Reply-To: <309B89C4C689E141A5FF6A0C5FB2118B78DA68CB@ORSMSX101.amr.corp.intel.com>
References: <20150409214405.27465.51380.stgit@gmw-smvitp108.amr.corp.intel.com>
 <552700ED.3030009@redhat.com>
 <309B89C4C689E141A5FF6A0C5FB2118B78DA68CB@ORSMSX101.amr.corp.intel.com>
Message-ID: <1429603448.2638.172.camel@jtkirshe-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 2015-04-20 at 20:15 -0700, Brown, Aaron F wrote:
> > 
> > Honestly the whole signed/unsigned thing is kind of a waste anyway.
> You
> > could probably rewrite it to something like this and drop lat_ns
> entirely.
> > 
> > rxa *= 512;
> > value = (rxa > hw->adapter->max_frame_size) ?
> >       (rxa - hw->adapter->max_frame_size) * (16000 / speed) : 0;
> > 
> > That should give you the same result without any need for the do_div
> or
> > the signed values.
> > 
> > - Alex
> 
> Anyone want to take a stab at striking out the signed / unsigned thing
> per Alex's suggestion?
> 
> Meanwhile I've run tons of tests with this in the queue and don't want
> to old things up, so...
> 
> Tested-by: Aaron Brown <aaron.f.brown@intel.com>

Yeah, I will be working on a follow on patch to implement Alex's
suggestions.  For now, I wanted to go forward with this change to
resolve the compile warning.  I should have a patch later this week to
implement Alex's suggestions, unless Yanir gets to it before me. :-)
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150421/4d60ed61/attachment.asc>
