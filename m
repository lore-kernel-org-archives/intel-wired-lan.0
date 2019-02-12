From: kbuild test robot <lkp@intel.com>
Date: Wed, 13 Feb 2019 05:24:44 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 15/23]
 arch/mips/pci/ops-loongson2.c:198:1: warning: the frame size of 1040 bytes
 is larger than 1024 bytes
Message-ID: <201902130540.ljHJxzp1%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   80cd86d797eb46a4c02ffea2ec1fc5d8faab434d
commit: dd24dbf9cd3d8d2fe02c69583e62da1cbb142c7e [15/23] PCI/MSI: New structures/macros for dynamic MSI-X allocation
config: mips-lemote2f_defconfig (attached as .config)
compiler: mips64el-linux-gnuabi64-gcc (Debian 8.2.0-11) 8.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout dd24dbf9cd3d8d2fe02c69583e62da1cbb142c7e
        # save the attached .config to linux build tree
        GCC_VERSION=8.2.0 make.cross ARCH=mips 

All warnings (new ones prefixed by >>):

   arch/mips/pci/ops-loongson2.c: In function '_rdmsr':
>> arch/mips/pci/ops-loongson2.c:198:1: warning: the frame size of 1040 bytes is larger than 1024 bytes [-Wframe-larger-than=]
    }
    ^

vim +198 arch/mips/pci/ops-loongson2.c

b846c10d Wu Zhangjin 2010-03-11  184  
1032bce3 Wu Zhangjin 2009-11-10  185  void _rdmsr(u32 msr, u32 *hi, u32 *lo)
1032bce3 Wu Zhangjin 2009-11-10  186  {
1032bce3 Wu Zhangjin 2009-11-10  187  	struct pci_bus bus = {
1032bce3 Wu Zhangjin 2009-11-10  188  		.number = PCI_BUS_CS5536
1032bce3 Wu Zhangjin 2009-11-10  189  	};
1032bce3 Wu Zhangjin 2009-11-10  190  	u32 devfn = PCI_DEVFN(PCI_IDSEL_CS5536, 0);
b846c10d Wu Zhangjin 2010-03-11  191  	unsigned long flags;
b846c10d Wu Zhangjin 2010-03-11  192  
b846c10d Wu Zhangjin 2010-03-11  193  	raw_spin_lock_irqsave(&msr_lock, flags);
1032bce3 Wu Zhangjin 2009-11-10  194  	loongson_pcibios_write(&bus, devfn, PCI_MSR_ADDR, 4, msr);
1032bce3 Wu Zhangjin 2009-11-10  195  	loongson_pcibios_read(&bus, devfn, PCI_MSR_DATA_LO, 4, lo);
1032bce3 Wu Zhangjin 2009-11-10  196  	loongson_pcibios_read(&bus, devfn, PCI_MSR_DATA_HI, 4, hi);
b846c10d Wu Zhangjin 2010-03-11  197  	raw_spin_unlock_irqrestore(&msr_lock, flags);
1032bce3 Wu Zhangjin 2009-11-10 @198  }
1032bce3 Wu Zhangjin 2009-11-10  199  EXPORT_SYMBOL(_rdmsr);
1032bce3 Wu Zhangjin 2009-11-10  200  

:::::: The code at line 198 was first introduced by commit
:::::: 1032bce3ef81cb31fc85233ca668c17288e7884c MIPS: Lemote 2F: Add PCI support

:::::: TO: Wu Zhangjin <wuzhangjin@gmail.com>
:::::: CC: Ralf Baechle <ralf@linux-mips.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 20841 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20190213/ee17b070/attachment-0001.bin>
