From: kbuild test robot <lkp@intel.com>
Date: Sat, 16 Jul 2016 06:55:39 +0800
Subject: [Intel-wired-lan] [PATCH] igb: fix adjusting ptp timestamps for
	tx/rx latency
In-Reply-To: <1468620496-7849-1-git-send-email-kshitiz.gupta@ni.com>
Message-ID: <201607160644.Q6MtmLkD%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,

[auto build test ERROR on jkirsher-next-queue/dev-queue]
[also build test ERROR on v4.7-rc7 next-20160715]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Kshitiz-Gupta/igb-fix-adjusting-ptp-timestamps-for-tx-rx-latency/20160716-062544
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
config: sparc64-allyesconfig (attached as .config)
compiler: sparc64-linux-gnu-gcc (Debian 5.3.1-8) 5.3.1 20160205
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=sparc64 

All errors (new ones prefixed by >>):

   drivers/net/ethernet/intel/igb/igb_ptp.c: In function 'igb_ptp_rx_pktstamp':
>> drivers/net/ethernet/intel/igb/igb_ptp.c:783:12: error: 'IGB_RX_LATENCY_10' undeclared (first use in this function)
      adjust = IGB_RX_LATENCY_10;
               ^
   drivers/net/ethernet/intel/igb/igb_ptp.c:783:12: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/net/ethernet/intel/igb/igb_ptp.c:786:12: error: 'IGB_RX_LATENCY_100' undeclared (first use in this function)
      adjust = IGB_RX_LATENCY_100;
               ^
>> drivers/net/ethernet/intel/igb/igb_ptp.c:789:12: error: 'IGB_RX_LATENCY_1000' undeclared (first use in this function)
      adjust = IGB_RX_LATENCY_1000;
               ^

vim +/IGB_RX_LATENCY_10 +783 drivers/net/ethernet/intel/igb/igb_ptp.c

   777		igb_ptp_systim_to_hwtstamp(adapter, skb_hwtstamps(skb),
   778					   le64_to_cpu(regval[1]));
   779	
   780		/* adjust timestamp for the RX latency based on link speed */
   781		switch (adapter->link_speed) {
   782		case SPEED_10:
 > 783			adjust = IGB_RX_LATENCY_10;
   784			break;
   785		case SPEED_100:
 > 786			adjust = IGB_RX_LATENCY_100;
   787			break;
   788		case SPEED_1000:
 > 789			adjust = IGB_RX_LATENCY_1000;
   790			break;
   791		}
   792		skb_hwtstamps(skb)->hwtstamp =

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 46471 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160716/2d523105/attachment-0001.obj>
