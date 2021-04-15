From: Jesper Dangaard Brouer <jbrouer@redhat.com>
Date: Thu, 15 Apr 2021 14:51:28 +0200
Subject: [Intel-wired-lan] [PATCH net] igb: Fix XDP with PTP enabled
In-Reply-To: <874kg7hhej.fsf@kurt>
References: <20210415092145.27322-1-kurt@linutronix.de>
 <20210415140438.60221f21@carbon> <874kg7hhej.fsf@kurt>
Message-ID: <20210415145011.6734d3fb@carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 15 Apr 2021 14:16:36 +0200
Kurt Kanzenbach <kurt@linutronix.de> wrote:

> On Thu Apr 15 2021, Jesper Dangaard Brouer wrote:
> > On Thu, 15 Apr 2021 11:21:45 +0200
> > Kurt Kanzenbach <kurt@linutronix.de> wrote:
> >  
> >> When using native XDP with the igb driver, the XDP frame data doesn't point to
> >> the beginning of the packet. It's off by 16 bytes. Everything works as expected
> >> with XDP skb mode.
> >> 
> >> Actually these 16 bytes are used to store the packet timestamps. Therefore, pull
> >> the timestamp before executing any XDP operations and adjust all other code
> >> accordingly. The igc driver does it like that as well.
> >> 
> >> Tested with Intel i210 card and AF_XDP sockets.  
> >
> > Doesn't the i210 card use the igc driver?
> > This change is for igb driver.  
> 
> Nope. igb is for i210 and igc is for the newer Intel i225 NICs.
> 
> |01:00.0 Ethernet controller: Intel Corporation I210 Gigabit Network Connection (rev 03)
> |[...]
> |        Kernel driver in use: igb
> |        Kernel modules: igb

Thanks a lot for correcting me!

I have a project involving i225+igc (using TSN).  And someone suggested
that I also looked at i210 for TSN.  I've ordered hardware that have
i210 on motherboard (and I will insert my i225 card) so I have a system
with both chips for experimenting with TSN.  I guess, I would have
discovered this eventually when I got the hardware.  Thanks for saving
me from this mistake. Thanks!

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer

