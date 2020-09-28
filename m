From: Sven Auhagen <sven.auhagen@voleatech.de>
Date: Mon, 28 Sep 2020 18:20:10 +0200
Subject: [Intel-wired-lan] bpf_redirect and xdpgeneric
In-Reply-To: <20200928172449.50a3e755@carbon>
References: <CANDGNvbX+BwA_ZUmw2rxH5FGLFsCVH33Tw3RCk3e3Qo69J+4qw@mail.gmail.com>
 <87lfh7fkqs.fsf@toke.dk>
 <CANDGNvbY=8XEJP=S3e+5V2RU6u0zjRE3YDo62bhV-Qaje=++2A@mail.gmail.com>
 <5f7f5056-d1de-737b-2d76-cd37e4a4db8e@gmail.com>
 <20200928172449.50a3e755@carbon>
Message-ID: <20200928162010.wpv6ukqscuxaxtnj@svensmacbookair.sven.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Sep 28, 2020 at 05:24:49PM +0200, Jesper Dangaard Brouer wrote:
> On Fri, 18 Sep 2020 14:27:45 -0600
> David Ahern <dsahern@gmail.com> wrote:
> 
> > On 9/18/20 12:42 PM, Thomas Ptacek wrote:
> > > The setup is pretty simple. There's an eno1 (igb driver), to which our
> > > default route points. On the same box are several VMs. There's a tap
> > > interface (for each VM, call it tapX). Traffic for a VM flows in from
> > > the Internet on eno1 and is directed to tapX; the response traffic
> > > flows in the other direction.
> > > 
> > > I'm deliberately simplifying here:
> > > 
> > > eno1 runs an XDP program that does some lightweight IP rewriting from
> > > anycast addresses to internal VM addresses on ingress. eno1's XDP
> > > program currently XDP_PASS's rewritten packets to the IP stack, where
> > > they're routed to the VM's tap. This works fine.
> > > 
> > > tapX runs an XDP program that does the same rewriting in reverse.
> > > Right now, it also XDP_PASS's packets to the stack, which also works
> > > --- the stack routes response traffic out eno1.
> > > 
> > > I'm playing with XDP_REDIRECT'ing instead of XDP_PASS'ing.
> > > 
> > > I have the ifindexes and MAC addresses (and those of IP neighbors) in
> > > a map --- a normal HASH map, not a DEVMAP. Using that map, I can
> > > successfully redirect traffic from tapX to arbitrary other tap
> > > interfaces. What I can't do is redirect packets from tapX to eno1,
> > > which is what the system actually needs to do.
> > >   
> > 
> > XDP_REDIRECT sends the packet to a devices ndo_xdp_xmit function. tap
> > implements it hence eno1 -> tap works; igb does not meaning tap -> eno1
> > fails.
> 
> There is clearly a real-life use-case for adding native-XDP support for
> igb driver.  Sven (cc) have implemented this (v6[1]), but something is
> causing this patch to not move forward, what is stalling Intel maintainers?

The holdup is from the Intel guys.
There is a v7 with the changes for Kernel 5.9 but it was only posted on
the Intel list:

https://patchwork.ozlabs.org/project/intel-wired-lan/patch/20200902203222.185141-1-anthony.l.nguyen at intel.com/

They tested it last week so it should hopefully be merged in the next window.

> 
> To Thomas, you could try out the patch[2] and report back if it works
> for you?  (I think it will help moving patch forward...)
> 

I would be interested if it works for you as well.

Best
Sven

> [1] https://eur03.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fnetdev%2F20200902054509.23jbv5fyj3otziq2%40svensmacbookair.sven.lan%2F&amp;data=02%7C01%7Csven.auhagen%40voleatech.de%7Ccbd762e5a024488f491b08d863c2b6cb%7Cb82a99f679814a7295344d35298f847b%7C0%7C0%7C637369035229290801&amp;sdata=Pv%2BTEQeY4lcPnIprg0n6K0nHOMMlMo2qlrcmxqWNuLY%3D&amp;reserved=0
> [2] https://eur03.safelinks.protection.outlook.com/?url=http%3A%2F%2Fpatchwork.ozlabs.org%2Fproject%2Fnetdev%2Fpatch%2F20200902054509.23jbv5fyj3otziq2%40svensmacbookair.sven.lan%2F&amp;data=02%7C01%7Csven.auhagen%40voleatech.de%7Ccbd762e5a024488f491b08d863c2b6cb%7Cb82a99f679814a7295344d35298f847b%7C0%7C0%7C637369035229290801&amp;sdata=CmlEramL%2FHGz745N6HP%2FWRzPwZs0ERh3kQ8%2Bj%2FIUztw%3D&amp;reserved=0
> -- 
> Best regards,
>   Jesper Dangaard Brouer
>   MSc.CS, Principal Kernel Engineer at Red Hat
>   LinkedIn: https://eur03.safelinks.protection.outlook.com/?url=http%3A%2F%2Fwww.linkedin.com%2Fin%2Fbrouer&amp;data=02%7C01%7Csven.auhagen%40voleatech.de%7Ccbd762e5a024488f491b08d863c2b6cb%7Cb82a99f679814a7295344d35298f847b%7C0%7C0%7C637369035229290801&amp;sdata=LJUt38GAkdXS2rW7WG%2BUS0d6eVxZfl3VJqyHvNsqLmY%3D&amp;reserved=0
> 
