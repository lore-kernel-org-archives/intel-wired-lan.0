From: kernel test robot <lkp@intel.com>
Date: Fri, 13 Nov 2020 13:58:51 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue 73/96]
 drivers/net/ethernet/intel/igc/igc_ptp.c:183:18: sparse: sparse: cast to
 restricted __le32
Message-ID: <202011131348.852qYDiM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
head:   3f69b6741396fada730c8a1ccc0bfa8c771b9dab
commit: 44f0d25c501202f999773c94ee0a11d7e7376b76 [73/96] igc: Fix igc_ptp_rx_pktstamp()
config: i386-randconfig-s002-20201113 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.3-107-gaf3512a6-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git/commit/?id=44f0d25c501202f999773c94ee0a11d7e7376b76
        git remote add tnguy-next-queue https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git
        git fetch --no-tags tnguy-next-queue dev-queue
        git checkout 44f0d25c501202f999773c94ee0a11d7e7376b76
        # save the attached .config to linux build tree
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=i386 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


"sparse warnings: (new ones prefixed by >>)"
>> drivers/net/ethernet/intel/igc/igc_ptp.c:183:18: sparse: sparse: cast to restricted __le32
   drivers/net/ethernet/intel/igc/igc_ptp.c:184:24: sparse: sparse: cast to restricted __le32
   drivers/net/ethernet/intel/igc/igc_ptp.c:458:21: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/intel/igc/igc_ptp.c:458:21: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/intel/igc/igc_ptp.c:458:21: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/intel/igc/igc_ptp.c:458:21: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/intel/igc/igc_ptp.c:458:21: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/intel/igc/igc_ptp.c:458:21: sparse: sparse: cast to restricted __be32

vim +183 drivers/net/ethernet/intel/igc/igc_ptp.c

   155	
   156	/**
   157	 * igc_ptp_rx_pktstamp - Retrieve timestamp from Rx packet buffer
   158	 * @q_vector: Pointer to interrupt specific structure
   159	 * @va: Pointer to address containing Rx buffer
   160	 * @skb: Buffer containing timestamp and packet
   161	 *
   162	 * This function retrieves the timestamp saved in the beginning of packet
   163	 * buffer. While two timestamps are available, one in timer0 reference and the
   164	 * other in timer1 reference, this function considers only the timestamp in
   165	 * timer0 reference.
   166	 */
   167	void igc_ptp_rx_pktstamp(struct igc_q_vector *q_vector, u32 *va,
   168				 struct sk_buff *skb)
   169	{
   170		struct igc_adapter *adapter = q_vector->adapter;
   171		u64 regval;
   172		int adjust;
   173	
   174		/* Timestamps are saved in little endian at the beginning of the packet
   175		 * buffer following the layout:
   176		 *
   177		 * DWORD: | 0              | 1              | 2              | 3              |
   178		 * Field: | Timer1 SYSTIML | Timer1 SYSTIMH | Timer0 SYSTIML | Timer0 SYSTIMH |
   179		 *
   180		 * SYSTIML holds the nanoseconds part while SYSTIMH holds the seconds
   181		 * part of the timestamp.
   182		 */
 > 183		regval = le32_to_cpu(va[2]);
   184		regval |= (u64)le32_to_cpu(va[3]) << 32;
   185		igc_ptp_systim_to_hwtstamp(adapter, skb_hwtstamps(skb), regval);
   186	
   187		/* Adjust timestamp for the RX latency based on link speed */
   188		switch (adapter->link_speed) {
   189		case SPEED_10:
   190			adjust = IGC_I225_RX_LATENCY_10;
   191			break;
   192		case SPEED_100:
   193			adjust = IGC_I225_RX_LATENCY_100;
   194			break;
   195		case SPEED_1000:
   196			adjust = IGC_I225_RX_LATENCY_1000;
   197			break;
   198		case SPEED_2500:
   199			adjust = IGC_I225_RX_LATENCY_2500;
   200			break;
   201		default:
   202			adjust = 0;
   203			netdev_warn_once(adapter->netdev, "Imprecise timestamp\n");
   204			break;
   205		}
   206		skb_hwtstamps(skb)->hwtstamp =
   207			ktime_sub_ns(skb_hwtstamps(skb)->hwtstamp, adjust);
   208	}
   209	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 41744 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20201113/4d24ba52/attachment-0001.bin>
