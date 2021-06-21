From: kernel test robot <lkp@intel.com>
Date: Mon, 21 Jun 2021 19:28:07 +0800
Subject: [Intel-wired-lan] [PATCH net-next v1] iavf: Add trace while
 removing device
In-Reply-To: <1624263000-8709-1-git-send-email-jedrzej.jagielski@intel.com>
References: <1624263000-8709-1-git-send-email-jedrzej.jagielski@intel.com>
Message-ID: <202106211913.DugmZi6d-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi "J?drzej,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on net-next/master]

url:    https://github.com/0day-ci/linux/commits/J-drzej-Jagielski/iavf-Add-trace-while-removing-device/20210621-161419
base:   https://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git adc2e56ebe6377f5c032d96aee0feac30a640453
config: x86_64-randconfig-a012-20210621 (attached as .config)
compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project e1adf90826a57b674eee79b071fb46c1f5683cd0)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install x86_64 cross compiling tool for clang build
        # apt-get install binutils-x86-64-linux-gnu
        # https://github.com/0day-ci/linux/commit/57afb781e6da71b3eb1c32b7485adf57de789a1b
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review J-drzej-Jagielski/iavf-Add-trace-while-removing-device/20210621-161419
        git checkout 57afb781e6da71b3eb1c32b7485adf57de789a1b
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=x86_64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/x86/Makefile:148: CONFIG_X86_X32 enabled but no binutils support
>> make[2]: *** No rule to make target '/tmp/kernel/x86_64-randconfig-a012-20210621/clang-13/57afb781e6da71b3eb1c32b7485adf57de789a1b/lib/modules/5.13.0-rc6+/kernel/crypto/cmac.ko', needed by '__modinst'.
>> make[2]: *** No rule to make target '/tmp/kernel/x86_64-randconfig-a012-20210621/clang-13/57afb781e6da71b3eb1c32b7485adf57de789a1b/lib/modules/5.13.0-rc6+/kernel/crypto/md5.ko', needed by '__modinst'.
>> make[2]: *** No rule to make target '/tmp/kernel/x86_64-randconfig-a012-20210621/clang-13/57afb781e6da71b3eb1c32b7485adf57de789a1b/lib/modules/5.13.0-rc6+/kernel/crypto/sha512_generic.ko', needed by '__modinst'.
>> make[2]: *** No rule to make target '/tmp/kernel/x86_64-randconfig-a012-20210621/clang-13/57afb781e6da71b3eb1c32b7485adf57de789a1b/lib/modules/5.13.0-rc6+/kernel/drivers/net/net_failover.ko', needed by '__modinst'.
>> make[2]: *** No rule to make target '/tmp/kernel/x86_64-randconfig-a012-20210621/clang-13/57afb781e6da71b3eb1c32b7485adf57de789a1b/lib/modules/5.13.0-rc6+/kernel/drivers/net/virtio_net.ko', needed by '__modinst'.
>> make[2]: *** No rule to make target '/tmp/kernel/x86_64-randconfig-a012-20210621/clang-13/57afb781e6da71b3eb1c32b7485adf57de789a1b/lib/modules/5.13.0-rc6+/kernel/fs/cifs/cifs.ko', needed by '__modinst'.
>> make[2]: *** No rule to make target '/tmp/kernel/x86_64-randconfig-a012-20210621/clang-13/57afb781e6da71b3eb1c32b7485adf57de789a1b/lib/modules/5.13.0-rc6+/kernel/fs/nfs/nfsv4.ko', needed by '__modinst'.
>> make[2]: *** No rule to make target '/tmp/kernel/x86_64-randconfig-a012-20210621/clang-13/57afb781e6da71b3eb1c32b7485adf57de789a1b/lib/modules/5.13.0-rc6+/kernel/lib/crypto/libarc4.ko', needed by '__modinst'.
>> make[2]: *** No rule to make target '/tmp/kernel/x86_64-randconfig-a012-20210621/clang-13/57afb781e6da71b3eb1c32b7485adf57de789a1b/lib/modules/5.13.0-rc6+/kernel/net/core/failover.ko', needed by '__modinst'.
>> make[2]: *** No rule to make target '/tmp/kernel/x86_64-randconfig-a012-20210621/clang-13/57afb781e6da71b3eb1c32b7485adf57de789a1b/lib/modules/5.13.0-rc6+/kernel/net/dns_resolver/dns_resolver.ko', needed by '__modinst'.
>> make[2]: *** No rule to make target '/tmp/kernel/x86_64-randconfig-a012-20210621/clang-13/57afb781e6da71b3eb1c32b7485adf57de789a1b/lib/modules/5.13.0-rc6+/kernel/net/sunrpc/auth_gss/auth_rpcgss.ko', needed by '__modinst'.
   make[2]: Target '__modinst' not remade because of errors.
   make[1]: *** [Makefile:1773: modules_install] Error 2
   make: *** [Makefile:215: __sub-make] Error 2
   make: Target 'modules_install' not remade because of errors.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 48805 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20210621/1a0e4829/attachment-0001.bin>
