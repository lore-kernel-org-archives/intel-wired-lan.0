From: kernel test robot <lkp@intel.com>
Date: Wed, 12 Aug 2020 04:42:10 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 8/35]
 include/linux/prefetch.h:65:49: warning: declaration of 'struct page' will
 not be visible outside of this function
Message-ID: <202008120406.6CQQ67TN%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   1e38a2ae2ca4c1d7c81e5620e5c43e69c2c79854
commit: c2b9f24be5de6d9737de68d2d75ae3bc81f9b7db [8/35] i40e: optimise prefetch page refcount
config: arm-randconfig-r003-20200811 (attached as .config)
compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project 4f2ad15db535873dda9bfe248a2771023b64a43c)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        git checkout c2b9f24be5de6d9737de68d2d75ae3bc81f9b7db
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=arm 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from kernel/bounds.c:10:
   In file included from include/linux/page-flags.h:10:
   In file included from include/linux/bug.h:5:
   In file included from arch/arm/include/asm/bug.h:60:
   In file included from include/asm-generic/bug.h:20:
   In file included from include/linux/kernel.h:12:
   In file included from include/linux/bitops.h:29:
   In file included from arch/arm/include/asm/bitops.h:243:
   In file included from include/asm-generic/bitops/lock.h:5:
   In file included from include/linux/atomic.h:7:
   In file included from arch/arm/include/asm/atomic.h:12:
>> include/linux/prefetch.h:65:49: warning: declaration of 'struct page' will not be visible outside of this function [-Wvisibility]
   static inline void prefetch_page_address(struct page *page)
                                                   ^
   1 warning generated.
--
   In file included from arch/arm/kernel/asm-offsets.c:11:
   In file included from include/linux/sched.h:12:
   In file included from ./arch/arm/include/generated/asm/current.h:1:
   In file included from include/asm-generic/current.h:5:
   In file included from include/linux/thread_info.h:12:
   In file included from include/linux/bug.h:5:
   In file included from arch/arm/include/asm/bug.h:60:
   In file included from include/asm-generic/bug.h:20:
   In file included from include/linux/kernel.h:12:
   In file included from include/linux/bitops.h:29:
   In file included from arch/arm/include/asm/bitops.h:243:
   In file included from include/asm-generic/bitops/lock.h:5:
   In file included from include/linux/atomic.h:7:
   In file included from arch/arm/include/asm/atomic.h:12:
