From: Tantilov, Emil S <emil.s.tantilov@intel.com>
Date: Wed, 24 Jun 2015 19:38:19 +0000
Subject: [Intel-wired-lan] [PATCH net-next] ixgbe support for
	ethtool	set_rxfh
In-Reply-To: <CAO1kT88R2wqLsjrvzS2gfa69vm2Z0V0ZvTSpoOU2S8PX0M5Lrg@mail.gmail.com>
References: <CAO1kT88R2wqLsjrvzS2gfa69vm2Z0V0ZvTSpoOU2S8PX0M5Lrg@mail.gmail.com>
Message-ID: <87618083B2453E4A8714035B62D679925033243A@FMSMSX105.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

>-----Original Message-----
>From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
>Behalf Of Tom Barbette
>Sent: Wednesday, June 24, 2015 6:45 AM
To: intel-wired-lan@lists.osuosl.org
>Subject: [Intel-wired-lan] [PATCH net-next] ixgbe support for ethtool
>set_rxfh
>
>Allows to change the rxfh indirection table and/or key using ethtool interface
>
>Signed-off-by: Tom Barbette <tom.barbette@ulg.ac.be>
>---
> drivers/net/ethernet/intel/ixgbe/ixgbe.h         |  1 +
> drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c | 40
>++++++++++++++++++++++++
> drivers/net/ethernet/intel/ixgbe/ixgbe_main.c    |  2 +-
> 3 files changed, 42 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
>b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
>index ac3ac2a..4314799 100644
>--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
>+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
>@@ -967,4 +967,5 @@ netdev_tx_t ixgbe_xmit_frame_ring(struct sk_buff *skb,
>   struct ixgbe_adapter *adapter,
>   struct ixgbe_ring *tx_ring);
> u32 ixgbe_rss_indir_tbl_entries(struct ixgbe_adapter *adapter);
>+void ixgbe_store_reta(struct ixgbe_adapter *adapter);
> #endif /* _IXGBE_H_ */
>diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
>b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
>index ec7b232..1d373b9 100644
>--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
>+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
>@@ -2907,6 +2907,45 @@ static int ixgbe_get_rxfh(struct net_device
>*netdev, u32 *indir, u8 *key,
>  return 0;
> }
Above lines are messed up somehow which will prevent the patch from applying. 

>
>+static int ixgbe_set_rxfh(struct net_device *netdev, const u32 *indir,
>+                        const u8 *key, const u8 hfunc)
>+{
>+        struct ixgbe_adapter *adapter = netdev_priv(netdev);
>+ u32 reta_entries = ixgbe_rss_indir_tbl_entries(adapter);
>+        int i;
>+ u32 num_queues;
>+
>+ num_queues = adapter->num_rx_queues;
>+
>+ /*
>+ * Allow at least 2 queues w/ SR-IOV.
>+ */
>+ if ((adapter->flags & IXGBE_FLAG_SRIOV_ENABLED) && (num_queues < 2))
>+ num_queues = 2;
>+
>+ if (hfunc)
>+ return -EINVAL;
>+
>+ /* Fill out the redirection table */
>+ if (indir) {
>+        /* Verify user input. */
>+        for (i = 0; i < reta_entries; i++)
>+        if (indir[i] >= num_queues)
>+                return -EINVAL;

The indirection table (see RETA register) is limited to 16 queues, 64 for X550.

Thanks,
Emil

