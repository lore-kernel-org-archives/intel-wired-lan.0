From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 7 Sep 2016 18:47:35 -0700
Subject: [Intel-wired-lan] Dear Wired Lan Experts,
 kindly offer your guidance on customer's input please
In-Reply-To: <5D695A7F6F10504DBD9B9187395A21797E8F7782@ORSMSX112.amr.corp.intel.com>
References: <5D695A7F6F10504DBD9B9187395A21797E8F7782@ORSMSX112.amr.corp.intel.com>
Message-ID: <CAKgT0Uc6PWozUeXdC3NXGSNxy_E107uH6k0uRMf=eq=901mHpA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Sep 7, 2016 at 9:12 AM, Jayakumar, Muthurajan
<muthurajan.jayakumar@intel.com> wrote:
>
>
>
>
> Dear Wired Lan Experts,
>
> kindly offer your guidance on following customer's input below please
>
> Much appreciated.
>
>
>
> Best Regards,
>
> M Jay
>
>
>
>
>
>
>
> In the ixgbe driver (82599EB/X540/X550/X550EM_x), if RSS < 4 and we allocate
> VFs, the driver forces to use 2-queue (per VF) mode instead of 4-queue mode
> (see ixgbe_set_vmdq_queues function in ixgbe_lib.c)
> Is there any fundamental reason to do so? Is it possible to still use
> 4-queue mode (per VF) even when RSS=1 (i.e., a physical function uses only 1
> TX/RX queue but all VFs use 4 TX/RX queues)
>
> The proposed change to use 4-queue mode is as follows (please double check
> if anything else needs to be changed):
>
> diff -urN src/ixgbe_lib.c src_new/ixgbe_lib.c
> --- src/ixgbe_lib.c     2016-07-12 13:11:56.976425563 -0700
> +++ src_new/ixgbe_lib.c 2016-07-12 13:12:55.540425563 -0700
> @@ -582,7 +582,7 @@
>                 vmdq_i = min_t(u16, IXGBE_MAX_VMDQ_INDICES, vmdq_i);
>
>                 /* 64 pool mode with 2 queues per pool */
> -               if ((vmdq_i > 32) || (rss_i < 4)) {
> +               if (vmdq_i > 32) {
>                         vmdq_m = IXGBE_82599_VMDQ_2Q_MASK;
>                         rss_m = IXGBE_RSS_2Q_MASK;
>                         rss_i = min_t(u16, rss_i, 2);


This change is bogus and provides no value.  The reason why we cap
things with the rss_i < 4 check is because if rss_i is 3 then the VFs
wouldn't be able to access the 4th queue because the redirection table
will have no value 4.  There isn't much point in enabling 4 queues on
the VF if it cannot access them all.

> @@ -590,7 +590,7 @@
>                 } else {
>                         vmdq_m = IXGBE_82599_VMDQ_4Q_MASK;
>                         rss_m = IXGBE_RSS_4Q_MASK;
> -                       rss_i = 4;
> +                       rss_i = min_t(u16, rss_i, 4);
>                 }
>

This change would only make sense if the the first change was valid
which it isn't.  It isn't worth it to allocate 4 queues per VF if they
can only access 3 because the PF hasn't populated the entries in the
redirection table.

>  #if IS_ENABLED(CONFIG_FCOE)
> diff -urN src/ixgbe_main.c src_new/ixgbe_main.c
> --- src/ixgbe_main.c    2016-07-12 13:11:56.980425563 -0700
> +++ src_new/ixgbe_main.c        2016-07-12 13:12:55.544425563 -0700
> @@ -2883,7 +2883,7 @@
>                         mtqc |= IXGBE_MTQC_RT_ENA | IXGBE_MTQC_8TC_8TQ;
>                 else if (tcs > 1)
>                         mtqc |= IXGBE_MTQC_RT_ENA | IXGBE_MTQC_4TC_4TQ;
> -               else if (adapter->ring_feature[RING_F_RSS].indices == 4)
> +               else if (adapter->ring_feature[RING_F_VMDQ].mask ==
> IXGBE_82599_VMDQ_4Q_MASK)
>                         mtqc |= IXGBE_MTQC_32VF;
>                 else
>                         mtqc |= IXGBE_MTQC_64VF;
> @@ -3186,13 +3186,12 @@
>                         mrqc = IXGBE_MRQC_RSSEN;
>         } else {
>                 u8 tcs = netdev_get_num_tc(adapter->netdev);
> -
>                 if (adapter->flags & IXGBE_FLAG_VMDQ_ENABLED) {
>                         if (tcs > 4)
>                                 mrqc = IXGBE_MRQC_VMDQRT8TCEN;  /* 8 TCs */
>                         else if (tcs > 1)
>                                 mrqc = IXGBE_MRQC_VMDQRT4TCEN;  /* 4 TCs */
> -                       else if (adapter->ring_feature[RING_F_RSS].indices
> == 4)
> +                       else if (adapter->ring_feature[RING_F_VMDQ].mask ==
> IXGBE_82599_VMDQ_4Q_MASK)
>                                 mrqc = IXGBE_MRQC_VMDQRSS32EN;
>                         else
>                                 mrqc = IXGBE_MRQC_VMDQRSS64EN;

This piece is valid.  You might consider submitting it as a separate
patch if you would like.  All it is really changing though is what
piece we are checking to determine if we have 4 queues per pool.

As far as enabling 4 queues in the VF it isn't very hard as long as
the PF is configured to use 4 queues.  There are really only 3 changes
needed.  I briefly tested the patch below and verified I can run 4
queues of RSS using a netperf TCP_CRR test.  I'm sure it is going to
get white space mangled by my mail client, but this should give you
the general idea.

Author: Alexander Duyck <alexander.h.duyck@intel.com>
Date:   Wed Sep 7 18:25:26 2016 -0700

    ixgbevf: Add support for 4 queue RSS

    Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>

diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
index 7eaac3234049..0a36b6e37298 100644
--- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
@@ -1655,6 +1655,8 @@ static void ixgbevf_setup_psrtype(struct
ixgbevf_adapter *adapter)
                      IXGBE_PSRTYPE_IPV4HDR | IXGBE_PSRTYPE_IPV6HDR |
                      IXGBE_PSRTYPE_L2HDR;

+       if (adapter->num_rx_queues > 3)
+               psrtype |= BIT(30);
        if (adapter->num_rx_queues > 1)
                psrtype |= BIT(29);

@@ -2000,6 +2002,12 @@ static int ixgbevf_configure_dcb(struct
ixgbevf_adapter *adapter)

                /* we need as many queues as traffic classes */
                num_rx_queues = num_tcs;
+       } else {
+               /* clamp RSS to no more than maximum queues */
+               if (num_tx_queues > hw->mac.max_tx_queues)
+                       num_tx_queues = hw->mac.max_tx_queues;
+               if (num_rx_queues > hw->mac.max_rx_queues)
+                       num_rx_queues = hw->mac.max_rx_queues;
        }

        /* if we have a bad config abort request queue reset */
@@ -2365,7 +2373,7 @@ static void ixgbevf_set_num_queues(struct
ixgbevf_adapter *adapter)
        if (num_tcs > 1) {
                adapter->num_rx_queues = num_tcs;
        } else {
-               u16 rss = min_t(u16, num_online_cpus(), IXGBEVF_MAX_RSS_QUEUES);
+               u16 rss = min_t(u16, num_online_cpus(), hw->mac.max_rx_queues);

                switch (hw->api_version) {
                case ixgbe_mbox_api_11:
