From: kbuild test robot <fengguang.wu@intel.com>
Date: Fri, 5 May 2017 05:55:06 +0800
Subject: [Intel-wired-lan] [jkirsher-net-queue:dev-queue 4/4]
 drivers/net/ethernet/intel/i40e/i40e_main.c:8828:16: error:
 'I40E_FLAG_HW_ATR_EVICT_ENABLED' undeclared
Message-ID: <201705050505.wALUZ7vS%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/net-queue.git dev-queue
head:   9714e5c2be7ebfe681a124c9cfca810eedb6bb4c
commit: 9714e5c2be7ebfe681a124c9cfca810eedb6bb4c [4/4] i40e: fix incorrect assignment of I40E_FLAG_HW_ATR_EVICT_CAPABLE
config: x86_64-rhel (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        git checkout 9714e5c2be7ebfe681a124c9cfca810eedb6bb4c
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   drivers/net/ethernet/intel/i40e/i40e_main.c: In function 'i40e_sw_init':
>> drivers/net/ethernet/intel/i40e/i40e_main.c:8828:16: error: 'I40E_FLAG_HW_ATR_EVICT_ENABLED' undeclared (first use in this function)
      pf->flags |= I40E_FLAG_HW_ATR_EVICT_ENABLED;
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/i40e/i40e_main.c:8828:16: note: each undeclared identifier is reported only once for each function it appears in

vim +/I40E_FLAG_HW_ATR_EVICT_ENABLED +8828 drivers/net/ethernet/intel/i40e/i40e_main.c

  8822			/* Supported in FW API version higher than 1.4 */
  8823			pf->flags |= I40E_FLAG_GENEVE_OFFLOAD_CAPABLE;
  8824		}
  8825	
  8826		/* Enable HW ATR eviction if possible */
  8827		if (pf->flags & I40E_FLAG_HW_ATR_EVICT_CAPABLE)
> 8828			pf->flags |= I40E_FLAG_HW_ATR_EVICT_ENABLED;
  8829	
  8830		pf->eeprom_version = 0xDEAD;
  8831		pf->lan_veb = I40E_NO_VEB;

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 38958 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20170505/945a154e/attachment-0001.bin>
