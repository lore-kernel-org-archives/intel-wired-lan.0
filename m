From: kernel test robot <lkp@intel.com>
Date: Wed, 16 Jun 2021 23:02:59 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue 21/87]
 drivers/net/ethernet/intel/iavf/iavf_main.c:145: warning: expecting
 prototype for iavf_timeout(). Prototype was for iavf_lock_timeout() instead
Message-ID: <202106162344.e25gZHvx-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
head:   209f51a407348729203cd6e319e17c5c507f662e
commit: 8fd81228faf637f04de07b802fa6684044c97dda [21/87] iavf: fix locking of critical sections
config: powerpc64-randconfig-r035-20210616 (attached as .config)
compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project 64720f57bea6a6bf033feef4a5751ab9c0c3b401)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install powerpc64 cross compiling tool for clang build
        # apt-get install binutils-powerpc64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git/commit/?id=8fd81228faf637f04de07b802fa6684044c97dda
        git remote add tnguy-next-queue https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git
        git fetch --no-tags tnguy-next-queue dev-queue
        git checkout 8fd81228faf637f04de07b802fa6684044c97dda
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=powerpc64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/intel/iavf/iavf_main.c:145: warning: expecting prototype for iavf_timeout(). Prototype was for iavf_lock_timeout() instead


vim +145 drivers/net/ethernet/intel/iavf/iavf_main.c

   133	
   134	/**
   135	 * iavf_timeout - try to set bit but give up after timeout
   136	 * @adapter: board private structure
   137	 * @bit: bit to set
   138	 * @msecs: timeout in msecs
   139	 *
   140	 * Returns 0 on success, negative on failure
   141	 **/
   142	static inline int iavf_lock_timeout(struct iavf_adapter *adapter,
   143					    enum iavf_critical_section_t bit,
   144					    unsigned int msecs)
 > 145	{
   146		unsigned int wait, delay = 10;
   147	
   148		for (wait = 0; wait < msecs; wait += delay) {
   149			if (!test_and_set_bit(bit, &adapter->crit_section))
   150				return 0;
   151	
   152			msleep(delay);
   153		}
   154	
   155		return -1;
   156	}
   157	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 31362 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20210616/cd971209/attachment-0001.bin>
