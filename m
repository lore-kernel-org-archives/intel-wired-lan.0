From: kernel test robot <lkp@intel.com>
Date: Sat, 20 Mar 2021 12:36:46 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue 80/146]
 drivers/net/ethernet/intel/iavf/iavf_fdir.c:399: warning: expecting
 prototype for iavf_fdir_fltr_by_loc(). Prototype was for
 iavf_find_fdir_fltr_by_loc() instead
Message-ID: <202103201241.6gr60mZl-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
head:   8138882557813215cdad24e43c85f516ff251071
commit: b9dbeca97148c104a046de16806742f74dba93ab [80/146] iavf: Support IPv4 Flow Director filters
config: ia64-allmodconfig (attached as .config)
compiler: ia64-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git/commit/?id=b9dbeca97148c104a046de16806742f74dba93ab
        git remote add tnguy-next-queue https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git
        git fetch --no-tags tnguy-next-queue dev-queue
        git checkout b9dbeca97148c104a046de16806742f74dba93ab
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=ia64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/intel/iavf/iavf_fdir.c:399: warning: expecting prototype for iavf_fdir_fltr_by_loc(). Prototype was for iavf_find_fdir_fltr_by_loc() instead

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for FRAME_POINTER
   Depends on DEBUG_KERNEL && (M68K || UML || SUPERH) || ARCH_WANT_FRAME_POINTERS
   Selected by
   - FAULT_INJECTION_STACKTRACE_FILTER && FAULT_INJECTION_DEBUG_FS && STACKTRACE_SUPPORT && !X86_64 && !MIPS && !PPC && !S390 && !MICROBLAZE && !ARM && !ARC && !X86


vim +399 drivers/net/ethernet/intel/iavf/iavf_fdir.c

   390	
   391	/**
   392	 * iavf_fdir_fltr_by_loc - find filter with location
   393	 * @adapter: pointer to the VF adapter structure
   394	 * @loc: location to find.
   395	 *
   396	 * Returns pointer to Flow Director filter if found or null
   397	 */
   398	struct iavf_fdir_fltr *iavf_find_fdir_fltr_by_loc(struct iavf_adapter *adapter, u32 loc)
 > 399	{
   400		struct iavf_fdir_fltr *rule;
   401	
   402		list_for_each_entry(rule, &adapter->fdir_list_head, list)
   403			if (rule->loc == loc)
   404				return rule;
   405	
   406		return NULL;
   407	}
   408	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 63844 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20210320/d2bfdcc8/attachment-0001.bin>
