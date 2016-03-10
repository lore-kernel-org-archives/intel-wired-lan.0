From: Samudrala, Sridhar <sridhar.samudrala@intel.com>
Date: Wed, 09 Mar 2016 21:35:10 -0800
Subject: [Intel-wired-lan] [PATCH] [net-next] net: ixgbe: Extend cls_u32
 offload to support UDP headers.
In-Reply-To: <20160309233215.32377.54007.stgit@sdncamp.jf.intel.com>
References: <20160309233215.32377.54007.stgit@sdncamp.jf.intel.com>
Message-ID: <56E1078E.4070300@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 3/9/2016 3:32 PM, Amritha Nambiar wrote:
> Added support to match on UDP fields in the transport layer.
> Extended core logic to support multiple headers.
>
> Verified with the following filters :
>
> # tc qdisc add dev enp2s0f0 ingress
> # tc filter add dev enp2s0f0 parent ffff: protocol ip prio 99 \
> 	handle 1: u32 divisor 1
> # tc filter add dev enp2s0f0 protocol ip parent ffff: prio 99 \
> 	u32 ht 800: order 1 link 1: \
> 	offset at 0 mask 0f00 shift 6 plus 0 eat match ip protocol 6 ff
> # tc filter add dev enp2s0f0 parent ffff: protocol ip \
> 	u32 ht 1: order 2 \
> 	match tcp src 1024 ffff match tcp dst 23 ffff action drop
> # tc filter add dev enp2s0f0 parent ffff: protocol ip prio 99 \
> 	handle 2: u32 divisor 1
> # tc filter add dev enp2s0f0 protocol ip parent ffff: prio 99 \
> 	u32 ht 800: order 3 link 2: \
> 	offset at 0 mask 0f00 shift 6 plus 0 eat match ip protocol 17 ff
> # tc filter add dev enp2s0f0 parent ffff: protocol ip \
> 	u32 ht 2: order 4 \
> 	match udp src 1025 ffff match udp dst 24 ffff action drop
>
> Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>

Acked-by: Sridhar Samudrala <sridhar.samudrala@intel.com>

