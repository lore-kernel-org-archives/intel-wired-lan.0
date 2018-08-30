From: kbuild test robot <lkp@intel.com>
Date: Fri, 31 Aug 2018 07:40:51 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:40GbE 2/15]
 drivers/net/ethernet/intel/i40e/i40e_ethtool_stats.h:193:20: error:
 function '__i40e_add_stat_strings' can never be inlined because it uses
 variable argument lists
Message-ID: <201808310748.IfcJF3Zx%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git 40GbE
head:   5907cf6c5bbe78be2ed18b875b316c6028b20634
commit: 8fd75c58a09a571543b5b61e49171bb3a1d88c19 [2/15] i40e: move ethtool stats boiler plate code to i40e_ethtool_stats.h
config: xtensa-allmodconfig (attached as .config)
compiler: xtensa-linux-gcc (GCC) 8.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 8fd75c58a09a571543b5b61e49171bb3a1d88c19
        # save the attached .config to linux build tree
        GCC_VERSION=8.1.0 make.cross ARCH=xtensa 

All errors (new ones prefixed by >>):

   drivers/net/usb/rtl8150.c:30: warning: "RSR" redefined
    #define RSR   0x0133
    
   In file included from arch/xtensa/include/asm/bitops.h:22,
                    from include/linux/bitops.h:19,
                    from include/linux/kernel.h:11,
                    from include/asm-generic/bug.h:18,
                    from ./arch/xtensa/include/generated/asm/bug.h:1,
                    from include/linux/bug.h:5,
                    from include/linux/signal.h:5,
                    from drivers/net/usb/rtl8150.c:9:
   arch/xtensa/include/asm/processor.h:220: note: this is the location of the previous definition
    #define RSR(v,sr) __asm__ __volatile__ ("rsr %0,"__stringify(sr) : "=a"(v));
    
   In file included from drivers/net/ethernet/intel/i40e/i40e_ethtool.c:9:
   drivers/net/ethernet/intel/i40e/i40e_ethtool.c: In function '__i40e_add_stat_strings':
