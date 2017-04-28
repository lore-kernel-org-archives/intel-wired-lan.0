From: David Mirabito <davidm@metamako.com>
Date: Fri, 28 Apr 2017 11:32:28 +1000
Subject: [Intel-wired-lan] [PATCH] net-intel: fix race condition with
	PTP_TX_IN_PROGRESS bits
In-Reply-To: <20170427235553.24803-1-jacob.e.keller@intel.com>
References: <20170427235553.24803-1-jacob.e.keller@intel.com>
Message-ID: <CACJTkKHigpjhksUkh=rx9LfTvYr5nupih4Zom82tU5UkQVVwNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Thanks Jacob,

Your patch is pretty much identical, but nicer, to what I am currently
running which so far seems solid. We've now gone 24 hours without loosing a
single timestamp when running ptp4l -- a new record!

Elsewhere you mentioned considering whether the timeout stat should be
bumped when the tx path knows it failed grab the timestamp slot. IMHO, some
way to for users to confirm that something happened from the driver's
perspective would be most useful. Seeing a counter rising in correlation to
observing problems in some application could help narrow down on the root
cause.  Currently I just have a dev_debug for when the test-and-set fails
whilst I keep an eye on things.

On a somewhat related note, in igb at least - should the error cases after
acquiring that lock (i.e dma mapping or tso failure)  clear it and free the
stashed skb? The existing timeout & clear mechanism seems to only work on
82576 which polls - other chips seem to rely on the TX_TS interrupt
arriving in order to notice that a tx timestamp hasn't been received in a
while. Unless there are cases where HW raises the interrupt, but then does
not make the timestamp available this doesn't look like it does what was
intended - there's no catchall to clean things up if the interrupt never
arrives in the first place.
Or are those particular TX errors hard enough that a more general reset
occurs which could clear this up? It seems the only other way
TX_IN_PROGRESS might be cleared from adapter->state is suspend related.

Either way, this is more academic for now (and possibly quite rare, if not
impossible to achieve in practice), whereas the problems addressed in the
patch were directly hurting us so we're already ahead.

I'll try yours as posted, replacing what we're running below.

Thanks again,
DavidM


----
Snippet of
 {
        struct e1000_hw *hw = &adapter->hw;
        struct skb_shared_hwtstamps shhwtstamps;
+    struct sk_buff *skb;
        u64 regval;
        int adjust = 0;

@@ -747,10 +751,13 @@ static void igb_ptp_tx_hwtstamp(struct igb_adapter
*adapter)
        shhwtstamps.hwtstamp =
                ktime_add_ns(shhwtstamps.hwtstamp, adjust);

-       skb_tstamp_tx(adapter->ptp_tx_skb, &shhwtstamps);
-       dev_kfree_skb_any(adapter->ptp_tx_skb);
+       skb = adapter->ptp_tx_skb;
        adapter->ptp_tx_skb = NULL;
        clear_bit_unlock(__IGB_PTP_TX_IN_PROGRESS, &adapter->state);
+
+       skb_tstamp_tx(skb, &shhwtstamps);
+       dev_kfree_skb_any(skb);
 }

This email is subject to copyright and the information in it is
confidential. This e-mail, its content and any files transmitted with it
are intended solely for the addressee/s and may be legally privileged
and/or confidential. Access by any other person other than the addressee/s
is unauthorized without the express written permission of the sender. If
you have received this e-mail in error notify the sender immediately by
email, do not use the email or any attachment or disclose them to any
person, delete the email from your system and destroy all copies you may
have printed. Metamako LP does not guarantee that any email or attachment
is secure or free from viruses or other defects

On 28 April 2017 at 09:55, Jacob Keller <jacob.e.keller@intel.com> wrote:

