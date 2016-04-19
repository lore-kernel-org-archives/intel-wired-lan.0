From: kbuild test robot <lkp@intel.com>
Date: Tue, 19 Apr 2016 22:36:38 +0800
Subject: [Intel-wired-lan] [PATCH net-next V3 2/2] intel: ixgbevf:
 Support Windows hosts (Hyper-V)
In-Reply-To: <1461080968-25235-2-git-send-email-kys@microsoft.com>
Message-ID: <201604192232.uGY4gP3i%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,

[auto build test WARNING on net-next/master]

url:    https://github.com/0day-ci/linux/commits/K-Y-Srinivasan/ethernet-intel-Add-the-device-ID-s-presented-while-running-on-Hyper-V/20160419-221508
config: i386-randconfig-s0-201616 (attached as .config)
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/intel/ixgbevf/vf.c: In function 'ixgbevf_hv_reset_hw_vf':
>> drivers/net/ethernet/intel/ixgbevf/vf.c:142:6: warning: unused variable 'i' [-Wunused-variable]
     int i;
         ^
>> drivers/net/ethernet/intel/ixgbevf/vf.c:141:26: warning: unused variable 'adapter' [-Wunused-variable]
     struct ixgbevf_adapter *adapter = hw->back;
                             ^

vim +/i +142 drivers/net/ethernet/intel/ixgbevf/vf.c

   135	/**
   136	 * Hyper-V variant; the VF/PF communication is through the PCI
   137	 * config space.
   138	 */
   139	static s32 ixgbevf_hv_reset_hw_vf(struct ixgbe_hw *hw)
   140	{
 > 141		struct ixgbevf_adapter *adapter = hw->back;
 > 142		int i;
   143	
   144	#if IS_ENABLED(CONFIG_PCI_MMCONFIG)
   145		for (i = 0; i < 6; i++)

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 27643 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160419/d2781f6d/attachment-0001.obj>
