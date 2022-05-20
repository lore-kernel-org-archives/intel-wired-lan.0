From: kernel test robot <lkp@intel.com>
Date: Fri, 20 May 2022 14:11:27 +0800
Subject: [Intel-wired-lan] [PATCH net-next v5 10/11] igc: Check
 incompatible configs for Frame Preemption
In-Reply-To: <20220520011538.1098888-11-vinicius.gomes@intel.com>
References: <20220520011538.1098888-11-vinicius.gomes@intel.com>
Message-ID: <202205201422.84XYwlpY-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Vinicius,

I love your patch! Perhaps something to improve:

[auto build test WARNING on net-next/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Vinicius-Costa-Gomes/ethtool-Add-support-for-frame-preemption/20220520-092800
base:   https://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git df98714e432abf5cbdac3e4c1a13f94c65ddb8d3
config: s390-buildonly-randconfig-r002-20220519 (https://download.01.org/0day-ci/archive/20220520/202205201422.84XYwlpY-lkp at intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project e00cbbec06c08dc616a0d52a20f678b8fbd4e304)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/a42e940bc53c40ee4e33a1bbf022a663bb28a9c7
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Vinicius-Costa-Gomes/ethtool-Add-support-for-frame-preemption/20220520-092800
        git checkout a42e940bc53c40ee4e33a1bbf022a663bb28a9c7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash drivers/net/ethernet/intel/igc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/net/ethernet/intel/igc/igc_main.c:6:
   In file included from include/linux/if_vlan.h:10:
   In file included from include/linux/netdevice.h:38:
   In file included from include/net/net_namespace.h:40:
   In file included from include/linux/skbuff.h:31:
   In file included from include/linux/dma-mapping.h:10:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:464:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:477:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:37:59: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
                                                             ^
   include/uapi/linux/swab.h:102:54: note: expanded from macro '__swab16'
   #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
                                                        ^
   In file included from drivers/net/ethernet/intel/igc/igc_main.c:6:
   In file included from include/linux/if_vlan.h:10:
   In file included from include/linux/netdevice.h:38:
   In file included from include/net/net_namespace.h:40:
   In file included from include/linux/skbuff.h:31:
   In file included from include/linux/dma-mapping.h:10:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:490:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:35:59: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
                                                             ^
   include/uapi/linux/swab.h:115:54: note: expanded from macro '__swab32'
   #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
                                                        ^
   In file included from drivers/net/ethernet/intel/igc/igc_main.c:6:
   In file included from include/linux/if_vlan.h:10:
   In file included from include/linux/netdevice.h:38:
   In file included from include/net/net_namespace.h:40:
   In file included from include/linux/skbuff.h:31:
   In file included from include/linux/dma-mapping.h:10:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:501:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:511:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:521:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:609:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsb(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:617:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsw(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:625:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsl(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:634:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesb(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:643:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesw(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:652:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesl(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
>> drivers/net/ethernet/intel/igc/igc_main.c:5919:6: warning: variable 'ring' is uninitialized when used here [-Wuninitialized]
           if (ring->preemptible) {
               ^~~~
   drivers/net/ethernet/intel/igc/igc_main.c:5914:23: note: initialize the variable 'ring' to silence this warning
           struct igc_ring *ring;
                                ^
                                 = NULL
   13 warnings generated.


vim +/ring +5919 drivers/net/ethernet/intel/igc/igc_main.c

  5910	
  5911	static int igc_save_launchtime_params(struct igc_adapter *adapter, int queue,
  5912					      bool enable)
  5913	{
  5914		struct igc_ring *ring;
  5915	
  5916		if (queue < 0 || queue >= adapter->num_tx_queues)
  5917			return -EINVAL;
  5918	
> 5919		if (ring->preemptible) {
  5920			netdev_err(adapter->netdev, "Cannot enable LaunchTime on a preemptible queue\n");
  5921			return -EINVAL;
  5922		}
  5923	
  5924		ring = adapter->tx_ring[queue];
  5925		ring->launchtime_enable = enable;
  5926	
  5927		return 0;
  5928	}
  5929	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
