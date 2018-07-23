From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 23 Jul 2018 10:10:57 -0700
Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH 2/2] ixgbe:
 Refactor queue disable logic to take completion time into account
In-Reply-To: <ab26e694-6c7c-7e70-42f3-646939708ee2@oracle.com>
References: <20180720222647.3568.34992.stgit@ahduyck-green-test.jf.intel.com>
 <20180720222934.3568.15842.stgit@ahduyck-green-test.jf.intel.com>
 <ab26e694-6c7c-7e70-42f3-646939708ee2@oracle.com>
Message-ID: <CAKgT0UcKaSKKQgULsCVa+iUh1bFUg=ZZaNJ6fp=HiECQfPor7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, Jul 23, 2018 at 9:34 AM, Shannon Nelson
<shannon.nelson@oracle.com> wrote:
> On 7/20/2018 3:29 PM, Alexander Duyck wrote:
>>
>> This change is meant to allow us to take completion time into account when
>> disabling queues. Previously we were just working with hard coded values
>> for how long we should wait. This worked fine for the standard case where
>> completion timeout was operating in the 50us to 50ms range, however on
>> platforms that have higher completion timeout times this was resulting in
>> Rx queues disable messages being displayed as we weren't waiting long
>> enough for outstanding Rx DMA completions.
>>
>> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
>> ---
>
>
> [...]
>
>
>> +
>> +void ixgbe_disable_tx(struct ixgbe_adapter *adapter)
>> +{
>> +       unsigned long wait_delay, delay_interval;
>> +       struct ixgbe_hw *hw = &adapter->hw;
>> +       int i, wait_loop;
>> +       u32 txdctl;
>> +
>> +       if (ixgbe_removed(hw->hw_addr))
>> +               return;
>> +
>> +       /* disable all enabled Tx queues */
>> +       for (i = 0; i < adapter->num_tx_queues; i++) {
>> +               struct ixgbe_ring *ring = adapter->tx_ring[i];
>> +               u8 reg_idx = ring->reg_idx;
>> +
>> +               IXGBE_WRITE_REG(hw, IXGBE_TXDCTL(reg_idx),
>> IXGBE_TXDCTL_SWFLSH);
>> +       }
>> +
>> +       /* disable all enabled XDP Tx queues */
>> +       for (i = 0; i < adapter->num_xdp_queues; i++) {
>> +               struct ixgbe_ring *ring = adapter->xdp_ring[i];
>> +               u8 reg_idx = ring->reg_idx;
>> +
>> +               IXGBE_WRITE_REG(hw, IXGBE_TXDCTL(reg_idx),
>> IXGBE_TXDCTL_SWFLSH);
>> +       }
>> +
>> +       /* If the link is now up there shouldn't be much in the way of
>
>
> I think you mean "not" up rather than "now" up, which has the opposite
> meaning and could be a bit confusing.

Yeah, that is a typo.

>
>> +        * pending transactions. Those that are left will be flushed out
>> +        * when the reset logic goes through the flush sequence to clean
>> out
>> +        * the pending Tx transactions.
>> +        */
>> +       if (!(IXGBE_READ_REG(hw, IXGBE_LINKS) & IXGBE_LINKS_UP))
>> +               goto dma_engine_disable;
>> +
>> +       /* Determine our minimum delay interval. We will increase this
>> value
>> +        * with each subsequent test. This way if the device returns
>> quickly
>> +        * we should spend as little time as possible waiting, however as
>> +        * the time increases we will wait for larger periods of time.
>> +        *
>> +        * The trick here is that we increase the interval using the
>> +        * following pattern: 1x 3x 5x 7x 9x 11x 13x 15x 17x 19x. The
>> result
>> +        * of that wait is that it totals up to 100x whatever interval we
>> +        * choose. Since our minimum wait is 100us we can just divide the
>> +        * total timeout by 100 to get our minimum delay interval.
>> +        */
>> +       delay_interval = ixgbe_get_completion_timeout(adapter) / 100;
>> +
>> +       wait_loop = IXGBE_MAX_RX_DESC_POLL;
>> +       wait_delay = delay_interval;
>> +
>> +       while (wait_loop--) {
>> +               usleep_range(wait_delay, wait_delay + 10);
>> +               wait_delay += delay_interval * 2;
>> +               txdctl = 0;
>> +
>> +               /* OR together the reading of all the active TXDCTL
>> registers,
>> +                * and then test the result. We need the disable to
>> complete
>> +                * before we start freeing the memory and invalidating the
>> +                * DMA mappings.
>> +                */
>> +               for (i = 0; i < adapter->num_tx_queues; i++) {
>> +                       struct ixgbe_ring *ring = adapter->tx_ring[i];
>> +                       u8 reg_idx = ring->reg_idx;
>> +
>> +                       txdctl |= IXGBE_READ_REG(hw,
>> IXGBE_TXDCTL(reg_idx));
>> +               }
>> +               for (i = 0; i < adapter->num_xdp_queues; i++) {
>> +                       struct ixgbe_ring *ring = adapter->xdp_ring[i];
>> +                       u8 reg_idx = ring->reg_idx;
>> +
>> +                       txdctl |= IXGBE_READ_REG(hw,
>> IXGBE_TXDCTL(reg_idx));
>> +               }
>> +
>> +               if (!(txdctl & IXGBE_TXDCTL_ENABLE))
>> +                       goto dma_engine_disable;
>> +       }
>> +
>> +       e_err(drv,
>> +             "TXDCTL.ENABLE for one or more queues not cleared within the
>> polling period\n");
>> +
>> +dma_engine_disable:
>> +       /* Disable the Tx DMA engine on 82599 and later MAC */
>> +       switch (hw->mac.type) {
>> +       case ixgbe_mac_82599EB:
>> +       case ixgbe_mac_X540:
>> +       case ixgbe_mac_X550:
>> +       case ixgbe_mac_X550EM_x:
>> +       case ixgbe_mac_x550em_a:
>> +               IXGBE_WRITE_REG(hw, IXGBE_DMATXCTL,
>> +                               (IXGBE_READ_REG(hw, IXGBE_DMATXCTL) &
>> +                                ~IXGBE_DMATXCTL_TE));
>> +               /* fall through */
>> +       default:
>> +               break;
>> +       }
>
>
> Picky bike-shed thoughts: I realize you're just moving the previously
> existing code, but with the comment "... and later MAC" I would think the
> translation to code puts all the later MACs into the default and have the
> WRITE_REG() as the default action.  This would make it default to the
> correct action for any new MACs if someone forgot to fix up this part of the
> code.
>
>         switch (hw->mac.type) {
>         case ixgbe_mac_82598EB:
>                 break;
>
>         case ixgbe_mac_82599EB:
>         case ixgbe_mac_X540:
>         case ixgbe_mac_X550:
>         case ixgbe_mac_X550EM_x:
>         case ixgbe_mac_x550em_a:
>         default:
>                 IXGBE_WRITE_REG(hw, IXGBE_DMATXCTL,
>                                 (IXGBE_READ_REG(hw, IXGBE_DMATXCTL) &
>                                  ~IXGBE_DMATXCTL_TE));
>                 break;
>         }
>
> Or even simpler,
>
>         if (hw->mac.type != ixgbe_mac_82598EB)
>                 IXGBE_WRITE_REG(hw, IXGBE_DMATXCTL,
>                                 (IXGBE_READ_REG(hw, IXGBE_DMATXCTL) &
>                                  ~IXGBE_DMATXCTL_TE));
>
> Okay, I'll stop now.
>
> Cheers,
> sln

Yeah, for now I will probably leave the code as is, but this is
something that could be updated int he future. Either that or you are
always free to submit a patch.. :-)

- Alex