>> include/linux/prefetch.h:65:49: warning: declaration of 'struct page' will not be visible outside of this function [-Wvisibility]
   static inline void prefetch_page_address(struct page *page)
                                                   ^
   In file included from arch/arm/kernel/asm-offsets.c:13:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/arm/include/asm/io.h:438:
   include/asm-generic/io.h:660:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           insb(addr, buffer, count);
           ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm/mach-s3c24xx/include/mach/io.h:204:34: note: expanded from macro 'insb'
   #define insb(p,d,l)     __raw_readsb(__ioaddr(p),d,l)
                                        ^~~~~~~~~~~
   arch/arm/mach-s3c24xx/include/mach/io.h:202:65: note: expanded from macro '__ioaddr'
   #define __ioaddr(p)     (__builtin_constant_p((p)) ? __ioaddr(p)  : __ioaddrc(p))
                                                                       ^~~~~~~~~~~~
   arch/arm/mach-s3c24xx/include/mach/io.h:194:86: note: expanded from macro '__ioaddrc'
   #define __ioaddrc(port) ((__PORT_PCIO(port) ? PCIO_BASE + (port) : (void __iomem *)0 + (port)))
                                                                      ~~~~~~~~~~~~~~~~~ ^
   In file included from arch/arm/kernel/asm-offsets.c:13:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/arm/include/asm/io.h:438:
   include/asm-generic/io.h:668:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           insw(addr, buffer, count);
           ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm/mach-s3c24xx/include/mach/io.h:205:34: note: expanded from macro 'insw'
   #define insw(p,d,l)     __raw_readsw(__ioaddr(p),d,l)
                                        ^~~~~~~~~~~
   arch/arm/mach-s3c24xx/include/mach/io.h:202:65: note: expanded from macro '__ioaddr'
   #define __ioaddr(p)     (__builtin_constant_p((p)) ? __ioaddr(p)  : __ioaddrc(p))
                                                                       ^~~~~~~~~~~~
   arch/arm/mach-s3c24xx/include/mach/io.h:194:86: note: expanded from macro '__ioaddrc'
   #define __ioaddrc(port) ((__PORT_PCIO(port) ? PCIO_BASE + (port) : (void __iomem *)0 + (port)))
                                                                      ~~~~~~~~~~~~~~~~~ ^
   In file included from arch/arm/kernel/asm-offsets.c:13:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/arm/include/asm/io.h:438:
   include/asm-generic/io.h:676:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           insl(addr, buffer, count);
           ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm/mach-s3c24xx/include/mach/io.h:206:34: note: expanded from macro 'insl'
   #define insl(p,d,l)     __raw_readsl(__ioaddr(p),d,l)
                                        ^~~~~~~~~~~
   arch/arm/mach-s3c24xx/include/mach/io.h:202:65: note: expanded from macro '__ioaddr'
   #define __ioaddr(p)     (__builtin_constant_p((p)) ? __ioaddr(p)  : __ioaddrc(p))
                                                                       ^~~~~~~~~~~~
   arch/arm/mach-s3c24xx/include/mach/io.h:194:86: note: expanded from macro '__ioaddrc'
   #define __ioaddrc(port) ((__PORT_PCIO(port) ? PCIO_BASE + (port) : (void __iomem *)0 + (port)))
                                                                      ~~~~~~~~~~~~~~~~~ ^
   In file included from arch/arm/kernel/asm-offsets.c:13:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/arm/include/asm/io.h:438:
   include/asm-generic/io.h:685:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           outsb(addr, buffer, count);
           ^~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm/mach-s3c24xx/include/mach/io.h:208:36: note: expanded from macro 'outsb'
   #define outsb(p,d,l)    __raw_writesb(__ioaddr(p),d,l)
                                         ^~~~~~~~~~~
   arch/arm/mach-s3c24xx/include/mach/io.h:202:65: note: expanded from macro '__ioaddr'
   #define __ioaddr(p)     (__builtin_constant_p((p)) ? __ioaddr(p)  : __ioaddrc(p))
                                                                       ^~~~~~~~~~~~
   arch/arm/mach-s3c24xx/include/mach/io.h:194:86: note: expanded from macro '__ioaddrc'
   #define __ioaddrc(port) ((__PORT_PCIO(port) ? PCIO_BASE + (port) : (void __iomem *)0 + (port)))
                                                                      ~~~~~~~~~~~~~~~~~ ^
   In file included from arch/arm/kernel/asm-offsets.c:13:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/arm/include/asm/io.h:438:
   include/asm-generic/io.h:694:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           outsw(addr, buffer, count);
           ^~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm/mach-s3c24xx/include/mach/io.h:209:36: note: expanded from macro 'outsw'
   #define outsw(p,d,l)    __raw_writesw(__ioaddr(p),d,l)
                                         ^~~~~~~~~~~
   arch/arm/mach-s3c24xx/include/mach/io.h:202:65: note: expanded from macro '__ioaddr'
   #define __ioaddr(p)     (__builtin_constant_p((p)) ? __ioaddr(p)  : __ioaddrc(p))
                                                                       ^~~~~~~~~~~~
   arch/arm/mach-s3c24xx/include/mach/io.h:194:86: note: expanded from macro '__ioaddrc'
   #define __ioaddrc(port) ((__PORT_PCIO(port) ? PCIO_BASE + (port) : (void __iomem *)0 + (port)))
                                                                      ~~~~~~~~~~~~~~~~~ ^
   In file included from arch/arm/kernel/asm-offsets.c:13:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/arm/include/asm/io.h:438:
   include/asm-generic/io.h:703:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           outsl(addr, buffer, count);
           ^~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm/mach-s3c24xx/include/mach/io.h:210:36: note: expanded from macro 'outsl'
   #define outsl(p,d,l)    __raw_writesl(__ioaddr(p),d,l)
                                         ^~~~~~~~~~~
   arch/arm/mach-s3c24xx/include/mach/io.h:202:65: note: expanded from macro '__ioaddr'
   #define __ioaddr(p)     (__builtin_constant_p((p)) ? __ioaddr(p)  : __ioaddrc(p))
                                                                       ^~~~~~~~~~~~
   arch/arm/mach-s3c24xx/include/mach/io.h:194:86: note: expanded from macro '__ioaddrc'
   #define __ioaddrc(port) ((__PORT_PCIO(port) ? PCIO_BASE + (port) : (void __iomem *)0 + (port)))
                                                                      ~~~~~~~~~~~~~~~~~ ^
   7 warnings generated.
