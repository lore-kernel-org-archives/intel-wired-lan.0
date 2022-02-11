From: kernel test robot <lkp@intel.com>
Date: Sat, 12 Feb 2022 06:04:51 +0800
Subject: [Intel-wired-lan] [tnguy-net-queue:dev-queue 21/44]
 net/netfilter/xt_socket.c:224:17: error: implicit declaration of function
 'nf_defrag_ipv6_disable'; did you mean 'nf_defrag_ipv4_disable'?
Message-ID: <202202120545.c2k6AbiS-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git dev-queue
head:   d35ad64359ca21540d9bf84b4bb072ca21b2f4ac
commit: 75063c9294fb239bbe64eb72141b6871fe526d29 [21/44] netfilter: xt_socket: fix a typo in socket_mt_destroy()
config: sparc-randconfig-s031-20220211 (https://download.01.org/0day-ci/archive/20220212/202202120545.c2k6AbiS-lkp at intel.com/config)
compiler: sparc-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git/commit/?id=75063c9294fb239bbe64eb72141b6871fe526d29
        git remote add tnguy-net-queue https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git
        git fetch --no-tags tnguy-net-queue dev-queue
        git checkout 75063c9294fb239bbe64eb72141b6871fe526d29
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=sparc SHELL=/bin/bash net/netfilter/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   net/netfilter/xt_socket.c: In function 'socket_mt_destroy':
>> net/netfilter/xt_socket.c:224:17: error: implicit declaration of function 'nf_defrag_ipv6_disable'; did you mean 'nf_defrag_ipv4_disable'? [-Werror=implicit-function-declaration]
     224 |                 nf_defrag_ipv6_disable(par->net);
         |                 ^~~~~~~~~~~~~~~~~~~~~~
         |                 nf_defrag_ipv4_disable
   cc1: some warnings being treated as errors


vim +224 net/netfilter/xt_socket.c

   218	
   219	static void socket_mt_destroy(const struct xt_mtdtor_param *par)
   220	{
   221		if (par->family == NFPROTO_IPV4)
   222			nf_defrag_ipv4_disable(par->net);
   223		else if (par->family == NFPROTO_IPV6)
 > 224			nf_defrag_ipv6_disable(par->net);
   225	}
   226	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
