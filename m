From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Date: Tue, 19 Jan 2021 17:17:15 +0100
Subject: [Intel-wired-lan] ixgbe limits on core count
In-Reply-To: <7F3D0A12-F9FE-4386-9D35-D1C89BD84227@gmail.com>
References: <7F3D0A12-F9FE-4386-9D35-D1C89BD84227@gmail.com>
Message-ID: <20210119161715.GA22141@ranger.igk.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Jan 18, 2021 at 04:19:23AM -0700, Brian Topping wrote:
> Hello experts! 
> 
> I?m setting up a machine with two E5-2696 v3 CPUs using XDP on kernel
> 5.10.6-051006-generic and running into the constraint at
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c#n10136
> <https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c#n10136>. 
> 

Hi Brian,
we're aware of this issue, thanks for bringing this up. We plan to address
this in some near future.

> Any advice what the most practical long term solution is?
> 
> Short term, I can dial back the number of usable cores. I haven?t dug
> into the bits to understand if this constraint is based on hardware
> limits on the card or this was a choice that was made when processors
> had fewer cores.

ixgbe has only 128 Tx HW queues AFAIK, so currently we have a check
against cpu count and do not load XDP for case when machine has more than
64 cpus as XDP needs to have a dedicated HW Tx queue so that it is fully
operational.

I think that solution (or workaround, not sure how to relate to that) is
picking what is left in terms of HW Tx resources and assigning it to XDP.

If sending happens on a cpu nr 70:

cpu_nr = 70
cpu_cnt = 72;
xdp_tx_cnt = 56;

then we pick (cpu_nr % xdp_tx_cnt) + cpu_cnt = (70 % 56) + 72 = 86 HW Tx
queue. At the same time, same queue could be accessed from cpu 14 if I am
not mistaken, so this brings the need for locking. We would be detecting
such configuration at the time when XDP prog is being loaded onto
interface and picking that 'fallback' mode. For < 64 cpu machines, current
scheme will be picked so we wouldn't be hurting performance via unneeded
lock acquiring for such systems.

Maciej

> 
> Thanks kindly!
> 
> Brian

> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan

