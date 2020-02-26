From: kbuild test robot <lkp@intel.com>
Date: Wed, 26 Feb 2020 10:05:29 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 3/25]
 drivers/net//ethernet/intel/igc/igc_ptp.c:644:13: error: static declaration
 of 'igc_ptp_suspend' follows non-static declaration
Message-ID: <202002261027.nfOGLWJN%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   1ac51cb8d4ed5a4f95d601bc92a4e9c2aa904244
commit: 95c6b55fdfbda5b52e8fb0104368e8f7b3ad0e27 [3/25] igc: make non-global functions static
config: i386-allyesconfig (attached as .config)
compiler: gcc-7 (Debian 7.5.0-5) 7.5.0
reproduce:
        git checkout 95c6b55fdfbda5b52e8fb0104368e8f7b3ad0e27
        # save the attached .config to linux build tree
        make ARCH=i386 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

Note: the jkirsher-next-queue/dev-queue HEAD 1ac51cb8d4ed5a4f95d601bc92a4e9c2aa904244 builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

>> drivers/net//ethernet/intel/igc/igc_ptp.c:644:13: error: static declaration of 'igc_ptp_suspend' follows non-static declaration
    static void igc_ptp_suspend(struct igc_adapter *adapter)
                ^~~~~~~~~~~~~~~
   In file included from drivers/net//ethernet/intel/igc/igc_ptp.c:4:0:
   drivers/net//ethernet/intel/igc/igc.h:562:6: note: previous declaration of 'igc_ptp_suspend' was here
    void igc_ptp_suspend(struct igc_adapter *adapter);
         ^~~~~~~~~~~~~~~

vim +/igc_ptp_suspend +644 drivers/net//ethernet/intel/igc/igc_ptp.c

   636	
   637	/**
   638	 * igc_ptp_suspend - Disable PTP work items and prepare for suspend
   639	 * @adapter: Board private structure
   640	 *
   641	 * This function stops the overflow check work and PTP Tx timestamp work, and
   642	 * will prepare the device for OS suspend.
   643	 */
 > 644	static void igc_ptp_suspend(struct igc_adapter *adapter)
   645	{
   646		if (!(adapter->ptp_flags & IGC_PTP_ENABLED))
   647			return;
   648	
   649		cancel_work_sync(&adapter->ptp_tx_work);
   650		if (adapter->ptp_tx_skb) {
   651			dev_kfree_skb_any(adapter->ptp_tx_skb);
   652			adapter->ptp_tx_skb = NULL;
   653			clear_bit_unlock(__IGC_PTP_TX_IN_PROGRESS, &adapter->state);
   654		}
   655	}
   656	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 71482 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20200226/3a70f2d0/attachment-0001.bin>
