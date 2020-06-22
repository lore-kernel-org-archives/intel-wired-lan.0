From: David Miller <davem@davemloft.net>
Date: Mon, 22 Jun 2020 15:39:13 -0700 (PDT)
Subject: [Intel-wired-lan] [PATCH net-next v3 0/4] bonding: initial
 support for hardware crypto offload
In-Reply-To: <20200619143155.20726-1-jarod@redhat.com>
References: <20200619143155.20726-1-jarod@redhat.com>
Message-ID: <20200622.153913.2174708105885098663.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jarod Wilson <jarod@redhat.com>
Date: Fri, 19 Jun 2020 10:31:51 -0400

> This is an initial functional implementation for doing pass-through of
> hardware encryption from bonding device to capable slaves, in active-backup
> bond setups. This was developed and tested using ixgbe-driven Intel x520
> interfaces with libreswan and a transport mode connection, primarily using
> netperf, with assorted connection failures forced during transmission. The
> failover works quite well in my testing, and overall performance is right
> on par with offload when running on a bare interface, no bond involved.
> 
> Caveats: this is ONLY enabled for active-backup, because I'm not sure
> how one would manage multiple offload handles for different devices all
> running at the same time in the same xfrm, and it relies on some minor
> changes to both the xfrm code and slave device driver code to get things
> to behave, and I don't have immediate access to any other hardware that
> could function similarly, but the NIC driver changes are minimal and
> straight-forward enough that I've included what I think ought to be
> enough for mlx5 devices too.
> 
> v2: reordered patches, switched (back) to using CONFIG_XFRM_OFFLOAD
> to wrap the code additions and wrapped overlooked additions.
> v3: rebase w/net-next open, add proper cc list to cover letter

Series applied, thanks.
