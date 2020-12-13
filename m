From: kernel test robot <lkp@intel.com>
Date: Mon, 14 Dec 2020 01:56:00 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue 43/112]
 drivers/net/ethernet/intel/igc/igc_ptp.c:181:18: sparse: sparse: cast to
 restricted __le32
Message-ID: <202012140156.fDnw9BiR-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
head:   49dd24e929ffd092788636429902443068bf9ebc
commit: 43483dcb31045ba36ac703314ca664429e339a95 [43/112] igc: Fix igc_ptp_rx_pktstamp()
config: parisc-randconfig-s032-20201213 (attached as .config)
compiler: hppa-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.3-184-g1b896707-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git/commit/?id=43483dcb31045ba36ac703314ca664429e339a95
        git remote add tnguy-next-queue https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git
        git fetch --no-tags tnguy-next-queue dev-queue
        git checkout 43483dcb31045ba36ac703314ca664429e339a95
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=parisc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


"sparse warnings: (new ones prefixed by >>)"
>> drivers/net/ethernet/intel/igc/igc_ptp.c:181:18: sparse: sparse: cast to restricted __le32
>> drivers/net/ethernet/intel/igc/igc_ptp.c:181:18: sparse: sparse: cast to restricted __le32
>> drivers/net/ethernet/intel/igc/igc_ptp.c:181:18: sparse: sparse: cast to restricted __le32
>> drivers/net/ethernet/intel/igc/igc_ptp.c:181:18: sparse: sparse: cast to restricted __le32
>> drivers/net/ethernet/intel/igc/igc_ptp.c:181:18: sparse: sparse: cast to restricted __le32
>> drivers/net/ethernet/intel/igc/igc_ptp.c:181:18: sparse: sparse: cast to restricted __le32
   drivers/net/ethernet/intel/igc/igc_ptp.c:182:24: sparse: sparse: cast to restricted __le32
   drivers/net/ethernet/intel/igc/igc_ptp.c:182:24: sparse: sparse: cast to restricted __le32
   drivers/net/ethernet/intel/igc/igc_ptp.c:182:24: sparse: sparse: cast to restricted __le32
   drivers/net/ethernet/intel/igc/igc_ptp.c:182:24: sparse: sparse: cast to restricted __le32
   drivers/net/ethernet/intel/igc/igc_ptp.c:182:24: sparse: sparse: cast to restricted __le32
   drivers/net/ethernet/intel/igc/igc_ptp.c:182:24: sparse: sparse: cast to restricted __le32

vim +181 drivers/net/ethernet/intel/igc/igc_ptp.c

   153	
   154	/**
   155	 * igc_ptp_rx_pktstamp - Retrieve timestamp from Rx packet buffer
   156	 * @q_vector: Pointer to interrupt specific structure
   157	 * @va: Pointer to address containing Rx buffer
   158	 * @skb: Buffer containing timestamp and packet
   159	 *
   160	 * This function retrieves the timestamp saved in the beginning of packet
   161	 * buffer. While two timestamps are available, one in timer0 reference and the
   162	 * other in timer1 reference, this function considers only the timestamp in
   163	 * timer0 reference.
   164	 */
   165	void igc_ptp_rx_pktstamp(struct igc_q_vector *q_vector, u32 *va,
   166				 struct sk_buff *skb)
   167	{
   168		struct igc_adapter *adapter = q_vector->adapter;
   169		u64 regval;
   170		int adjust;
   171	
   172		/* Timestamps are saved in little endian at the beginning of the packet
   173		 * buffer following the layout:
   174		 *
   175		 * DWORD: | 0              | 1              | 2              | 3              |
   176		 * Field: | Timer1 SYSTIML | Timer1 SYSTIMH | Timer0 SYSTIML | Timer0 SYSTIMH |
   177		 *
   178		 * SYSTIML holds the nanoseconds part while SYSTIMH holds the seconds
   179		 * part of the timestamp.
   180		 */
 > 181		regval = le32_to_cpu(va[2]);
   182		regval |= (u64)le32_to_cpu(va[3]) << 32;
   183		igc_ptp_systim_to_hwtstamp(adapter, skb_hwtstamps(skb), regval);
   184	
   185		/* Adjust timestamp for the RX latency based on link speed */
   186		switch (adapter->link_speed) {
   187		case SPEED_10:
   188			adjust = IGC_I225_RX_LATENCY_10;
   189			break;
   190		case SPEED_100:
   191			adjust = IGC_I225_RX_LATENCY_100;
   192			break;
   193		case SPEED_1000:
   194			adjust = IGC_I225_RX_LATENCY_1000;
   195			break;
   196		case SPEED_2500:
   197			adjust = IGC_I225_RX_LATENCY_2500;
   198			break;
   199		default:
   200			adjust = 0;
   201			netdev_warn_once(adapter->netdev, "Imprecise timestamp\n");
   202			break;
   203		}
   204		skb_hwtstamps(skb)->hwtstamp =
   205			ktime_sub_ns(skb_hwtstamps(skb)->hwtstamp, adjust);
   206	}
   207	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 32142 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20201214/63123705/attachment-0001.bin>
