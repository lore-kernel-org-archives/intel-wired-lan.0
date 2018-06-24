From: kbuild test robot <lkp@intel.com>
Date: Sun, 24 Jun 2018 19:42:35 +0800
Subject: [Intel-wired-lan] [PATCH v3 02/11] igc: Add support for PF
In-Reply-To: <20180624084500.10021-1-sasha.neftin@intel.com>
References: <20180624084500.10021-1-sasha.neftin@intel.com>
Message-ID: <201806241858.TXFRw68O%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Sasha,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on jkirsher-next-queue/dev-queue]
[also build test WARNING on v4.18-rc1 next-20180622]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Sasha-Neftin/igc-Add-skeletal-frame-for-Intel-R-2-5G-Ethernet-Controller-support/20180624-164739
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/net/ethernet/intel/igc/igc_main.c:76:31: sparse: incorrect type in initializer (different address spaces) @@    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr @@    got deref] [usertype] <asn:2>*hw_addr @@
   drivers/net/ethernet/intel/igc/igc_main.c:76:31:    expected unsigned char [noderef] [usertype] <asn:2>*hw_addr
   drivers/net/ethernet/intel/igc/igc_main.c:76:31:    got unsigned char [usertype] *__val
   drivers/net/ethernet/intel/igc/igc_main.c: In function 'igc_probe':
   drivers/net/ethernet/intel/igc/igc_main.c:193:18: warning: 'adapter' may be used uninitialized in this function [-Wmaybe-uninitialized]
     struct pci_dev *pdev = adapter->pdev;
                     ^~~~
   drivers/net/ethernet/intel/igc/igc_main.c:105:22: note: 'adapter' was declared here
     struct igc_adapter *adapter;
                         ^~~~~~~
   drivers/net/ethernet/intel/igc/igc_main.c:147:2: warning: 'hw' may be used uninitialized in this function [-Wmaybe-uninitialized]
     igc_get_bus_info_pcie(hw);
     ^~~~~~~~~~~~~~~~~~~~~~~~~

vim +76 drivers/net/ethernet/intel/igc/igc_main.c

    73	
    74	u32 igc_rd32(struct e1000_hw *hw, u32 reg)
    75	{
  > 76		u8 __iomem *hw_addr = READ_ONCE(hw->hw_addr);
    77		u32 value = 0;
    78	
    79		if (E1000_REMOVED(hw_addr))
    80			return ~value;
    81	
    82		value = readl(&hw_addr[reg]);
    83	
    84		/* reads should not return all F's */
    85		if (!(~value) && (!reg || !(~readl(hw_addr))))
    86			hw->hw_addr = NULL;
    87	
    88		return value;
    89	}
    90	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
