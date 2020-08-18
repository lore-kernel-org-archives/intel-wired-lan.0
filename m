From: kernel test robot <lkp@intel.com>
Date: Tue, 18 Aug 2020 12:33:43 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 8/52]
 include/linux/prefetch.h:65:49: error: declaration of 'struct page' will
 not be visible outside of this function
Message-ID: <202008181242.BQpCIErV%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   e5a10a0b92ece69461f51d038ca6a34d96f340d0
commit: cb1bd37680e5a58b8e65e53dc5a4ddb4686ef3ea [8/52] i40e: optimise prefetch page refcount
config: arm-randconfig-r024-20200818 (attached as .config)
compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project 790878f291fa5dc58a1c560cb6cc76fd1bfd1c5a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        git checkout cb1bd37680e5a58b8e65e53dc5a4ddb4686ef3ea
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=arm 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/gpu/drm/tilcdc/tilcdc_plane.c:7:
   In file included from include/drm/drm_atomic.h:31:
   In file included from include/drm/drm_crtc.h:28:
   In file included from include/linux/i2c.h:13:
   In file included from include/linux/acpi.h:13:
   In file included from include/linux/irqdomain.h:35:
   In file included from include/linux/of.h:15:
   In file included from include/linux/bitops.h:29:
   In file included from arch/arm/include/asm/bitops.h:243:
   In file included from include/asm-generic/bitops/lock.h:5:
   In file included from include/linux/atomic.h:7:
   In file included from arch/arm/include/asm/atomic.h:12:
>> include/linux/prefetch.h:65:49: error: declaration of 'struct page' will not be visible outside of this function [-Werror,-Wvisibility]
   static inline void prefetch_page_address(struct page *page)
                                                   ^
   1 error generated.

# https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git/commit/?id=cb1bd37680e5a58b8e65e53dc5a4ddb4686ef3ea
git remote add jkirsher-next-queue https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git
git fetch --no-tags jkirsher-next-queue dev-queue
git checkout cb1bd37680e5a58b8e65e53dc5a4ddb4686ef3ea
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
Size: 30907 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20200818/d70c2cfd/attachment-0001.bin>
