From: kbuild test robot <lkp@intel.com>
Date: Fri, 10 Jun 2016 05:27:10 +0800
Subject: [Intel-wired-lan] [PATCH] fm10k: use software values when
 checking for Tx hangs in hot path
In-Reply-To: <20160609202817.6083-1-jacob.e.keller@intel.com>
Message-ID: <201606100553.91YyWEJU%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,

[auto build test ERROR on jkirsher-next-queue/dev-queue]
[cannot apply to v4.7-rc2 next-20160609]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Jacob-Keller/fm10k-use-software-values-when-checking-for-Tx-hangs-in-hot-path/20160610-043049
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
config: i386-allmodconfig (attached as .config)
compiler: gcc-6 (Debian 6.1.1-1) 6.1.1 20160430
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

>> drivers/net/ethernet/intel/fm10k/fm10k_main.c:1136:5: error: conflicting types for 'fm10k_get_tx_pending'
    u64 fm10k_get_tx_pending(struct fm10k_ring *ring, bool in_sw)
        ^~~~~~~~~~~~~~~~~~~~
   In file included from drivers/net/ethernet/intel/fm10k/fm10k_main.c:29:0:
   drivers/net/ethernet/intel/fm10k/fm10k.h:461:5: note: previous declaration of 'fm10k_get_tx_pending' was here
    u64 fm10k_get_tx_pending(struct fm10k_ring *ring);
        ^~~~~~~~~~~~~~~~~~~~
--
   drivers/net/ethernet/intel/fm10k/fm10k_pci.c: In function 'fm10k_down':
>> drivers/net/ethernet/intel/fm10k/fm10k_pci.c:1702:8: error: too many arguments to function 'fm10k_get_tx_pending'
       if (fm10k_get_tx_pending(interface->tx_ring[i], false))
           ^~~~~~~~~~~~~~~~~~~~
   In file included from drivers/net/ethernet/intel/fm10k/fm10k_pci.c:24:0:
   drivers/net/ethernet/intel/fm10k/fm10k.h:461:5: note: declared here
    u64 fm10k_get_tx_pending(struct fm10k_ring *ring);
        ^~~~~~~~~~~~~~~~~~~~

vim +/fm10k_get_tx_pending +1136 drivers/net/ethernet/intel/fm10k/fm10k_main.c

  1130	
  1131	/**
  1132	 * fm10k_get_tx_pending - how many tx descriptors not processed
  1133	 * @ring: the ring structure
  1134	 * @in_sw: is tx_pending being checked in SW or in HW?
  1135	 */
> 1136	u64 fm10k_get_tx_pending(struct fm10k_ring *ring, bool in_sw)
  1137	{
  1138		struct fm10k_intfc *interface = ring->q_vector->interface;
  1139		struct fm10k_hw *hw = &interface->hw;

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 55052 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160610/96c313ad/attachment-0001.obj>
