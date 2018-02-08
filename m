From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Thu, 8 Feb 2018 06:23:25 -0800
Subject: [Intel-wired-lan] [PATCH net-queue 2/3] e1000e: Fix queue
 interrupt re-raising in Other interrupt.
In-Reply-To: <20180208064714.6042-2-bpoirier@suse.com>
References: <20180208064714.6042-1-bpoirier@suse.com>
 <20180208064714.6042-2-bpoirier@suse.com>
Message-ID: <CAKgT0Ud24GKtxcePETap8ECxhjGE0OOaZYb0G_cyY1XKp22X_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Feb 7, 2018 at 10:47 PM, Benjamin Poirier <bpoirier@suse.com> wrote:
> restores the ICS write for rx/tx queue interrupts which was present before
> commit 16ecba59bc33 ("e1000e: Do not read ICR in Other interrupt",
> v4.5-rc1) but was not restored in commit 4aea7a5c5e94 ("e1000e: Avoid
> receiver overrun interrupt bursts", v4.15-rc1).
>
> This re-raises the queue interrupts in case the txq or rxq bits were set in
> ICR and the Other interrupt handler read and cleared ICR before the queue
> interrupt was raised.
>
> Fixes: 4aea7a5c5e94 ("e1000e: Avoid receiver overrun interrupt bursts")
> Signed-off-by: Benjamin Poirier <bpoirier@suse.com>

Acked-by: Alexander Duyck <alexander.h.duyck@intel.com>

> ---
>  drivers/net/ethernet/intel/e1000e/netdev.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
> index 3b36efa6228d..2c9609bee2ae 100644
> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> @@ -1919,6 +1919,9 @@ static irqreturn_t e1000_msix_other(int __always_unused irq, void *data)
>         icr = er32(ICR);
>         ew32(ICR, E1000_ICR_OTHER);
>
> +       if (icr & adapter->eiac_mask)
> +               ew32(ICS, (icr & adapter->eiac_mask));
> +
>         if (icr & E1000_ICR_LSC) {
>                 ew32(ICR, E1000_ICR_LSC);
>                 hw->mac.get_link_status = true;
> --
> 2.16.1
>
