From: kbuild test robot <lkp@intel.com>
Date: Tue, 26 Jul 2016 17:50:27 +0800
Subject: [Intel-wired-lan] [PATCH] schedule function called for e1000
	driver interrupt
In-Reply-To: <20160726093224.GA10339@wfg-t540p.sh.intel.com>
Message-ID: <201607261755.mFYPrzbr%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,

[auto build test ERROR on jkirsher-next-queue/dev-queue]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Fengguang-Wu/schedule-function-called-for-e1000-driver-interrupt/20160726-173521
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
config: sparc64-allyesconfig (attached as .config)
compiler: sparc64-linux-gnu-gcc (Debian 5.4.0-6) 5.4.0 20160609
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=sparc64 

All errors (new ones prefixed by >>):

   drivers/net/ethernet/intel/e1000/e1000_main.c: In function 'e1000_intr':
>> drivers/net/ethernet/intel/e1000/e1000_main.c:3800:22: error: 'struct e1000_adapter' has no member named 'watchdog_timer'
       mod_timer(&adapter->watchdog_timer, jiffies + 1);
                         ^

vim +3800 drivers/net/ethernet/intel/e1000/e1000_main.c

  3794			return IRQ_HANDLED;
  3795	
  3796		if (unlikely(icr & (E1000_ICR_RXSEQ | E1000_ICR_LSC))) {
  3797			hw->get_link_status = 1;
  3798			/* guard against interrupt when we're going down */
  3799			if (!test_bit(__E1000_DOWN, &adapter->flags))
> 3800				mod_timer(&adapter->watchdog_timer, jiffies + 1);
  3801		}
  3802	
  3803		/* disable interrupts, without the synchronize_irq bit */

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 46493 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160726/9e871338/attachment-0001.obj>
