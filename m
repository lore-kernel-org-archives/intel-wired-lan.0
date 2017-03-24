From: William Tu <u9012063@gmail.com>
Date: Fri, 24 Mar 2017 15:22:40 -0700
Subject: [Intel-wired-lan] [PATCH v7 0/2] XDP support for ixgbe
In-Reply-To: <20170324042949.10293.43329.stgit@john-Precision-Tower-5810>
References: <20170324042949.10293.43329.stgit@john-Precision-Tower-5810>
Message-ID: <CALDO+SYA4a37ePhzSPwbqqnCngU6uudeiCGvGoXMPU3MbX4W2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Mar 23, 2017 at 9:30 PM, John Fastabend
<john.fastabend@gmail.com> wrote:
> This version fixes a couple issues with q_vector allocation and query on XDP
> program.
>
> ---
>
> John Fastabend (2):
>       ixgbe: add XDP support for pass and drop actions
>       ixgbe: add support for XDP_TX action
>
>
>  drivers/net/ethernet/intel/ixgbe/ixgbe.h         |   23 +
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c |   29 +
>  drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c     |   78 +++-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c    |  434 +++++++++++++++++++---
>  4 files changed, 490 insertions(+), 74 deletions(-)
>
> --
> Signature

Thanks. I tested using samples/bpf/xdp1 and xdp2 using ping and dpdk
pktgen. Both work OK.

When enabling xdp, dmesg shows:
[12270.610462] pps pps0: new PPS source ptp6
[12270.610465] ixgbe 0000:05:00.0: registered PHC device on enp5s0f0
[12271.619018] ixgbe 0000:05:00.0: removed PHC on enp5s0f0
[12271.943334] ixgbe 0000:05:00.0: Multiqueue Enabled: Rx Queue count
= 16, Tx Queue count = 16 XDP Queue count = 0
[12272.011324] pps pps0: new PPS source ptp6
[12272.011326] ixgbe 0000:05:00.0: registered PHC device on enp5s0f0
[12276.477066] ixgbe 0000:05:00.0 enp5s0f0: NIC Link is Up 10 Gbps,
Flow Control: None

I'm not sure it's important or not.
Regards,
William
