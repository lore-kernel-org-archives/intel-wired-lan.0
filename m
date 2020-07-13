From: Yahui Chen <goodluckwillcomesoon@gmail.com>
Date: Mon, 13 Jul 2020 10:55:36 +0800
Subject: [Intel-wired-lan] [PATCH] xsk: ixgbe: solve the soft interrupt
 100% CPU usage when xdp rx traffic congestion
In-Reply-To: <20200711111421.0db76fa9@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <1594462239-19596-1-git-send-email-goodluckwillcomesoon@gmail.com>
 <20200711111421.0db76fa9@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Message-ID: <CAPydje9rv2cR2YZvOcYT_w4E7cvERi0cEbs7hiwLKk4Bqhk+RA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

xdp skb-mode does not have this problem because `ixgbe_alloc_rx_buffers`
always returns success and can always get the DMA address for packets. I
think drv-mode should do the same.

If the drv-mode app does not use the wakeup flag, the xdp queue's soft
interrupt handles fewer packets but may occupy 100% of the CPU,
according to the analysis of the previous email.

If the user APP uses the wakeup flag, it maybe seriously affect other
queues just because the APP is not processing the packet fast enough.
In extreme cases, the APP can no longer receive packets, and port-level
flow control will cause no packets to be received in all queues of the
network card.

As a result, the user needs to explicitly turn off flow control of network
card, which is unfriendly to users.

Jakub Kicinski <kuba@kernel.org> ?2020?7?12??? ??2:14???
>
> On Sat, 11 Jul 2020 18:10:38 +0800 Yahui Chen wrote:
> > 2. If the wakeup mechanism is used, that is, use the
> > `XDP_UMEM_USES_NEED_WAKEUP` flag. This method takes advantage of the
> > interrupt delay function of ixgbe skillfully, thus solving the problem
> > that the si CPU is always 100%. However, it will cause other problems.
> > The port-level flow control will be triggered on 82599, and the pause
> > frame will be sent to the upstream sender. This will affect the other
> > packet receiving queues of the network card, resulting in the packet
> > receiving rate of all queues dropping to 10Kpps.
>
> To me the current behavior sounds correct.. if you don't want pause
> frames to be generated you have to disable them completely. The point
> of pause frames is to prevent drops.
