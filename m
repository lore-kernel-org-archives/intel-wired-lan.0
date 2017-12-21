From: Yanjun Zhu <yanjun.zhu@oracle.com>
Date: Thu, 21 Dec 2017 14:39:47 +0800
Subject: [Intel-wired-lan] [PATCH v3 next-queue 00/10] ixgbe: Add ipsec
 offload
In-Reply-To: <1513728002-7643-1-git-send-email-shannon.nelson@oracle.com>
References: <1513728002-7643-1-git-send-email-shannon.nelson@oracle.com>
Message-ID: <e576cb0e-4b4f-12d9-c817-246d26cb0ada@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 2017/12/20 7:59, Shannon Nelson wrote:
> This is an implementation of the ipsec hardware offload feature for
> the ixgbe driver and Intel's 10Gbe series NICs: x540, x550, 82599.
Hi, Nelson

I notice that the ipsec feature is based on x540, x550, 82599.? But this 
ixgbe driver
will also work with 82598.

Does this ipsec feature also work with 82598?

Thanks a lot.
Zhu Yanjun
> These patches apply to net-next v4.14 as well as Jeff Kirsher's next-queue
> v4.15-rc1-206-ge47375b.
>
> The ixgbe NICs support ipsec offload for 1024 Rx and 1024 Tx Security
> Associations (SAs), using up to 128 inbound IP addresses, and using the
> rfc4106(gcm(aes)) encryption.  This code does not yet support IPv6,
> checksum offload, or TSO in conjunction with the ipsec offload - those
> will be added in the future.
>
> This code shows improvements in both packet throughput and CPU utilization.
> For example, here are some quicky numbers that show the magnitude of the
> performance gain on a single run of "iperf -c <dest>" with the ipsec
> offload on both ends of a point-to-point connection:
>
> 	9.4 Gbps - normal case
> 	7.6 Gbps - ipsec with offload
> 	343 Mbps - ipsec no offload
>
> To set up a similar test case, you first need to be sure you have a recent
> version of iproute2 that supports the ipsec offload tag, probably something
> from ip 4.12 or newer would be best.  I have a shell script that builds
> up the appropriate commands for me, but here are the resulting commands
> for all tcp traffic between 14.0.0.52 and 14.0.0.70:
>
> For the left side (14.0.0.52):
>    ip x p add dir out src 14.0.0.52/24 dst 14.0.0.70/24 proto tcp tmpl \
>       proto esp src 14.0.0.52 dst 14.0.0.70 spi 0x07 mode transport reqid 0x07
>    ip x p add dir in src 14.0.0.70/24 dst 14.0.0.52/24 proto tcp tmpl \
>       proto esp dst 14.0.0.52 src 14.0.0.70 spi 0x07 mode transport reqid 0x07
>    ip x s add proto esp src 14.0.0.52 dst 14.0.0.70 spi 0x07 mode transport \
>       reqid 0x07 replay-window 32 \
>       aead 'rfc4106(gcm(aes))' 0x44434241343332312423222114131211f4f3f2f1 128 \
>       sel src 14.0.0.52/24 dst 14.0.0.70/24 proto tcp offload dev eth4 dir out
>    ip x s add proto esp dst 14.0.0.52 src 14.0.0.70 spi 0x07 mode transport \
>       reqid 0x07 replay-window 32 \
>       aead 'rfc4106(gcm(aes))' 0x44434241343332312423222114131211f4f3f2f1 128 \
>       sel src 14.0.0.70/24 dst 14.0.0.52/24 proto tcp offload dev eth4 dir in
>   
> For the right side (14.0.0.70):
>    ip x p add dir out src 14.0.0.70/24 dst 14.0.0.52/24 proto tcp tmpl \
>       proto esp src 14.0.0.70 dst 14.0.0.52 spi 0x07 mode transport reqid 0x07
>    ip x p add dir in src 14.0.0.52/24 dst 14.0.0.70/24 proto tcp tmpl \
>       proto esp dst 14.0.0.70 src 14.0.0.52 spi 0x07 mode transport reqid 0x07
>    ip x s add proto esp src 14.0.0.70 dst 14.0.0.52 spi 0x07 mode transport \
>       reqid 0x07 replay-window 32 \
>       aead 'rfc4106(gcm(aes))' 0x44434241343332312423222114131211f4f3f2f1 128 \
>       sel src 14.0.0.70/24 dst 14.0.0.52/24 proto tcp offload dev eth4 dir out
>    ip x s add proto esp dst 14.0.0.70 src 14.0.0.52 spi 0x07 mode transport \
>       reqid 0x07 replay-window 32 \
>       aead 'rfc4106(gcm(aes))' 0x44434241343332312423222114131211f4f3f2f1 128 \
>       sel src 14.0.0.52/24 dst 14.0.0.70/24 proto tcp offload dev eth4 dir in
>
> In both cases, the command "ip x s flush ; ip x p flush" will clean
> it all out and remove the offloads.
>
> Lastly, thanks to Alex Duyck for his early comments.
>
> Please see the individual patches for specific update info.
>
> v3: fixes after comments from those wonderfully pesky kbuild robots
> v2: fixes after comments from Alex
>
> Shannon Nelson (10):
>    ixgbe: clean up ipsec defines
>    ixgbe: add ipsec register access routines
>    ixgbe: add ipsec engine start and stop routines
>    ixgbe: add ipsec data structures
>    ixgbe: add ipsec offload add and remove SA
>    ixgbe: restore offloaded SAs after a reset
>    ixgbe: process the Rx ipsec offload
>    ixgbe: process the Tx ipsec offload
>    ixgbe: ipsec offload stats
>    ixgbe: register ipsec offload with the xfrm subsystem
>
>   drivers/net/ethernet/intel/ixgbe/Makefile        |   1 +
>   drivers/net/ethernet/intel/ixgbe/ixgbe.h         |  33 +-
>   drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c |   2 +
>   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c   | 923 +++++++++++++++++++++++
>   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.h   |  92 +++
>   drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c     |   4 +-
>   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c    |  39 +-
>   drivers/net/ethernet/intel/ixgbe/ixgbe_type.h    |  22 +-
>   8 files changed, 1093 insertions(+), 23 deletions(-)
>   create mode 100644 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
>   create mode 100644 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.h
>