--
   In file included from net/ipv6/exthdrs.c:22:
   In file included from include/linux/socket.h:8:
   In file included from include/linux/uio.h:8:
   In file included from include/linux/kernel.h:12:
   In file included from include/linux/bitops.h:29:
   In file included from arch/arm/include/asm/bitops.h:243:
   In file included from include/asm-generic/bitops/lock.h:5:
   In file included from include/linux/atomic.h:7:
   In file included from arch/arm/include/asm/atomic.h:12:
>> include/linux/prefetch.h:65:49: warning: declaration of 'struct page' will not be visible outside of this function [-Wvisibility]
   static inline void prefetch_page_address(struct page *page)
                                                   ^
   In file included from net/ipv6/exthdrs.c:25:
   In file included from include/linux/netdevice.h:37:
   In file included from include/linux/ethtool.h:18:
   In file included from include/uapi/linux/ethtool.h:19:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:31:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/arm/include/asm/io.h:438:
   include/asm-generic/io.h:660:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           insb(addr, buffer, count);
           ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm/mach-s3c24xx/include/mach/io.h:204:34: note: expanded from macro 'insb'
   #define insb(p,d,l)     __raw_readsb(__ioaddr(p),d,l)
                                        ^~~~~~~~~~~
   arch/arm/mach-s3c24xx/include/mach/io.h:202:65: note: expanded from macro '__ioaddr'
   #define __ioaddr(p)     (__builtin_constant_p((p)) ? __ioaddr(p)  : __ioaddrc(p))
                                                                       ^~~~~~~~~~~~
   arch/arm/mach-s3c24xx/include/mach/io.h:194:86: note: expanded from macro '__ioaddrc'
   #define __ioaddrc(port) ((__PORT_PCIO(port) ? PCIO_BASE + (port) : (void __iomem *)0 + (port)))
                                                                      ~~~~~~~~~~~~~~~~~ ^
   In file included from net/ipv6/exthdrs.c:25:
   In file included from include/linux/netdevice.h:37:
   In file included from include/linux/ethtool.h:18:
   In file included from include/uapi/linux/ethtool.h:19:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:31:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/arm/include/asm/io.h:438:
   include/asm-generic/io.h:668:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           insw(addr, buffer, count);
           ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm/mach-s3c24xx/include/mach/io.h:205:34: note: expanded from macro 'insw'
   #define insw(p,d,l)     __raw_readsw(__ioaddr(p),d,l)
                                        ^~~~~~~~~~~
   arch/arm/mach-s3c24xx/include/mach/io.h:202:65: note: expanded from macro '__ioaddr'
   #define __ioaddr(p)     (__builtin_constant_p((p)) ? __ioaddr(p)  : __ioaddrc(p))
                                                                       ^~~~~~~~~~~~
   arch/arm/mach-s3c24xx/include/mach/io.h:194:86: note: expanded from macro '__ioaddrc'
   #define __ioaddrc(port) ((__PORT_PCIO(port) ? PCIO_BASE + (port) : (void __iomem *)0 + (port)))
                                                                      ~~~~~~~~~~~~~~~~~ ^
   In file included from net/ipv6/exthdrs.c:25:
   In file included from include/linux/netdevice.h:37:
   In file included from include/linux/ethtool.h:18:
   In file included from include/uapi/linux/ethtool.h:19:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:31:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/arm/include/asm/io.h:438:
   include/asm-generic/io.h:676:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           insl(addr, buffer, count);
           ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm/mach-s3c24xx/include/mach/io.h:206:34: note: expanded from macro 'insl'
   #define insl(p,d,l)     __raw_readsl(__ioaddr(p),d,l)
                                        ^~~~~~~~~~~
   arch/arm/mach-s3c24xx/include/mach/io.h:202:65: note: expanded from macro '__ioaddr'
   #define __ioaddr(p)     (__builtin_constant_p((p)) ? __ioaddr(p)  : __ioaddrc(p))
                                                                       ^~~~~~~~~~~~
   arch/arm/mach-s3c24xx/include/mach/io.h:194:86: note: expanded from macro '__ioaddrc'
   #define __ioaddrc(port) ((__PORT_PCIO(port) ? PCIO_BASE + (port) : (void __iomem *)0 + (port)))
                                                                      ~~~~~~~~~~~~~~~~~ ^
   In file included from net/ipv6/exthdrs.c:25:
   In file included from include/linux/netdevice.h:37:
   In file included from include/linux/ethtool.h:18:
   In file included from include/uapi/linux/ethtool.h:19:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:31:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/arm/include/asm/io.h:438:
   include/asm-generic/io.h:685:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           outsb(addr, buffer, count);
           ^~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm/mach-s3c24xx/include/mach/io.h:208:36: note: expanded from macro 'outsb'
   #define outsb(p,d,l)    __raw_writesb(__ioaddr(p),d,l)
                                         ^~~~~~~~~~~
   arch/arm/mach-s3c24xx/include/mach/io.h:202:65: note: expanded from macro '__ioaddr'
   #define __ioaddr(p)     (__builtin_constant_p((p)) ? __ioaddr(p)  : __ioaddrc(p))
                                                                       ^~~~~~~~~~~~
   arch/arm/mach-s3c24xx/include/mach/io.h:194:86: note: expanded from macro '__ioaddrc'
   #define __ioaddrc(port) ((__PORT_PCIO(port) ? PCIO_BASE + (port) : (void __iomem *)0 + (port)))
                                                                      ~~~~~~~~~~~~~~~~~ ^
   In file included from net/ipv6/exthdrs.c:25:
   In file included from include/linux/netdevice.h:37:
   In file included from include/linux/ethtool.h:18:
   In file included from include/uapi/linux/ethtool.h:19:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:31:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/arm/include/asm/io.h:438:
   include/asm-generic/io.h:694:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           outsw(addr, buffer, count);
           ^~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm/mach-s3c24xx/include/mach/io.h:209:36: note: expanded from macro 'outsw'
   #define outsw(p,d,l)    __raw_writesw(__ioaddr(p),d,l)
