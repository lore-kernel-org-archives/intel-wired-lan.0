From: kbuild test robot <lkp@intel.com>
Date: Fri, 8 Apr 2016 02:04:04 +0800
Subject: [Intel-wired-lan] [PATCH] ixgbe: Add register wait for slow
	links
In-Reply-To: <20160407174350.39412.3975.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <201604080216.JeUplDIZ%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Mark,

[auto build test WARNING on net-next/master]
[also build test WARNING on v4.6-rc2 next-20160407]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Mark-D-Rustad/ixgbe-Add-register-wait-for-slow-links/20160408-014717
config: i386-randconfig-x012-201614 (attached as .config)
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All warnings (new ones prefixed by >>):

   In file included from include/uapi/linux/stddef.h:1:0,
                    from include/linux/stddef.h:4,
                    from include/uapi/linux/posix_types.h:4,
                    from include/uapi/linux/types.h:13,
                    from include/linux/types.h:5,
                    from drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:29:
   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c: In function 'ixgbe_read_reg':
   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:367:8: error: 'IXGBE_NW_MNG_IF_SEL_ENABLE_10_100M' undeclared (first use in this function)
           IXGBE_NW_MNG_IF_SEL_ENABLE_10_100M)) {
           ^
   include/linux/compiler.h:151:30: note: in definition of macro '__trace_if'
     if (__builtin_constant_p(!!(cond)) ? !!(cond) :   \
                                 ^
>> drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:366:2: note: in expansion of macro 'if'
     if (unlikely(hw->phy.nw_mng_if_sel &
     ^
>> drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:366:6: note: in expansion of macro 'unlikely'
     if (unlikely(hw->phy.nw_mng_if_sel &
         ^
   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:367:8: note: each undeclared identifier is reported only once for each function it appears in
           IXGBE_NW_MNG_IF_SEL_ENABLE_10_100M)) {
           ^
   include/linux/compiler.h:151:30: note: in definition of macro '__trace_if'
     if (__builtin_constant_p(!!(cond)) ? !!(cond) :   \
                                 ^
>> drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:366:2: note: in expansion of macro 'if'
     if (unlikely(hw->phy.nw_mng_if_sel &
     ^
>> drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:366:6: note: in expansion of macro 'unlikely'
     if (unlikely(hw->phy.nw_mng_if_sel &
         ^

vim +/if +366 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c

   360	{
   361		u8 __iomem *reg_addr = ACCESS_ONCE(hw->hw_addr);
   362		u32 value;
   363	
   364		if (ixgbe_removed(reg_addr))
   365			return IXGBE_FAILED_READ_REG;
 > 366		if (unlikely(hw->phy.nw_mng_if_sel &
 > 367			     IXGBE_NW_MNG_IF_SEL_ENABLE_10_100M)) {
   368			struct ixgbe_adapter *adapter;
   369			int i;
   370	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 26293 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160408/476a49cf/attachment-0001.obj>
