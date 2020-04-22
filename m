From: kbuild test robot <lkp@intel.com>
Date: Thu, 23 Apr 2020 02:41:36 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 60/60]
 include/linux/byteorder/generic.h:89:21: note: in expansion of macro
 '__le32_to_cpu'
Message-ID: <202004230222.2RQZOmei%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   826a1eed0402b218f4374a26b6a1009404d6ba65
commit: 826a1eed0402b218f4374a26b6a1009404d6ba65 [60/60] i40e: Add a check to see if MFS is set
config: arm-allmodconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 826a1eed0402b218f4374a26b6a1009404d6ba65
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day GCC_VERSION=9.3.0 make.cross ARCH=arm 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/swab.h:5,
                    from include/uapi/linux/byteorder/big_endian.h:13,
                    from include/linux/byteorder/big_endian.h:5,
                    from arch/arm/include/uapi/asm/byteorder.h:20,
                    from include/asm-generic/bitops/le.h:6,
                    from arch/arm/include/asm/bitops.h:268,
                    from include/linux/bitops.h:29,
                    from include/linux/kernel.h:12,
                    from include/linux/skbuff.h:13,
                    from include/linux/if_ether.h:19,
                    from include/linux/etherdevice.h:20,
                    from drivers/net/ethernet/intel/i40e/i40e_main.c:4:
   drivers/net/ethernet/intel/i40e/i40e_main.c: In function 'i40e_probe':
   drivers/net/ethernet/intel/i40e/i40e_main.c:15350:24: error: 'I40E_PRTGL_SAH' undeclared (first use in this function); did you mean 'I40E_PRTGEN_CNF'?
   15350 |   val = (rd32(&pf->hw, I40E_PRTGL_SAH + 0x4 * i) &
         |                        ^~~~~~~~~~~~~~
   include/uapi/linux/swab.h:115:54: note: in definition of macro '__swab32'
     115 | #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
         |                                                      ^
>> include/linux/byteorder/generic.h:89:21: note: in expansion of macro '__le32_to_cpu'
      89 | #define le32_to_cpu __le32_to_cpu
         |                     ^~~~~~~~~~~~~
>> arch/arm/include/asm/io.h:303:32: note: in expansion of macro 'readl_relaxed'
     303 | #define readl(c)  ({ u32 __v = readl_relaxed(c); __iormb(); __v; })
         |                                ^~~~~~~~~~~~~
   drivers/net/ethernet/intel/i40e/i40e_osdep.h:27:23: note: in expansion of macro 'readl'
      27 | #define rd32(a, reg)  readl((a)->hw_addr + (reg))
         |                       ^~~~~
   drivers/net/ethernet/intel/i40e/i40e_main.c:15350:10: note: in expansion of macro 'rd32'
   15350 |   val = (rd32(&pf->hw, I40E_PRTGL_SAH + 0x4 * i) &
         |          ^~~~
   drivers/net/ethernet/intel/i40e/i40e_main.c:15350:24: note: each undeclared identifier is reported only once for each function it appears in
   15350 |   val = (rd32(&pf->hw, I40E_PRTGL_SAH + 0x4 * i) &
         |                        ^~~~~~~~~~~~~~
   include/uapi/linux/swab.h:115:54: note: in definition of macro '__swab32'
     115 | #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
         |                                                      ^
>> include/linux/byteorder/generic.h:89:21: note: in expansion of macro '__le32_to_cpu'
      89 | #define le32_to_cpu __le32_to_cpu
         |                     ^~~~~~~~~~~~~
>> arch/arm/include/asm/io.h:303:32: note: in expansion of macro 'readl_relaxed'
     303 | #define readl(c)  ({ u32 __v = readl_relaxed(c); __iormb(); __v; })
         |                                ^~~~~~~~~~~~~
   drivers/net/ethernet/intel/i40e/i40e_osdep.h:27:23: note: in expansion of macro 'readl'
      27 | #define rd32(a, reg)  readl((a)->hw_addr + (reg))
         |                       ^~~~~
   drivers/net/ethernet/intel/i40e/i40e_main.c:15350:10: note: in expansion of macro 'rd32'
   15350 |   val = (rd32(&pf->hw, I40E_PRTGL_SAH + 0x4 * i) &
         |          ^~~~
   drivers/net/ethernet/intel/i40e/i40e_main.c:15351:10: error: 'I40E_PRTGL_SAH_MFS_MASK' undeclared (first use in this function); did you mean 'I40E_REG_MSS_MIN_MASK'?
   15351 |          I40E_PRTGL_SAH_MFS_MASK) >> I40E_PRTGL_SAH_MFS_SHIFT;
         |          ^~~~~~~~~~~~~~~~~~~~~~~
         |          I40E_REG_MSS_MIN_MASK
   drivers/net/ethernet/intel/i40e/i40e_main.c:15351:38: error: 'I40E_PRTGL_SAH_MFS_SHIFT' undeclared (first use in this function)
   15351 |          I40E_PRTGL_SAH_MFS_MASK) >> I40E_PRTGL_SAH_MFS_SHIFT;
         |                                      ^~~~~~~~~~~~~~~~~~~~~~~~

vim +/__le32_to_cpu +89 include/linux/byteorder/generic.h

^1da177e4c3f41 Linus Torvalds 2005-04-16    4  
^1da177e4c3f41 Linus Torvalds 2005-04-16    5  /*
90a856436ddafb Geoff Levand   2014-08-06    6   * linux/byteorder/generic.h
^1da177e4c3f41 Linus Torvalds 2005-04-16    7   * Generic Byte-reordering support
^1da177e4c3f41 Linus Torvalds 2005-04-16    8   *
e0487992ce1dd7 Ed L. Cashin   2005-09-19    9   * The "... p" macros, like le64_to_cpup, can be used with pointers
e0487992ce1dd7 Ed L. Cashin   2005-09-19   10   * to unaligned data, but there will be a performance penalty on 
e0487992ce1dd7 Ed L. Cashin   2005-09-19   11   * some architectures.  Use get_unaligned for unaligned data.
e0487992ce1dd7 Ed L. Cashin   2005-09-19   12   *
^1da177e4c3f41 Linus Torvalds 2005-04-16   13   * Francois-Rene Rideau <fare@tunes.org> 19970707
^1da177e4c3f41 Linus Torvalds 2005-04-16   14   *    gathered all the good ideas from all asm-foo/byteorder.h into one file,
^1da177e4c3f41 Linus Torvalds 2005-04-16   15   *    cleaned them up.
^1da177e4c3f41 Linus Torvalds 2005-04-16   16   *    I hope it is compliant with non-GCC compilers.
^1da177e4c3f41 Linus Torvalds 2005-04-16   17   *    I decided to put __BYTEORDER_HAS_U64__ in byteorder.h,
^1da177e4c3f41 Linus Torvalds 2005-04-16   18   *    because I wasn't sure it would be ok to put it in types.h
^1da177e4c3f41 Linus Torvalds 2005-04-16   19   *    Upgraded it to 2.1.43
^1da177e4c3f41 Linus Torvalds 2005-04-16   20   * Francois-Rene Rideau <fare@tunes.org> 19971012
^1da177e4c3f41 Linus Torvalds 2005-04-16   21   *    Upgraded it to 2.1.57
^1da177e4c3f41 Linus Torvalds 2005-04-16   22   *    to please Linus T., replaced huge #ifdef's between little/big endian
^1da177e4c3f41 Linus Torvalds 2005-04-16   23   *    by nestedly #include'd files.
^1da177e4c3f41 Linus Torvalds 2005-04-16   24   * Francois-Rene Rideau <fare@tunes.org> 19971205
^1da177e4c3f41 Linus Torvalds 2005-04-16   25   *    Made it to 2.1.71; now a facelift:
^1da177e4c3f41 Linus Torvalds 2005-04-16   26   *    Put files under include/linux/byteorder/
^1da177e4c3f41 Linus Torvalds 2005-04-16   27   *    Split swab from generic support.
^1da177e4c3f41 Linus Torvalds 2005-04-16   28   *
^1da177e4c3f41 Linus Torvalds 2005-04-16   29   * TODO:
^1da177e4c3f41 Linus Torvalds 2005-04-16   30   *   = Regular kernel maintainers could also replace all these manual
^1da177e4c3f41 Linus Torvalds 2005-04-16   31   *    byteswap macros that remain, disseminated among drivers,
^1da177e4c3f41 Linus Torvalds 2005-04-16   32   *    after some grep or the sources...
^1da177e4c3f41 Linus Torvalds 2005-04-16   33   *   = Linus might want to rename all these macros and files to fit his taste,
^1da177e4c3f41 Linus Torvalds 2005-04-16   34   *    to fit his personal naming scheme.
^1da177e4c3f41 Linus Torvalds 2005-04-16   35   *   = it seems that a few drivers would also appreciate
^1da177e4c3f41 Linus Torvalds 2005-04-16   36   *    nybble swapping support...
^1da177e4c3f41 Linus Torvalds 2005-04-16   37   *   = every architecture could add their byteswap macro in asm/byteorder.h
^1da177e4c3f41 Linus Torvalds 2005-04-16   38   *    see how some architectures already do (i386, alpha, ppc, etc)
^1da177e4c3f41 Linus Torvalds 2005-04-16   39   *   = cpu_to_beXX and beXX_to_cpu might some day need to be well
^1da177e4c3f41 Linus Torvalds 2005-04-16   40   *    distinguished throughout the kernel. This is not the case currently,
^1da177e4c3f41 Linus Torvalds 2005-04-16   41   *    since little endian, big endian, and pdp endian machines needn't it.
^1da177e4c3f41 Linus Torvalds 2005-04-16   42   *    But this might be the case for, say, a port of Linux to 20/21 bit
^1da177e4c3f41 Linus Torvalds 2005-04-16   43   *    architectures (and F21 Linux addict around?).
^1da177e4c3f41 Linus Torvalds 2005-04-16   44   */
^1da177e4c3f41 Linus Torvalds 2005-04-16   45  
^1da177e4c3f41 Linus Torvalds 2005-04-16   46  /*
^1da177e4c3f41 Linus Torvalds 2005-04-16   47   * The following macros are to be defined by <asm/byteorder.h>:
^1da177e4c3f41 Linus Torvalds 2005-04-16   48   *
^1da177e4c3f41 Linus Torvalds 2005-04-16   49   * Conversion of long and short int between network and host format
^1da177e4c3f41 Linus Torvalds 2005-04-16   50   *	ntohl(__u32 x)
^1da177e4c3f41 Linus Torvalds 2005-04-16   51   *	ntohs(__u16 x)
^1da177e4c3f41 Linus Torvalds 2005-04-16   52   *	htonl(__u32 x)
^1da177e4c3f41 Linus Torvalds 2005-04-16   53   *	htons(__u16 x)
^1da177e4c3f41 Linus Torvalds 2005-04-16   54   * It seems that some programs (which? where? or perhaps a standard? POSIX?)
^1da177e4c3f41 Linus Torvalds 2005-04-16   55   * might like the above to be functions, not macros (why?).
^1da177e4c3f41 Linus Torvalds 2005-04-16   56   * if that's true, then detect them, and take measures.
^1da177e4c3f41 Linus Torvalds 2005-04-16   57   * Anyway, the measure is: define only ___ntohl as a macro instead,
^1da177e4c3f41 Linus Torvalds 2005-04-16   58   * and in a separate file, have
^1da177e4c3f41 Linus Torvalds 2005-04-16   59   * unsigned long inline ntohl(x){return ___ntohl(x);}
^1da177e4c3f41 Linus Torvalds 2005-04-16   60   *
^1da177e4c3f41 Linus Torvalds 2005-04-16   61   * The same for constant arguments
^1da177e4c3f41 Linus Torvalds 2005-04-16   62   *	__constant_ntohl(__u32 x)
^1da177e4c3f41 Linus Torvalds 2005-04-16   63   *	__constant_ntohs(__u16 x)
^1da177e4c3f41 Linus Torvalds 2005-04-16   64   *	__constant_htonl(__u32 x)
^1da177e4c3f41 Linus Torvalds 2005-04-16   65   *	__constant_htons(__u16 x)
^1da177e4c3f41 Linus Torvalds 2005-04-16   66   *
^1da177e4c3f41 Linus Torvalds 2005-04-16   67   * Conversion of XX-bit integers (16- 32- or 64-)
^1da177e4c3f41 Linus Torvalds 2005-04-16   68   * between native CPU format and little/big endian format
^1da177e4c3f41 Linus Torvalds 2005-04-16   69   * 64-bit stuff only defined for proper architectures
^1da177e4c3f41 Linus Torvalds 2005-04-16   70   *	cpu_to_[bl]eXX(__uXX x)
^1da177e4c3f41 Linus Torvalds 2005-04-16   71   *	[bl]eXX_to_cpu(__uXX x)
^1da177e4c3f41 Linus Torvalds 2005-04-16   72   *
^1da177e4c3f41 Linus Torvalds 2005-04-16   73   * The same, but takes a pointer to the value to convert
^1da177e4c3f41 Linus Torvalds 2005-04-16   74   *	cpu_to_[bl]eXXp(__uXX x)
^1da177e4c3f41 Linus Torvalds 2005-04-16   75   *	[bl]eXX_to_cpup(__uXX x)
^1da177e4c3f41 Linus Torvalds 2005-04-16   76   *
^1da177e4c3f41 Linus Torvalds 2005-04-16   77   * The same, but change in situ
^1da177e4c3f41 Linus Torvalds 2005-04-16   78   *	cpu_to_[bl]eXXs(__uXX x)
^1da177e4c3f41 Linus Torvalds 2005-04-16   79   *	[bl]eXX_to_cpus(__uXX x)
^1da177e4c3f41 Linus Torvalds 2005-04-16   80   *
^1da177e4c3f41 Linus Torvalds 2005-04-16   81   * See asm-foo/byteorder.h for examples of how to provide
^1da177e4c3f41 Linus Torvalds 2005-04-16   82   * architecture-optimized versions
^1da177e4c3f41 Linus Torvalds 2005-04-16   83   *
^1da177e4c3f41 Linus Torvalds 2005-04-16   84   */
^1da177e4c3f41 Linus Torvalds 2005-04-16   85  
^1da177e4c3f41 Linus Torvalds 2005-04-16   86  #define cpu_to_le64 __cpu_to_le64
^1da177e4c3f41 Linus Torvalds 2005-04-16   87  #define le64_to_cpu __le64_to_cpu
^1da177e4c3f41 Linus Torvalds 2005-04-16   88  #define cpu_to_le32 __cpu_to_le32
^1da177e4c3f41 Linus Torvalds 2005-04-16  @89  #define le32_to_cpu __le32_to_cpu
^1da177e4c3f41 Linus Torvalds 2005-04-16   90  #define cpu_to_le16 __cpu_to_le16
^1da177e4c3f41 Linus Torvalds 2005-04-16   91  #define le16_to_cpu __le16_to_cpu
^1da177e4c3f41 Linus Torvalds 2005-04-16   92  #define cpu_to_be64 __cpu_to_be64
^1da177e4c3f41 Linus Torvalds 2005-04-16   93  #define be64_to_cpu __be64_to_cpu
^1da177e4c3f41 Linus Torvalds 2005-04-16   94  #define cpu_to_be32 __cpu_to_be32
^1da177e4c3f41 Linus Torvalds 2005-04-16   95  #define be32_to_cpu __be32_to_cpu
^1da177e4c3f41 Linus Torvalds 2005-04-16   96  #define cpu_to_be16 __cpu_to_be16
^1da177e4c3f41 Linus Torvalds 2005-04-16   97  #define be16_to_cpu __be16_to_cpu
^1da177e4c3f41 Linus Torvalds 2005-04-16   98  #define cpu_to_le64p __cpu_to_le64p
^1da177e4c3f41 Linus Torvalds 2005-04-16   99  #define le64_to_cpup __le64_to_cpup
^1da177e4c3f41 Linus Torvalds 2005-04-16  100  #define cpu_to_le32p __cpu_to_le32p
^1da177e4c3f41 Linus Torvalds 2005-04-16  101  #define le32_to_cpup __le32_to_cpup
^1da177e4c3f41 Linus Torvalds 2005-04-16  102  #define cpu_to_le16p __cpu_to_le16p
^1da177e4c3f41 Linus Torvalds 2005-04-16  103  #define le16_to_cpup __le16_to_cpup
^1da177e4c3f41 Linus Torvalds 2005-04-16  104  #define cpu_to_be64p __cpu_to_be64p
^1da177e4c3f41 Linus Torvalds 2005-04-16  105  #define be64_to_cpup __be64_to_cpup
^1da177e4c3f41 Linus Torvalds 2005-04-16  106  #define cpu_to_be32p __cpu_to_be32p
^1da177e4c3f41 Linus Torvalds 2005-04-16  107  #define be32_to_cpup __be32_to_cpup
^1da177e4c3f41 Linus Torvalds 2005-04-16  108  #define cpu_to_be16p __cpu_to_be16p
^1da177e4c3f41 Linus Torvalds 2005-04-16  109  #define be16_to_cpup __be16_to_cpup
^1da177e4c3f41 Linus Torvalds 2005-04-16  110  #define cpu_to_le64s __cpu_to_le64s
^1da177e4c3f41 Linus Torvalds 2005-04-16  111  #define le64_to_cpus __le64_to_cpus
^1da177e4c3f41 Linus Torvalds 2005-04-16  112  #define cpu_to_le32s __cpu_to_le32s
^1da177e4c3f41 Linus Torvalds 2005-04-16  113  #define le32_to_cpus __le32_to_cpus
^1da177e4c3f41 Linus Torvalds 2005-04-16  114  #define cpu_to_le16s __cpu_to_le16s
^1da177e4c3f41 Linus Torvalds 2005-04-16  115  #define le16_to_cpus __le16_to_cpus
^1da177e4c3f41 Linus Torvalds 2005-04-16  116  #define cpu_to_be64s __cpu_to_be64s
^1da177e4c3f41 Linus Torvalds 2005-04-16  117  #define be64_to_cpus __be64_to_cpus
^1da177e4c3f41 Linus Torvalds 2005-04-16  118  #define cpu_to_be32s __cpu_to_be32s
^1da177e4c3f41 Linus Torvalds 2005-04-16  119  #define be32_to_cpus __be32_to_cpus
^1da177e4c3f41 Linus Torvalds 2005-04-16  120  #define cpu_to_be16s __cpu_to_be16s
^1da177e4c3f41 Linus Torvalds 2005-04-16  121  #define be16_to_cpus __be16_to_cpus
^1da177e4c3f41 Linus Torvalds 2005-04-16  122  

:::::: The code at line 89 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 74477 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20200423/afa5a2a2/attachment-0001.bin>
