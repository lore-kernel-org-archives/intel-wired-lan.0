From: kbuild test robot <lkp@intel.com>
Date: Wed, 15 Apr 2020 14:42:15 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:rdma 24/25]
 arch/sparc/include/asm/string.h:18:29: warning: '__builtin_memset' offset
 [17,
 28] from the object at 'sgid_addr' is out of the bounds of referenced
 subobject 'saddr' with type 'struct sockaddr' at offset 0
Message-ID: <202004151456.1oH8ZKwz%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git rdma
head:   4d75d9adac8df983bc733b92711683a7cd7ddd40
commit: f473122f41f69394e29a834fbfcd569dcdd1d879 [24/25] RDMA/irdma: Add irdma Kconfig/Makefile and remove i40iw
config: sparc-allyesconfig (attached as .config)
compiler: sparc64-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout f473122f41f69394e29a834fbfcd569dcdd1d879
        # save the attached .config to linux build tree
        GCC_VERSION=9.3.0 make.cross ARCH=sparc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/string.h:20,
                    from include/linux/bitmap.h:9,
                    from include/linux/cpumask.h:12,
                    from include/linux/rcupdate.h:31,
                    from include/linux/rculist.h:11,
                    from include/linux/dcache.h:7,
                    from include/linux/fs.h:8,
                    from include/linux/highmem.h:5,
                    from drivers/infiniband/hw/irdma/verbs.c:4:
   In function 'rdma_gid2ip',
       inlined from 'irdma_detach_mcast' at drivers/infiniband/hw/irdma/verbs.c:4041:2:
>> arch/sparc/include/asm/string.h:18:29: warning: '__builtin_memset' offset [17, 28] from the object at 'sgid_addr' is out of the bounds of referenced subobject 'saddr' with type 'struct sockaddr' at offset 0 [-Warray-bounds]
      18 | #define memset(s, c, count) __builtin_memset(s, c, count)
         |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/rdma/ib_addr.h:168:3: note: in expansion of macro 'memset'
     168 |   memset(out_in, 0, sizeof(*out_in));
         |   ^~~~~~
   In function 'rdma_gid2ip',
       inlined from 'irdma_attach_mcast' at drivers/infiniband/hw/irdma/verbs.c:3902:2:
>> arch/sparc/include/asm/string.h:18:29: warning: '__builtin_memset' offset [17, 28] from the object at 'sgid_addr' is out of the bounds of referenced subobject 'saddr' with type 'struct sockaddr' at offset 0 [-Warray-bounds]
      18 | #define memset(s, c, count) __builtin_memset(s, c, count)
         |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/rdma/ib_addr.h:168:3: note: in expansion of macro 'memset'
     168 |   memset(out_in, 0, sizeof(*out_in));
         |   ^~~~~~
   In function 'rdma_gid2ip',
       inlined from 'irdma_create_ah' at drivers/infiniband/hw/irdma/verbs.c:4139:2:
>> arch/sparc/include/asm/string.h:18:29: warning: '__builtin_memset' offset [17, 28] from the object at 'sgid_addr' is out of the bounds of referenced subobject 'saddr' with type 'struct sockaddr' at offset 0 [-Warray-bounds]
      18 | #define memset(s, c, count) __builtin_memset(s, c, count)
         |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/rdma/ib_addr.h:168:3: note: in expansion of macro 'memset'
     168 |   memset(out_in, 0, sizeof(*out_in));
         |   ^~~~~~
   In function 'rdma_gid2ip',
       inlined from 'irdma_create_ah' at drivers/infiniband/hw/irdma/verbs.c:4140:2:
>> arch/sparc/include/asm/string.h:18:29: warning: '__builtin_memset' offset [17, 28] from the object at 'dgid_addr' is out of the bounds of referenced subobject 'saddr' with type 'struct sockaddr' at offset 0 [-Warray-bounds]
      18 | #define memset(s, c, count) __builtin_memset(s, c, count)
         |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/rdma/ib_addr.h:168:3: note: in expansion of macro 'memset'
     168 |   memset(out_in, 0, sizeof(*out_in));
         |   ^~~~~~

vim +18 arch/sparc/include/asm/string.h

70a6fcf3283a0ac Al Viro 2016-01-17  16  
70a6fcf3283a0ac Al Viro 2016-01-17  17  #define __HAVE_ARCH_MEMSET
70a6fcf3283a0ac Al Viro 2016-01-17 @18  #define memset(s, c, count) __builtin_memset(s, c, count)
70a6fcf3283a0ac Al Viro 2016-01-17  19  

:::::: The code at line 18 was first introduced by commit
:::::: 70a6fcf3283a0ac1e11737c6d90c0753f9824e9d [sparc] unify 32bit and 64bit string.h

:::::: TO: Al Viro <viro@zeniv.linux.org.uk>
:::::: CC: Al Viro <viro@zeniv.linux.org.uk>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 62075 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20200415/07b19f32/attachment-0001.bin>