--
   In file included from net/core/dev.c:71:
   In file included from include/linux/uaccess.h:6:
   In file included from include/linux/sched.h:12:
   In file included from ./arch/arm/include/generated/asm/current.h:1:
   In file included from include/asm-generic/current.h:5:
   In file included from include/linux/thread_info.h:12:
   In file included from include/linux/bug.h:5:
   In file included from arch/arm/include/asm/bug.h:60:
   In file included from include/asm-generic/bug.h:20:
   In file included from include/linux/kernel.h:12:
   In file included from include/linux/bitops.h:29:
   In file included from arch/arm/include/asm/bitops.h:243:
   In file included from include/asm-generic/bitops/lock.h:5:
   In file included from include/linux/atomic.h:7:
   In file included from arch/arm/include/asm/atomic.h:12:
>> include/linux/prefetch.h:65:49: warning: declaration of 'struct page' will not be visible outside of this function [-Wvisibility]
   static inline void prefetch_page_address(struct page *page)
                                                   ^
   In file included from net/core/dev.c:89:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:31:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/arm/include/asm/io.h:438:
   include/asm-generic/io.h:660:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           insb(addr, buffer, count);
           ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm/mach-s3c24xx/include/mach/io.h:204:34: note: expanded from macro 'insb'
   #define insb(p,d,l)     __raw_readsb(__ioaddr(p),d,l)
                                        ^~~~~~~~~~~
   arch/arm/mach-s3c24xx/include/mach/io.h:202:65: note: expanded from macro '__ioaddr'
   #define __ioaddr(p)     (__builtin_constant_p((p)) ? __ioaddr(p)  : __ioaddrc(p))
                                                                       ^~~~~~~~~~~~
   arch/arm/mach-s3c24xx/include/mach/io.h:194:86: note: expanded from macro '__ioaddrc'
   #define __ioaddrc(port) ((__PORT_PCIO(port) ? PCIO_BASE + (port) : (void __iomem *)0 + (port)))
                                                                      ~~~~~~~~~~~~~~~~~ ^
   In file included from net/core/dev.c:89:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:31:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/arm/include/asm/io.h:438:
   include/asm-generic/io.h:668:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           insw(addr, buffer, count);
           ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm/mach-s3c24xx/include/mach/io.h:205:34: note: expanded from macro 'insw'
   #define insw(p,d,l)     __raw_readsw(__ioaddr(p),d,l)
                                        ^~~~~~~~~~~
   arch/arm/mach-s3c24xx/include/mach/io.h:202:65: note: expanded from macro '__ioaddr'
   #define __ioaddr(p)     (__builtin_constant_p((p)) ? __ioaddr(p)  : __ioaddrc(p))
                                                                       ^~~~~~~~~~~~
   arch/arm/mach-s3c24xx/include/mach/io.h:194:86: note: expanded from macro '__ioaddrc'
   #define __ioaddrc(port) ((__PORT_PCIO(port) ? PCIO_BASE + (port) : (void __iomem *)0 + (port)))
                                                                      ~~~~~~~~~~~~~~~~~ ^
   In file included from net/core/dev.c:89:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:31:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/arm/include/asm/io.h:438:
   include/asm-generic/io.h:676:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           insl(addr, buffer, count);
           ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm/mach-s3c24xx/include/mach/io.h:206:34: note: expanded from macro 'insl'
   #define insl(p,d,l)     __raw_readsl(__ioaddr(p),d,l)
                                        ^~~~~~~~~~~
   arch/arm/mach-s3c24xx/include/mach/io.h:202:65: note: expanded from macro '__ioaddr'
   #define __ioaddr(p)     (__builtin_constant_p((p)) ? __ioaddr(p)  : __ioaddrc(p))
                                                                       ^~~~~~~~~~~~
   arch/arm/mach-s3c24xx/include/mach/io.h:194:86: note: expanded from macro '__ioaddrc'
   #define __ioaddrc(port) ((__PORT_PCIO(port) ? PCIO_BASE + (port) : (void __iomem *)0 + (port)))
                                                                      ~~~~~~~~~~~~~~~~~ ^
   In file included from net/core/dev.c:89:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:31:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/arm/include/asm/io.h:438:
   include/asm-generic/io.h:685:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           outsb(addr, buffer, count);
           ^~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm/mach-s3c24xx/include/mach/io.h:208:36: note: expanded from macro 'outsb'
   #define outsb(p,d,l)    __raw_writesb(__ioaddr(p),d,l)
                                         ^~~~~~~~~~~
   arch/arm/mach-s3c24xx/include/mach/io.h:202:65: note: expanded from macro '__ioaddr'
   #define __ioaddr(p)     (__builtin_constant_p((p)) ? __ioaddr(p)  : __ioaddrc(p))
                                                                       ^~~~~~~~~~~~
   arch/arm/mach-s3c24xx/include/mach/io.h:194:86: note: expanded from macro '__ioaddrc'
   #define __ioaddrc(port) ((__PORT_PCIO(port) ? PCIO_BASE + (port) : (void __iomem *)0 + (port)))
                                                                      ~~~~~~~~~~~~~~~~~ ^
   In file included from net/core/dev.c:89:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:31:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/arm/include/asm/io.h:438:
   include/asm-generic/io.h:694:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           outsw(addr, buffer, count);
           ^~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm/mach-s3c24xx/include/mach/io.h:209:36: note: expanded from macro 'outsw'
   #define outsw(p,d,l)    __raw_writesw(__ioaddr(p),d,l)
                                         ^~~~~~~~~~~
   arch/arm/mach-s3c24xx/include/mach/io.h:202:65: note: expanded from macro '__ioaddr'
   #define __ioaddr(p)     (__builtin_constant_p((p)) ? __ioaddr(p)  : __ioaddrc(p))
                                                                       ^~~~~~~~~~~~
   arch/arm/mach-s3c24xx/include/mach/io.h:194:86: note: expanded from macro '__ioaddrc'
   #define __ioaddrc(port) ((__PORT_PCIO(port) ? PCIO_BASE + (port) : (void __iomem *)0 + (port)))
                                                                      ~~~~~~~~~~~~~~~~~ ^
   In file included from net/core/dev.c:89:
   In file included from include/linux/if_ether.h:19:
   In file included from include/linux/skbuff.h:31:
   In file included from include/linux/dma-mapping.h:11:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/arm/include/asm/io.h:438:
   include/asm-generic/io.h:703:2: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           outsl(addr, buffer, count);
..

vim +65 include/linux/prefetch.h

    64	
  > 65	static inline void prefetch_page_address(struct page *page)
    66	{
    67	#if defined(WANT_PAGE_VIRTUAL) || defined(HASHED_PAGE_VIRTUAL)
    68		prefetch(page);
    69	#endif
    70	}
    71	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 27968 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20200812/8f59d47c/attachment-0001.bin>