> Several Intel drivers have a hardware limitation on Tx PTP packets which
> requires them to limit to a single Tx timestamp at once. THey do this
> mostly using a state bit lock which enforces that only one timestamp
> request is honored at a time.
>
> Unfortunately they all suffer from a similar race condition. The bit
> lock is not cleared until after skb_tstamp_tx() is called notifying
> applications of a new Tx timestamp. Even a well behaved application
> sending only one packet at a time and waiting for a response can wake up
> and send a new packet before the bit lock is cleared. This results in
> needlessly dropping some Tx timestamp requests.
>
> We can fix this by unlocking the state bit as soon as we read the
> Timestamp register, as this is the first point at which it is safe to
> unlock.
>
> To avoid issues with the skb pointer, we'll use a copy of the pointer
> and set the global variable in the driver structure to NULL first. This
> ensures that the next timestamp request does not modify our local copy
> of the skb pointer.
>
> This ensures that well behaved applications do not accidentally race
> with the unlock bit. Obviously an application which sends multiple Tx
> timestamp requests at once will still only timestamp one packet at
> a time. Unfortunately there is nothing we can do about this.
>
> Since the fix is almost the same for each driver, this patch combines
> the fixes for e1000e, igb, ixgbe and i40e.
>
> Reported-by: David Mirabito <davidm@metamako.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/e1000e/netdev.c   | 10 ++++++++--
>  drivers/net/ethernet/intel/i40e/i40e_ptp.c   | 14 +++++++++++---
>  drivers/net/ethernet/intel/igb/igb_ptp.c     | 12 ++++++++++--
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c | 15 ++++++++++++---
>  4 files changed, 41 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c
> b/drivers/net/ethernet/intel/e1000e/netdev.c
> index b3679728caac..ec9a50a72550 100644
> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> @@ -1183,6 +1183,7 @@ static void e1000e_tx_hwtstamp_work(struct
> work_struct *work)
>         struct e1000_hw *hw = &adapter->hw;
>
>         if (er32(TSYNCTXCTL) & E1000_TSYNCTXCTL_VALID) {
> +               struct sk_buff *skb = adapter->tx_hwtstamp_skb;
>                 struct skb_shared_hwtstamps shhwtstamps;
>                 u64 txstmp;
>
> @@ -1191,9 +1192,14 @@ static void e1000e_tx_hwtstamp_work(struct
> work_struct *work)
>
>                 e1000e_systim_to_hwtstamp(adapter, &shhwtstamps, txstmp);
>
> -               skb_tstamp_tx(adapter->tx_hwtstamp_skb, &shhwtstamps);
> -               dev_kfree_skb_any(adapter->tx_hwtstamp_skb);
> +               /* Clear the global tx_hwtstamp_skb pointer and force
> writes
> +                * prior to notifying the stack of a Tx timestamp.
> +                */
>                 adapter->tx_hwtstamp_skb = NULL;
> +               wmb(); /* force write prior to skb_tstamp_tx */
> +
> +               skb_tstamp_tx(skb, &shhwtstamps);
> +               dev_kfree_skb_any(skb);
>         } else if (time_after(jiffies, adapter->tx_hwtstamp_start
>                               + adapter->tx_timeout_factor * HZ)) {
>                 dev_kfree_skb_any(adapter->tx_hwtstamp_skb);
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> index 18c1cc08da97..5a4854e9fd29 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_ptp.c
> @@ -338,6 +338,7 @@ void i40e_ptp_rx_hang(struct i40e_vsi *vsi)
>  void i40e_ptp_tx_hwtstamp(struct i40e_pf *pf)
>  {
>         struct skb_shared_hwtstamps shhwtstamps;
> +       struct sk_buff *skb = pf->ptp_tx_skb;
>         struct i40e_hw *hw = &pf->hw;
>         u32 hi, lo;
>         u64 ns;
> @@ -353,12 +354,19 @@ void i40e_ptp_tx_hwtstamp(struct i40e_pf *pf)
>         hi = rd32(hw, I40E_PRTTSYN_TXTIME_H);
>
>         ns = (((u64)hi) << 32) | lo;
> -
>         i40e_ptp_convert_to_hwtstamp(&shhwtstamps, ns);
> -       skb_tstamp_tx(pf->ptp_tx_skb, &shhwtstamps);
> -       dev_kfree_skb_any(pf->ptp_tx_skb);
> +
> +       /* Clear the bit lock as soon as possible after reading the
> register,
> +        * and prior to notifying the stack via skb_tstamp_tx(). Otherwise
> +        * applications might wake up and attempt to request another
> transmit
> +        * timestamp prior to the bit lock being cleared.
> +        */
>         pf->ptp_tx_skb = NULL;
>         clear_bit_unlock(__I40E_PTP_TX_IN_PROGRESS, pf->state);
> +
> +       /* Notify the stack and free the skb after we've unlocked */
> +       skb_tstamp_tx(skb, &shhwtstamps);
> +       dev_kfree_skb_any(skb);
>  }
>
>  /**
> diff --git a/drivers/net/ethernet/intel/igb/igb_ptp.c
> b/drivers/net/ethernet/intel/igb/igb_ptp.c
> index 7a3fd4d74592..a2da5738bfb5 100644
> --- a/drivers/net/ethernet/intel/igb/igb_ptp.c
> +++ b/drivers/net/ethernet/intel/igb/igb_ptp.c
> @@ -721,6 +721,7 @@ void igb_ptp_rx_hang(struct igb_adapter *adapter)
>   **/
>  static void igb_ptp_tx_hwtstamp(struct igb_adapter *adapter)
>  {
> +       struct sk_buff *skb = adapter->ptp_tx_skb;
>         struct e1000_hw *hw = &adapter->hw;
>         struct skb_shared_hwtstamps shhwtstamps;
>         u64 regval;
> @@ -748,10 +749,17 @@ static void igb_ptp_tx_hwtstamp(struct igb_adapter
> *adapter)
>         shhwtstamps.hwtstamp =
>                 ktime_add_ns(shhwtstamps.hwtstamp, adjust);
>
> -       skb_tstamp_tx(adapter->ptp_tx_skb, &shhwtstamps);
> -       dev_kfree_skb_any(adapter->ptp_tx_skb);
> +       /* Clear the lock early before calling skb_tstamp_tx so that
> +        * applications are not woken up before the lock bit is clear. We
> use
> +        * a copy of the skb pointer to ensure other threads can't change
> it
> +        * while we're notifying the stack.
> +        */
>         adapter->ptp_tx_skb = NULL;
>         clear_bit_unlock(__IGB_PTP_TX_IN_PROGRESS, &adapter->state);
> +
> +       /* Notify the stack and free the skb after we've unlocked */
> +       skb_tstamp_tx(skb, &shhwtstamps);
> +       dev_kfree_skb_any(skb);
>  }
>
>  /**
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
> b/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
> index ef0635e0918c..9270e6f4fcff 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ptp.c
> @@ -672,17 +672,26 @@ static void ixgbe_ptp_clear_tx_timestamp(struct
> ixgbe_adapter *adapter)
>   */
>  static void ixgbe_ptp_tx_hwtstamp(struct ixgbe_adapter *adapter)
>  {
> +       struct sk_buff *skb = adapter->ptp_tx_skb;
>         struct ixgbe_hw *hw = &adapter->hw;
>         struct skb_shared_hwtstamps shhwtstamps;
>         u64 regval = 0;
>
>         regval |= (u64)IXGBE_READ_REG(hw, IXGBE_TXSTMPL);
>         regval |= (u64)IXGBE_READ_REG(hw, IXGBE_TXSTMPH) << 32;
> -
>         ixgbe_ptp_convert_to_hwtstamp(adapter, &shhwtstamps, regval);
> -       skb_tstamp_tx(adapter->ptp_tx_skb, &shhwtstamps);
>
> -       ixgbe_ptp_clear_tx_timestamp(adapter);
> +       /* Handle cleanup of the ptp_tx_skb ourselves, and unlock the state
> +        * bit prior to notifying the stack via skb_tstamp_tx(). This
> prevents
> +        * well behaved applications from attempting to timestamp again
> prior
> +        * to the lock bit being clear.
> +        */
> +       adapter->ptp_tx_skb = NULL;
> +       clear_bit_unlock(__IXGBE_PTP_TX_IN_PROGRESS, &adapter->state);
> +
> +       /* Notify the stack and then free the skb after we've unlocked */
> +       skb_tstamp_tx(skb, &shhwtstamps);
> +       dev_kfree_skb_any(skb);
>  }
>
>  /**
> --
> 2.13.0.rc0.317.gcc792a6cad5a
>
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20170428/edb338ac/attachment-0001.html>
