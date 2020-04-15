From: kbuild test robot <lkp@intel.com>
Date: Wed, 15 Apr 2020 14:16:29 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:rdma 24/25]
 drivers/infiniband/hw/irdma/uk.c:102:14: warning: cast from pointer to
 integer of different size
Message-ID: <202004151418.wyKmEfc0%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Shiraz,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git rdma
head:   4d75d9adac8df983bc733b92711683a7cd7ddd40
commit: f473122f41f69394e29a834fbfcd569dcdd1d879 [24/25] RDMA/irdma: Add irdma Kconfig/Makefile and remove i40iw
config: parisc-allyesconfig (attached as .config)
compiler: hppa-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout f473122f41f69394e29a834fbfcd569dcdd1d879
        # save the attached .config to linux build tree
        GCC_VERSION=9.3.0 make.cross ARCH=parisc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/infiniband/hw/irdma/uk.c: In function 'irdma_clr_wqes':
>> drivers/infiniband/hw/irdma/uk.c:102:14: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
     102 |   wqe_addr = (u64)qp->sq_base->elem + IRDMA_WQE_SIZE_32 * wqe_idx;
         |              ^
>> drivers/infiniband/hw/irdma/uk.c:105:11: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
     105 |    memset((void *)wqe_addr, qp->swqe_polarity ? 0 : 0xFF, 0x1000);
         |           ^
   drivers/infiniband/hw/irdma/uk.c:107:11: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
     107 |    memset((void *)wqe_addr, qp->swqe_polarity ? 0xFF : 0, 0x1000);
         |           ^
--
   drivers/infiniband/hw/irdma/utils.c: In function 'irdma_upload_qp_context':
>> drivers/infiniband/hw/irdma/utils.c:2409:45: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
    2409 |  cqp_info->in.u.qp_upload_context.scratch = (u64)cqp_request;
         |                                             ^
--
   In file included from include/rdma/ib_sa.h:46,
                    from include/rdma/ib_cm.h:13,
                    from include/rdma/iw_cm.h:37,
                    from drivers/infiniband/hw/irdma/verbs.c:10:
   In function 'rdma_gid2ip',
       inlined from 'irdma_detach_mcast' at drivers/infiniband/hw/irdma/verbs.c:4041:2:
>> include/rdma/ib_addr.h:168:3: warning: 'memset' offset [17, 28] from the object at 'sgid_addr' is out of the bounds of referenced subobject 'saddr' with type 'struct sockaddr' at offset 0 [-Warray-bounds]
     168 |   memset(out_in, 0, sizeof(*out_in));
         |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In function 'rdma_gid2ip',
       inlined from 'irdma_create_ah' at drivers/infiniband/hw/irdma/verbs.c:4139:2:
>> include/rdma/ib_addr.h:168:3: warning: 'memset' offset [17, 28] from the object at 'sgid_addr' is out of the bounds of referenced subobject 'saddr' with type 'struct sockaddr' at offset 0 [-Warray-bounds]
     168 |   memset(out_in, 0, sizeof(*out_in));
         |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In function 'rdma_gid2ip',
       inlined from 'irdma_create_ah' at drivers/infiniband/hw/irdma/verbs.c:4140:2:
>> include/rdma/ib_addr.h:168:3: warning: 'memset' offset [17, 28] from the object at 'dgid_addr' is out of the bounds of referenced subobject 'saddr' with type 'struct sockaddr' at offset 0 [-Warray-bounds]
     168 |   memset(out_in, 0, sizeof(*out_in));
         |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In function 'rdma_gid2ip',
       inlined from 'irdma_attach_mcast' at drivers/infiniband/hw/irdma/verbs.c:3902:2:
>> include/rdma/ib_addr.h:168:3: warning: 'memset' offset [17, 28] from the object at 'sgid_addr' is out of the bounds of referenced subobject 'saddr' with type 'struct sockaddr' at offset 0 [-Warray-bounds]
     168 |   memset(out_in, 0, sizeof(*out_in));
         |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

vim +102 drivers/infiniband/hw/irdma/uk.c

fd4e8dc72e602a Mustafa Ismail 2020-03-13   89  
fd4e8dc72e602a Mustafa Ismail 2020-03-13   90  /**
fd4e8dc72e602a Mustafa Ismail 2020-03-13   91   * irdma_clear_wqes - clear next 128 sq entries
fd4e8dc72e602a Mustafa Ismail 2020-03-13   92   * @qp: hw qp ptr
fd4e8dc72e602a Mustafa Ismail 2020-03-13   93   * @qp_wqe_idx: wqe_idx
fd4e8dc72e602a Mustafa Ismail 2020-03-13   94   */
fd4e8dc72e602a Mustafa Ismail 2020-03-13   95  void irdma_clr_wqes(struct irdma_qp_uk *qp, u32 qp_wqe_idx)
fd4e8dc72e602a Mustafa Ismail 2020-03-13   96  {
fd4e8dc72e602a Mustafa Ismail 2020-03-13   97  	u64 wqe_addr;
fd4e8dc72e602a Mustafa Ismail 2020-03-13   98  	u32 wqe_idx;
fd4e8dc72e602a Mustafa Ismail 2020-03-13   99  
fd4e8dc72e602a Mustafa Ismail 2020-03-13  100  	if (!(qp_wqe_idx & 0x7F)) {
fd4e8dc72e602a Mustafa Ismail 2020-03-13  101  		wqe_idx = (qp_wqe_idx + 128) % qp->sq_ring.size;
fd4e8dc72e602a Mustafa Ismail 2020-03-13 @102  		wqe_addr = (u64)qp->sq_base->elem + IRDMA_WQE_SIZE_32 * wqe_idx;
fd4e8dc72e602a Mustafa Ismail 2020-03-13  103  
fd4e8dc72e602a Mustafa Ismail 2020-03-13  104  		if (wqe_idx)
fd4e8dc72e602a Mustafa Ismail 2020-03-13 @105  			memset((void *)wqe_addr, qp->swqe_polarity ? 0 : 0xFF, 0x1000);
fd4e8dc72e602a Mustafa Ismail 2020-03-13  106  		else
fd4e8dc72e602a Mustafa Ismail 2020-03-13  107  			memset((void *)wqe_addr, qp->swqe_polarity ? 0xFF : 0, 0x1000);
fd4e8dc72e602a Mustafa Ismail 2020-03-13  108  	}
fd4e8dc72e602a Mustafa Ismail 2020-03-13  109  }
fd4e8dc72e602a Mustafa Ismail 2020-03-13  110  

:::::: The code at line 102 was first introduced by commit
:::::: fd4e8dc72e602abd9a22237d13d9b5ce7e8033a8 RDMA/irdma: Add user/kernel shared libraries

:::::: TO: Mustafa Ismail <mustafa.ismail@intel.com>
:::::: CC: Jeff Kirsher <jeffrey.t.kirsher@intel.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 61277 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20200415/05d2c319/attachment-0001.bin>
