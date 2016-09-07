From: Skidmore, Donald C <donald.c.skidmore@intel.com>
Date: Wed, 7 Sep 2016 18:29:35 +0000
Subject: [Intel-wired-lan] Dear Wired Lan Experts,
 kindly offer your guidance on customer's input please
In-Reply-To: <5D695A7F6F10504DBD9B9187395A21797E8F7782@ORSMSX112.amr.corp.intel.com>
References: <5D695A7F6F10504DBD9B9187395A21797E8F7782@ORSMSX112.amr.corp.intel.com>
Message-ID: <F6FB0E698C9B3143BDF729DF2228664696AE7E3B@ORSMSX116.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

The limitation is due to interrupts limits of a VF.  We only get four and since with two queues we need 3 interrupts (1 per queue and 1 for LSC among other events) we don't have enough to support a 4 queues VF and sharing interrupt would eliminate the advantages of the additional queues.  :(

Thanks,
-Don <donald.c.skidmore@intel.com>

From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Jayakumar, Muthurajan
Sent: Wednesday, September 07, 2016 9:13 AM
To: intel-wired-lan@lists.osuosl.org; Blevins, Christopher R <christopher.r.blevins@intel.com>
Subject: [Intel-wired-lan] Dear Wired Lan Experts, kindly offer your guidance on customer's input please



Dear Wired Lan Experts,
kindly offer your guidance on following customer's input below please
Much appreciated.

Best Regards,
M Jay



In the ixgbe driver (82599EB/X540/X550/X550EM_x), if RSS < 4 and we allocate VFs, the driver forces to use 2-queue (per VF) mode instead of 4-queue mode (see ixgbe_set_vmdq_queues function in ixgbe_lib.c)
Is there any fundamental reason to do so? Is it possible to still use 4-queue mode (per VF) even when RSS=1 (i.e., a physical function uses only 1 TX/RX queue but all VFs use 4 TX/RX queues)

The proposed change to use 4-queue mode is as follows (please double check if anything else needs to be changed):

diff -urN src/ixgbe_lib.c src_new/ixgbe_lib.c
--- src/ixgbe_lib.c     2016-07-12 13:11:56.976425563 -0700
+++ src_new/ixgbe_lib.c 2016-07-12 13:12:55.540425563 -0700
@@ -582,7 +582,7 @@
                vmdq_i = min_t(u16, IXGBE_MAX_VMDQ_INDICES, vmdq_i);

                /* 64 pool mode with 2 queues per pool */
-               if ((vmdq_i > 32) || (rss_i < 4)) {
+               if (vmdq_i > 32) {
                        vmdq_m = IXGBE_82599_VMDQ_2Q_MASK;
                        rss_m = IXGBE_RSS_2Q_MASK;
                        rss_i = min_t(u16, rss_i, 2);
@@ -590,7 +590,7 @@
                } else {
                        vmdq_m = IXGBE_82599_VMDQ_4Q_MASK;
                        rss_m = IXGBE_RSS_4Q_MASK;
-                       rss_i = 4;
+                       rss_i = min_t(u16, rss_i, 4);
                }

 #if IS_ENABLED(CONFIG_FCOE)
diff -urN src/ixgbe_main.c src_new/ixgbe_main.c
--- src/ixgbe_main.c    2016-07-12 13:11:56.980425563 -0700
+++ src_new/ixgbe_main.c        2016-07-12 13:12:55.544425563 -0700
@@ -2883,7 +2883,7 @@
                        mtqc |= IXGBE_MTQC_RT_ENA | IXGBE_MTQC_8TC_8TQ;
                else if (tcs > 1)
                        mtqc |= IXGBE_MTQC_RT_ENA | IXGBE_MTQC_4TC_4TQ;
-               else if (adapter->ring_feature[RING_F_RSS].indices == 4)
+               else if (adapter->ring_feature[RING_F_VMDQ].mask == IXGBE_82599_VMDQ_4Q_MASK)
                        mtqc |= IXGBE_MTQC_32VF;
                else
                        mtqc |= IXGBE_MTQC_64VF;
@@ -3186,13 +3186,12 @@
                        mrqc = IXGBE_MRQC_RSSEN;
        } else {
                u8 tcs = netdev_get_num_tc(adapter->netdev);
-
                if (adapter->flags & IXGBE_FLAG_VMDQ_ENABLED) {
                        if (tcs > 4)
                                mrqc = IXGBE_MRQC_VMDQRT8TCEN;  /* 8 TCs */
                        else if (tcs > 1)
                                mrqc = IXGBE_MRQC_VMDQRT4TCEN;  /* 4 TCs */
-                       else if (adapter->ring_feature[RING_F_RSS].indices == 4)
+                       else if (adapter->ring_feature[RING_F_VMDQ].mask == IXGBE_82599_VMDQ_4Q_MASK)
                                mrqc = IXGBE_MRQC_VMDQRSS32EN;
                        else
                                mrqc = IXGBE_MRQC_VMDQRSS64EN;
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160907/dafab3a4/attachment-0001.html>
