From: John Fastabend <john.fastabend@gmail.com>
Date: Mon, 07 Mar 2016 11:31:07 -0800
Subject: [Intel-wired-lan] [PATCH v2 net-next 3/3] net: ixgbe: Fix
 cls_u32 offload support for L4 ports.
In-Reply-To: <1457372509-3135-3-git-send-email-sridhar.samudrala@intel.com>
References: <1457372509-3135-1-git-send-email-sridhar.samudrala@intel.com>
 <1457372509-3135-3-git-send-email-sridhar.samudrala@intel.com>
Message-ID: <56DDD6FB.6090408@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 16-03-07 09:41 AM, Sridhar Samudrala wrote:
> Fix support for 16 bit source/dest port matches in ixgbe model.
> u32 uses a single 32-bit key value for both source and destination ports
> starting at offset 0. So replace the 2 functions with a single function
> that takes this key value/mask to program both source and dest ports.
> 
> Verified with the following filter:
> 
>  #tc qdisc add dev p4p1 ingress
>  #tc filter add dev p4p1 parent ffff: protocol ip prio 99 \
> 	handle 1: u32 divisor 1
>  #tc filter add dev p4p1 parent ffff: protocol ip prio 99 \
> 	handle 800:0:10 u32 ht 800: link 1: \
> 	offset at 0 mask 0f00 shift 6 plus 0 eat match ip protocol 6 ff
>  #tc filter add dev p4p1 parent ffff: protocol ip prio 99 \
> 	handle 1:0:10 u32 ht 1: \
> 	match tcp src 1024 ffff match tcp dst 80 ffff action drop
>  #tc filter add dev p4p1 parent ffff: protocol ip prio 99 \
> 	handle 1:0:11 u32 ht 1: \
> 	match tcp src 1025 ffff action drop
>  #tc filter add dev p4p1 parent ffff: protocol ip prio 99 \
> 	handle 1:0:12 u32 ht 1: \
> 	match tcp dst 81 ffff action drop
> 
> Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> ---


Thanks nice looking series.

Acked-by: John Fastabend <john.r.fastabend@intel.com>

