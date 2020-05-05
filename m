From: kbuild test robot <lkp@intel.com>
Date: Tue, 5 May 2020 19:33:22 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 10/75] ld.lld:
 error: undefined symbol: virtbus_unregister_device
Message-ID: <202005051920.uc4Rgk0Y%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   4726c14e382081e483d53a9721d8b986f52a6e3d
commit: 2f24a6c0cdb103269564c920882739033466e389 [10/75] ice: Create and register virtual bus for RDMA
config: x86_64-randconfig-e002-20200502 (attached as .config)
compiler: clang version 11.0.0 (https://github.com/llvm/llvm-project 30ddd4ce19316fd2a8a50c5bc511433c87ecb95c)
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install x86_64 cross compiling tool for clang build
        # apt-get install binutils-x86-64-linux-gnu
        git checkout 2f24a6c0cdb103269564c920882739033466e389
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=x86_64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: virtbus_unregister_device
   >>> referenced by ice_idc.c:195 (drivers/net/ethernet/intel/ice/ice_idc.c:195)
   >>> net/ethernet/intel/ice/ice_idc.o:(ice_unreg_peer_device) in archive drivers/built-in.a
--
>> ld.lld: error: undefined symbol: virtbus_register_device
   >>> referenced by ice_idc.c:390 (drivers/net/ethernet/intel/ice/ice_idc.c:390)
   >>> net/ethernet/intel/ice/ice_idc.o:(ice_init_peer_devices) in archive drivers/built-in.a

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 29243 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20200505/f6dea8eb/attachment-0001.bin>
