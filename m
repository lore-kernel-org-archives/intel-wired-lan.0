From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Mon, 21 Jan 2019 17:42:02 +0100
Subject: [Intel-wired-lan] [PATCH] i40e: replace switch-statement with
 if-clause
In-Reply-To: <20190121163356.31332-1-bjorn.topel@gmail.com>
References: <20190121163356.31332-1-bjorn.topel@gmail.com>
Message-ID: <60f67e64-568c-bf04-5e9c-0429c5ae2882@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Bj?rn,


On 01/21/19 17:33, bjorn.topel at gmail.com wrote:
> From: Bj?rn T?pel <bjorn.topel@intel.com>
> 
> GCC will generate jump tables for switch-statements with more than 5
> case statements. An entry into the jump table is an indirect call,
> which means that for CONFIG_RETPOLINE builds, this is rather
> expensive.
> 
> This commit replaces the switch-statement that acts on the XDP program
> result with an if-clause.

Maybe mention the performance improvement already here. I?d also put it
into the commit message summary. Something like:

> i40e: Speed up retpoline case by using if-clause

If that jump tables are a common problem, I wonder, why the compiler
cannot be adapted to generate better performing code or an option passed
to the compiler.

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
> 
> Signed-off-by: Bj?rn T?pel <bjorn.topel@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 31 ++++---------------
>  .../ethernet/intel/i40e/i40e_txrx_common.h    | 27 ++++++++++++++++
>  drivers/net/ethernet/intel/i40e/i40e_xsk.c    | 24 ++------------
>  3 files changed, 35 insertions(+), 47 deletions(-)

[?]


Kind regards,

Paul

-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/pkcs7-signature
Size: 5174 bytes
Desc: S/MIME Cryptographic Signature
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20190121/15b4cb01/attachment.p7s>
