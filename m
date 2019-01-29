From: Daniel Borkmann <daniel@iogearbox.net>
Date: Tue, 29 Jan 2019 12:17:14 +0100
Subject: [Intel-wired-lan] [PATCH v2] i40e: replace switch-statement to
 speed-up retpoline-enabled builds
In-Reply-To: <20190129095754.9390-1-bjorn.topel@gmail.com>
References: <20190129095754.9390-1-bjorn.topel@gmail.com>
Message-ID: <5650fdb7-5b86-9c7d-c112-1ff5ee7812b7@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 01/29/2019 10:57 AM, bjorn.topel at gmail.com wrote:
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
> 
> Signed-off-by: Bj?rn T?pel <bjorn.topel@intel.com>

Looks good. Given the performance improvements, wondering in general whether
it would make sense to raise the default limit for generating jump tables if
we have CONFIG_RETPOLINE enabled; as in:

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 9c5a67d..33495a9 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -217,6 +217,8 @@ KBUILD_CFLAGS += -fno-asynchronous-unwind-tables
 # Avoid indirect branches in kernel to deal with Spectre
 ifdef CONFIG_RETPOLINE
   KBUILD_CFLAGS += $(RETPOLINE_CFLAGS)
+  # Avoid generating slow indirect jumps for small number of switch cases
+  KBUILD_CFLAGS += --param case-values-threshold=12
 endif

 archscripts: scripts_basic

That would likely bloat the kernel a bit also in slow-path places where it
would not be needed, but it would generically catch majority of cases. I'll
run some experiments later today (but in any case that should not block this
patch here).

Cheers,
Daniel
