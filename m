From: kbuild test robot <lkp@intel.com>
Date: Wed, 23 Dec 2015 18:35:05 +0800
Subject: [Intel-wired-lan] [PATCH 1/2] PCI: Add mechanism to find
	topologically near cores
In-Reply-To: <1450864901-16712-1-git-send-email-daniel@numascale.com>
Message-ID: <201512231825.hxgFRM0V%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Daniel,

[auto build test WARNING on pci/next]
[also build test WARNING on v4.4-rc6 next-20151223]

url:    https://github.com/0day-ci/linux/commits/Daniel-J-Blueman/PCI-Add-mechanism-to-find-topologically-near-cores/20151223-181947
base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
config: s390-allyesconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=s390 

Note: it may well be a FALSE warning. FWIW you are at least aware of it now.

All warnings (new ones prefixed by >>):

   In file included from include/linux/smp.h:12:0,
                    from arch/s390/include/asm/spinlock.h:12,
                    from include/linux/spinlock.h:87,
                    from include/linux/rcupdate.h:38,
                    from include/linux/idr.h:18,
                    from include/linux/kernfs.h:14,
                    from include/linux/sysfs.h:15,
                    from include/linux/kobject.h:21,
                    from include/linux/of.h:21,
                    from drivers/pci/pci.c:13:
   drivers/pci/pci.c: In function 'cpu_near_dev':
>> include/linux/cpumask.h:174:9: warning: array subscript is below array bounds [-Warray-bounds]
     return find_first_bit(cpumask_bits(srcp), nr_cpumask_bits);
            ^

vim +174 include/linux/cpumask.h

da91309e Amir Vadai       2014-06-09  158  
2d3854a3 Rusty Russell    2008-11-05  159  #define for_each_cpu(cpu, mask)			\
2d3854a3 Rusty Russell    2008-11-05  160  	for ((cpu) = 0; (cpu) < 1; (cpu)++, (void)mask)
8bd93a2c Paul E. McKenney 2010-02-22  161  #define for_each_cpu_not(cpu, mask)		\
8bd93a2c Paul E. McKenney 2010-02-22  162  	for ((cpu) = 0; (cpu) < 1; (cpu)++, (void)mask)
2d3854a3 Rusty Russell    2008-11-05  163  #define for_each_cpu_and(cpu, mask, and)	\
2d3854a3 Rusty Russell    2008-11-05  164  	for ((cpu) = 0; (cpu) < 1; (cpu)++, (void)mask, (void)and)
2d3854a3 Rusty Russell    2008-11-05  165  #else
2d3854a3 Rusty Russell    2008-11-05  166  /**
2d3854a3 Rusty Russell    2008-11-05  167   * cpumask_first - get the first cpu in a cpumask
2d3854a3 Rusty Russell    2008-11-05  168   * @srcp: the cpumask pointer
2d3854a3 Rusty Russell    2008-11-05  169   *
2d3854a3 Rusty Russell    2008-11-05  170   * Returns >= nr_cpu_ids if no cpus set.
2d3854a3 Rusty Russell    2008-11-05  171   */
2d3854a3 Rusty Russell    2008-11-05  172  static inline unsigned int cpumask_first(const struct cpumask *srcp)
2d3854a3 Rusty Russell    2008-11-05  173  {
2d3854a3 Rusty Russell    2008-11-05 @174  	return find_first_bit(cpumask_bits(srcp), nr_cpumask_bits);
2d3854a3 Rusty Russell    2008-11-05  175  }
2d3854a3 Rusty Russell    2008-11-05  176  
2d3854a3 Rusty Russell    2008-11-05  177  /**
2d3854a3 Rusty Russell    2008-11-05  178   * cpumask_next - get the next cpu in a cpumask
2d3854a3 Rusty Russell    2008-11-05  179   * @n: the cpu prior to the place to search (ie. return will be > @n)
2d3854a3 Rusty Russell    2008-11-05  180   * @srcp: the cpumask pointer
2d3854a3 Rusty Russell    2008-11-05  181   *
2d3854a3 Rusty Russell    2008-11-05  182   * Returns >= nr_cpu_ids if no further cpus set.

:::::: The code at line 174 was first introduced by commit
:::::: 2d3854a37e8b767a51aba38ed6d22817b0631e33 cpumask: introduce new API, without changing anything

:::::: TO: Rusty Russell <rusty@rustcorp.com.au>
:::::: CC: Ingo Molnar <mingo@elte.hu>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 39398 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20151223/58a0bb3e/attachment-0001.obj>
