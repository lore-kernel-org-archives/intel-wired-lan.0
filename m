From: Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Thu, 21 Apr 2022 13:23:53 -0700
Subject: [Intel-wired-lan] [PATCH v2 2/2] igc: Trigger proper interrupts
 in igc_xsk_wakeup
In-Reply-To: <20220420012635.13733-3-jeff.evanson@qsc.com>
References: <20220420012635.13733-1-jeff.evanson@qsc.com>
 <20220420012635.13733-3-jeff.evanson@qsc.com>
Message-ID: <ccb8e7f0-c038-c525-0902-47c321c19a10@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


On 4/19/2022 6:26 PM, jeff.evanson at gmail.com wrote:
> From: Jeff Evanson <jeff.evanson@qsc.com>
>
> In igc_xsk_wakeup, trigger the proper interrupt based on whether flags
> contains XDP_WAKEUP_RX and/or XDP_WAKEUP_TX.
>
> Consider a scenario where the transmit queue interrupt is mapped to a
> different irq from the receive queue. If XDP_WAKEUP_TX is set in the
> flags argument, the interrupt for transmit queue must be triggered,
> otherwise the transmit queue's napi_struct will never be scheduled.
>
> In the case where both XDP_WAKEUP_TX and XDP_WAKEUP_RX are both set,
> the receive interrupt should always be triggered, but the transmit
> interrupt should only be triggered if its q_vector differs from the
> receive queue's interrupt.
>
> Fixes: fc9df2a0b520 ("igc: Enable RX via AF_XDP zero-copy")

You're missing your sign-off; same for patch 1. Also, there's a handful 
of issues being reported by checkpatch [1]

Thanks,

Tony

[1] 
https://patchwork.kernel.org/project/netdevbpf/patch/20220420012635.13733-3-jeff.evanson at qsc.com/

