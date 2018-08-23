From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Thu, 23 Aug 2018 09:41:38 -0700
Subject: [Intel-wired-lan] [PATCH v6 01/11] igc: Add skeletal frame for
 Intel(R) 2.5G Ethernet Controller support.
In-Reply-To: <20180823162104.GU3348@calimero.vinschen.de>
References: <20180823070552.12190-1-sasha.neftin@intel.com>
 <20180823140338.GR3348@calimero.vinschen.de>
 <017dfb5dc28cc4227a4dd655008a308f919023dc.camel@intel.com>
 <20180823152136.GS3348@calimero.vinschen.de>
 <0d296c72b24c76f0e93ca5c72da83e1813b80e1f.camel@intel.com>
 <20180823162104.GU3348@calimero.vinschen.de>
Message-ID: <635d4b2c13e7b1fc94b1a9e439087cbaa8fd563f.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 2018-08-23 at 18:21 +0200, Corinna Vinschen wrote:
> On Aug 23 08:57, Jeff Kirsher wrote:
> > On Thu, 2018-08-23 at 17:21 +0200, Corinna Vinschen wrote:
> > > On Aug 23 08:12, Jeff Kirsher wrote:
> > > > On Thu, 2018-08-23 at 16:03 +0200, Corinna Vinschen wrote:
> > > > > On Aug 23 10:05, Sasha Neftin wrote:
> > > > > > This patch adds the beginning framework onto which I am
> going
> > > to
> > > > > add
> > > > > > the igc driver which supports the Intel(R) I225-LM/I225-V
> 2.5G
> > > > > > Ethernet Controller.
> > > > > 
> > > > > I'm curious.  The code looks very much like the igb code. 
> > > Wouldn't
> > > > > it
> > > > > be simpler and less error prone to add these new NICs to igb,
> > > rather
> > > > > than creating a new driver by (mostly) copying the code from
> igb?
> > > > > 
> > > > > What's the idea behind this?
> > > > 
> > > > This new driver is for a new upcoming client part, not server
> > > (which is
> > > > the igb driver).  Yes, the way that this new client part does
> > > resemble
> > > > how the igb driver operates, but this new client part will not
> have
> > > > many of the advance features (like SRIOV) that igb uses.  We
> also
> > > want
> > > > to keep the igb driver strictly for the 1GbE server devices.
> > > 
> > > Ok, thanks, but I'm still a bit puzzled.
> > > 
> > > What about E1000_DEV_ID_I354_BACKPLANE_2_5GBPS?  The later
> supposedly
> > > already provides 2.5G within igb.  Is that the server part
> compared
> > > to igc?  Otherwise, what's the equivalent server part providing
> 2.5G?
> > 
> > Yes, one of the last server devices we developed back in 2013 was
> I354
> > and that device did support 2.5 GbE.  Again, this is a server part,
> > which supports more advanced features that client parts do not.
> > 
> > There is not a 1:1 on server parts and client parts, sometimes
> there
> > can be a server part that is similar to a client part or vice
> versa.
> > 
> > In this case, this new client part will be the next generation of
> > client parts.  So these will be essentially the new "e1000e" (our
> other
> > client driver), but since this next generation of client parts will
> > have MAC/PHY communications that are more similar to how some of
> our
> > server parts did, that is why portions of the driver will resemble
> igb.
> > But feature wise the igc driver will be more like e1000e than igb.
> > 
> > Hope that helps.
> 
> Yes, Jeff, this really helps.
> 
> But this just reinforces my doubts that changing the E1000 prefix
> to IGC is a good thing.  The comparison of binary values only gets
> more complicated.  In the end we have, for instance, this:
> 
>   e1000:  #define E1000_ERR_NVM        1
>   e1000e: #define E1000_ERR_NVM        1
>   igb:    #define E1000_ERR_NVM        1
> 
> but
> 
>   igc:    #define IGC_ERR_NVM          1
> 
> This doesn't make sense.

When naming functions/macros and defines, I can see pros and cons to
both approaches.  That particular code you referring to is "common
code" shared amongst the various drivers e1000, e1000e and igb.  The
igc driver did start with this "common code" as a starting point, but
this common code will be morphing to handle the future client parts. 
So we were looking to use the igc driver as the parent of this new
common code, much like how e1000 was the "original" or parent driver to
e1000e and igb.

It seemed right to break ties with the legacy naming of
functions/macros/defines, especially since this new generation of parts
and devices will have very little in common with the old e1000 devices.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20180823/6887dbd2/attachment.asc>
