From: Jesper Dangaard Brouer <brouer@redhat.com>
Date: Mon, 21 Jan 2019 19:59:36 +0100
Subject: [Intel-wired-lan] [PATCH] i40e: replace switch-statement with
 if-clause
In-Reply-To: <20190121163356.31332-1-bjorn.topel@gmail.com>
References: <20190121163356.31332-1-bjorn.topel@gmail.com>
Message-ID: <20190121195936.0badfb33@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 21 Jan 2019 17:33:56 +0100
bjorn.topel at gmail.com wrote:

> From: Bj?rn T?pel <bjorn.topel@intel.com>
> 
> GCC will generate jump tables for switch-statements with more than 5
> case statements. An entry into the jump table is an indirect call,
> which means that for CONFIG_RETPOLINE builds, this is rather
> expensive.
> 
> This commit replaces the switch-statement that acts on the XDP program
> result with an if-clause.
> 
> The if-clause was also refactored into a common function that can be
> used by AF_XDP zero-copy and non-zero-copy code.
> 
> Performance prior this patch:
> $ sudo ./xdp_rxq_info --dev enp134s0f0 --action XDP_DROP
> Running XDP on dev:enp134s0f0 (ifindex:7) action:XDP_DROP options:no_touch
> XDP stats       CPU     pps         issue-pps
> XDP-RX CPU      20      18983018    0
> XDP-RX CPU      total   18983018
> 
> RXQ stats       RXQ:CPU pps         issue-pps
> rx_queue_index   20:20  18983012    0
> rx_queue_index   20:sum 18983012
> 
> $ sudo ./xdpsock -i enp134s0f0 -q 20 -n 2 -z -r
>  sock0 at enp134s0f0:20 rxdrop
>                 pps         pkts        2.00
> rx              14,641,496  144,751,092
> tx              0           0
> 
> And after:
> $ sudo ./xdp_rxq_info --dev enp134s0f0 --action XDP_DROP
> Running XDP on dev:enp134s0f0 (ifindex:7) action:XDP_DROP options:no_touch
> XDP stats       CPU     pps         issue-pps
> XDP-RX CPU      20      24000986    0
> XDP-RX CPU      total   24000986
> 
> RXQ stats       RXQ:CPU pps         issue-pps
> rx_queue_index   20:20  24000985    0
> rx_queue_index   20:sum 24000985
> 
>   +26%
> 
> $ sudo ./xdpsock -i enp134s0f0 -q 20 -n 2 -z -r
>  sock0 at enp134s0f0:20 rxdrop
>                 pps         pkts        2.00
> rx              17,623,578  163,503,263
> tx              0           0
> 
>   +20%

The saving/cost of the retpoline is around 11 nanosec, which
corresponds well with my previous experience and microbenchmarking
around 12 ns.

((1/18983012)-(1/24000986))*10^9
11.01372430029000000000 nanosec

((1/14641496)-(1/17623578))*10^9
11.55686507951000000000 nanosec

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer
