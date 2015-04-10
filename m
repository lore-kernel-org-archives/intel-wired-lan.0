From: Thomas Graf <tgraf@suug.ch>
Date: Fri, 10 Apr 2015 09:48:16 +0100
Subject: [Intel-wired-lan] [PATCH 3/3 net-next] net_device: Add minimal
 padding to allow for net_device pointer alignment
In-Reply-To: <1428626095.25985.282.camel@edumazet-glaptop2.roam.corp.google.com>
References: <cover.1428622095.git.tgraf@suug.ch>
 <1676328eb3e9d02a4432783494d0c5a13f0d4656.1428622095.git.tgraf@suug.ch>
 <1428626095.25985.282.camel@edumazet-glaptop2.roam.corp.google.com>
Message-ID: <20150410084816.GB23070@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 04/09/15 at 05:34pm, Eric Dumazet wrote:
> On Fri, 2015-04-10 at 01:43 +0200, Thomas Graf wrote:
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index b2775f0..2b43aba 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -6794,8 +6794,7 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
> >  		alloc_size = ALIGN(alloc_size, NETDEV_ALIGN);
> >  		alloc_size += sizeof_priv;
> >  	}
> > -	/* ensure 32-byte alignment of whole construct */
> > -	alloc_size += NETDEV_ALIGN - 1;
> > +	alloc_size += PTR_ALIGN_PAD(struct net_device, NETDEV_ALIGN);
> >  
> >  	p = kzalloc(alloc_size, GFP_KERNEL | __GFP_NOWARN | __GFP_REPEAT);
> >  	if (!p)
> 
> 
> I believe code intent was to get an alignment even if kmalloc() returns
> say 0xxxxx0008.
> 
> AFAIK, SLAB in debug mode was able to do this.

I assumed kmalloc would guarantee alignment of the return pointer as
indicated by __alignof__ but I now realize that this can't possibly be the
case. kmalloc only knows about the size. We'll have to drop patch 3.
Fortunately it's still below 2K.
