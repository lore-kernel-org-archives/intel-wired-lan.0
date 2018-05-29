From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 29 May 2018 21:37:03 +0000
Subject: [Intel-wired-lan] [PATCH net] ixgbe: fix parsing of TC actions
 for HW offload
In-Reply-To: <20180528163913.16315-1-ohlavaty@redhat.com>
References: <20180528163913.16315-1-ohlavaty@redhat.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2C4ABC@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Ondrej Hlavat?
> Sent: Monday, May 28, 2018 9:39 AM
> To: netdev at vger.kernel.org
> Cc: Ond?ej Hlavat? <ohlavaty@redhat.com>; Jiri Pirko <jiri@resnulli.us>;
> intel-wired-lan at lists.osuosl.org; Jamal Hadi Salim <jhs@mojatatu.com>
> Subject: [Intel-wired-lan] [PATCH net] ixgbe: fix parsing of TC actions for HW
> offload
> 
> The previous code was optimistic, accepting the offload of whole action chain
> when there was a single known action (drop/redirect). This results in
> offloading a rule which should not be offloaded, because its behavior cannot
> be reproduced in the hardware.
> 
> For example:
> 
> $ tc filter add dev eno1 parent ffff: protocol ip \
>     u32 ht 800: order 1 match tcp src 42 FFFF \
>     action mirred egress mirror dev enp1s16 pipe \
>     drop
> 
> The controller is unable to mirror the packet to a VF, but still offloads the rule
> by dropping the packet.
> 
> Change the approach of the function to a pessimistic one, rejecting the chain
> when an unknown action is found. This is better suited for future extensions.
> 
> Note that both recognized actions always return TC_ACT_SHOT, therefore it
> is safe to ignore actions behind them.
> 
> Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> Cc: intel-wired-lan at lists.osuosl.org
> Cc: Jamal Hadi Salim <jhs@mojatatu.com>
> Cc: Jiri Pirko <jiri@resnulli.us>
> Signed-off-by: Ond?ej Hlavat? <ohlavaty@redhat.com>
> 
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