>> drivers/net/ethernet/intel/i40e/i40e_ethtool_stats.h:193:20: error: function '__i40e_add_stat_strings' can never be inlined because it uses variable argument lists
    static inline void __i40e_add_stat_strings(u8 **p, const struct i40e_stats stats[],
                       ^~~~~~~~~~~~~~~~~~~~~~~
   make[6]: *** [drivers/net/ethernet/intel/i40e/i40e_ethtool.o] Error 1
   In file included from arch/xtensa/include/asm/atomic.h:21,
                    from include/linux/atomic.h:7,
                    from include/asm-generic/bitops/atomic.h:5,
                    from arch/xtensa/include/asm/bitops.h:222,
                    from include/linux/bitops.h:19,
                    from drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c:11:
   drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c: In function 'ixgbevf_xdp_setup':
   arch/xtensa/include/asm/cmpxchg.h:139:3: warning: value computed is not used [-Wunused-value]
     ((__typeof__(*(ptr)))__xchg((unsigned long)(x),(ptr),sizeof(*(ptr))))
     ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c:4483:4: note: in expansion of macro 'xchg'
       xchg(&adapter->rx_ring[i]->xdp_prog, adapter->xdp_prog);
       ^~~~
   drivers/net/ethernet/microchip/lan743x_main.c:2987:12: warning: 'lan743x_pm_resume' defined but not used [-Wunused-function]
    static int lan743x_pm_resume(struct device *dev)
               ^~~~~~~~~~~~~~~~~
   drivers/net/ethernet/microchip/lan743x_main.c:2964:12: warning: 'lan743x_pm_suspend' defined but not used [-Wunused-function]
    static int lan743x_pm_suspend(struct device *dev)
               ^~~~~~~~~~~~~~~~~~
   make[6]: Target '__build' not remade because of errors.
   make[5]: *** [drivers/net/ethernet/intel/i40e] Error 2
   make[5]: Target '__build' not remade because of errors.
   make[4]: *** [drivers/net/ethernet/intel] Error 2
   In file included from drivers/scsi/sym53c8xx_2/sym_glue.h:64,
                    from drivers/scsi/sym53c8xx_2/sym_fw.c:40:
   drivers/scsi/sym53c8xx_2/sym_defs.h:109: warning: "WSR" redefined
     #define   WSR     0x01  /* sta: wide scsi received       [W]*/
    
   In file included from arch/xtensa/include/asm/bitops.h:22,
                    from include/linux/bitops.h:19,
                    from include/linux/kernel.h:11,
                    from include/linux/list.h:9,
                    from include/linux/wait.h:7,
                    from include/linux/completion.h:12,
                    from drivers/scsi/sym53c8xx_2/sym_glue.h:43,
                    from drivers/scsi/sym53c8xx_2/sym_fw.c:40:
   arch/xtensa/include/asm/processor.h:219: note: this is the location of the previous definition
    #define WSR(v,sr) __asm__ __volatile__ ("wsr %0,"__stringify(sr) :: "a"(v));
    
   In file included from drivers/scsi/sym53c8xx_2/sym_glue.h:64,
                    from drivers/scsi/sym53c8xx_2/sym_glue.c:50:
   drivers/scsi/sym53c8xx_2/sym_defs.h:109: warning: "WSR" redefined
     #define   WSR     0x01  /* sta: wide scsi received       [W]*/
    
   In file included from arch/xtensa/include/asm/bitops.h:22,
                    from include/linux/bitops.h:19,
                    from include/linux/kernel.h:11,
                    from include/linux/list.h:9,
                    from include/linux/module.h:9,
                    from drivers/scsi/sym53c8xx_2/sym_glue.c:42:
   arch/xtensa/include/asm/processor.h:219: note: this is the location of the previous definition
    #define WSR(v,sr) __asm__ __volatile__ ("wsr %0,"__stringify(sr) :: "a"(v));
    
   In file included from drivers/scsi/sym53c8xx_2/sym_glue.h:64,
                    from drivers/scsi/sym53c8xx_2/sym_hipd.c:44:
   drivers/scsi/sym53c8xx_2/sym_defs.h:109: warning: "WSR" redefined
     #define   WSR     0x01  /* sta: wide scsi received       [W]*/
    
   In file included from arch/xtensa/include/asm/bitops.h:22,
                    from include/linux/bitops.h:19,
                    from include/linux/kernel.h:11,
                    from include/asm-generic/bug.h:18,
                    from ./arch/xtensa/include/generated/asm/bug.h:1,
                    from include/linux/bug.h:5,
                    from include/linux/mmdebug.h:5,
                    from include/linux/gfp.h:5,
                    from include/linux/slab.h:15,
                    from drivers/scsi/sym53c8xx_2/sym_hipd.c:41:
   arch/xtensa/include/asm/processor.h:219: note: this is the location of the previous definition
    #define WSR(v,sr) __asm__ __volatile__ ("wsr %0,"__stringify(sr) :: "a"(v));
    
   In file included from drivers/scsi/sym53c8xx_2/sym_glue.h:64,
                    from drivers/scsi/sym53c8xx_2/sym_malloc.c:40:
   drivers/scsi/sym53c8xx_2/sym_defs.h:109: warning: "WSR" redefined
     #define   WSR     0x01  /* sta: wide scsi received       [W]*/
    
   In file included from arch/xtensa/include/asm/bitops.h:22,
                    from include/linux/bitops.h:19,
                    from include/linux/kernel.h:11,
                    from include/linux/list.h:9,
                    from include/linux/wait.h:7,
                    from include/linux/completion.h:12,
                    from drivers/scsi/sym53c8xx_2/sym_glue.h:43,
                    from drivers/scsi/sym53c8xx_2/sym_malloc.c:40:
   arch/xtensa/include/asm/processor.h:219: note: this is the location of the previous definition
    #define WSR(v,sr) __asm__ __volatile__ ("wsr %0,"__stringify(sr) :: "a"(v));
    
   In file included from drivers/scsi/sym53c8xx_2/sym_glue.h:64,
                    from drivers/scsi/sym53c8xx_2/sym_nvram.c:40:
   drivers/scsi/sym53c8xx_2/sym_defs.h:109: warning: "WSR" redefined
     #define   WSR     0x01  /* sta: wide scsi received       [W]*/
    
   In file included from arch/xtensa/include/asm/bitops.h:22,
                    from include/linux/bitops.h:19,
                    from include/linux/kernel.h:11,
                    from include/linux/list.h:9,
                    from include/linux/wait.h:7,

vim +/__i40e_add_stat_strings +193 drivers/net/ethernet/intel/i40e/i40e_ethtool_stats.h

   183	
   184	/**
   185	 * __i40e_add_stat_strings - copy stat strings into ethtool buffer
   186	 * @p: ethtool supplied buffer
   187	 * @stats: stat definitions array
   188	 * @size: size of the stats array
   189	 *
   190	 * Format and copy the strings described by stats into the buffer pointed at
   191	 * by p.
   192	 **/
 > 193	static inline void __i40e_add_stat_strings(u8 **p, const struct i40e_stats stats[],
   194					    const unsigned int size, ...)
   195	{
   196		unsigned int i;
   197	
   198		for (i = 0; i < size; i++) {
   199			va_list args;
   200	
   201			va_start(args, size);
   202			vsnprintf(*p, ETH_GSTRING_LEN, stats[i].stat_string, args);
   203			*p += ETH_GSTRING_LEN;
   204			va_end(args);
   205		}
   206	}
   207	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 54962 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20180831/9c5e6aa3/attachment-0001.bin>
