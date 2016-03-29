From: kbuild test robot <fengguang.wu@intel.com>
Date: Tue, 29 Mar 2016 12:35:54 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 111/114]
 drivers/net/ethernet/intel/i40e/i40e_fcoe.c:44:20: error: redefinition of
 'i40e_rx_is_fcoe'
Message-ID: <201603291252.HnZDqxDA%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   e4210bf78a6110de77b5281610f188822f9e18d7
commit: 5f2e631c3e71c0f9ff4332fe7830a692a1fa190a [111/114] i40e/i40evf: Faster RX via avoiding fcoe
config: sparc64-allmodconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 5f2e631c3e71c0f9ff4332fe7830a692a1fa190a
        # save the attached .config to linux build tree
        make.cross ARCH=sparc64 

All errors (new ones prefixed by >>):

>> drivers/net/ethernet/intel/i40e/i40e_fcoe.c:44:20: error: redefinition of 'i40e_rx_is_fcoe'
    static inline bool i40e_rx_is_fcoe(u16 ptype)
                       ^
   In file included from drivers/net/ethernet/intel/i40e/i40e.h:64:0,
                    from drivers/net/ethernet/intel/i40e/i40e_fcoe.c:37:
   drivers/net/ethernet/intel/i40e/i40e_txrx.h:456:20: note: previous definition of 'i40e_rx_is_fcoe' was here
    static inline bool i40e_rx_is_fcoe(u16 ptype)
                       ^

vim +/i40e_rx_is_fcoe +44 drivers/net/ethernet/intel/i40e/i40e_fcoe.c

a1a69369 Vasu Dev 2014-08-01  38  #include "i40e_fcoe.h"
a1a69369 Vasu Dev 2014-08-01  39  
a1a69369 Vasu Dev 2014-08-01  40  /**
a1a69369 Vasu Dev 2014-08-01  41   * i40e_rx_is_fcoe - returns true if the rx packet type is FCoE
a1a69369 Vasu Dev 2014-08-01  42   * @ptype: the packet type field from rx descriptor write-back
a1a69369 Vasu Dev 2014-08-01  43   **/
a1a69369 Vasu Dev 2014-08-01 @44  static inline bool i40e_rx_is_fcoe(u16 ptype)
a1a69369 Vasu Dev 2014-08-01  45  {
a1a69369 Vasu Dev 2014-08-01  46  	return (ptype >= I40E_RX_PTYPE_L2_FCOE_PAY3) &&
a1a69369 Vasu Dev 2014-08-01  47  	       (ptype <= I40E_RX_PTYPE_L2_FCOE_VFT_FCOTHER);

:::::: The code at line 44 was first introduced by commit
:::::: a1a693698d00b48d2d56fc1c887ab86375934a06 i40e: adds FCoE code to the i40e driver

:::::: TO: Vasu Dev <vasu.dev@intel.com>
:::::: CC: David S. Miller <davem@davemloft.net>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 45767 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160329/96516090/attachment-0001.obj>
