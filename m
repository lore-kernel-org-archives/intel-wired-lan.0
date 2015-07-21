From: kbuild test robot <fengguang.wu@intel.com>
Date: Tue, 21 Jul 2015 21:03:13 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:master 71/77]
 include/linux/rcupdate.h:901:9: sparse: context imbalance in
 'test_rht_lookup' - unexpected unlock
Message-ID: <201507212109.Kju3bOib%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git master
head:   2070c48cf2b78af89ba529c00992eaaa18df8ef7
commit: 685a015e44dcd4db50ada60a9a2806659c165d9e [71/77] rhashtable: Allow other tasks to be scheduled in large lookup loops
reproduce:
  # apt-get install sparse
  git checkout 685a015e44dcd4db50ada60a9a2806659c165d9e
  make ARCH=x86_64 allmodconfig
  make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> include/linux/rcupdate.h:901:9: sparse: context imbalance in 'test_rht_lookup' - unexpected unlock
   lib/test_rhashtable.c:98:13: sparse: context imbalance in 'test_bucket_stats' - different lock contexts for basic block

vim +/test_rht_lookup +901 include/linux/rcupdate.h

f27bc4873 Paul E. McKenney 2014-05-04  885   * that that preemption never happens within any RCU read-side critical
f27bc4873 Paul E. McKenney 2014-05-04  886   * section whose outermost rcu_read_unlock() is called with irqs disabled.
f27bc4873 Paul E. McKenney 2014-05-04  887   * This approach relies on the fact that rt_mutex_unlock() currently only
f27bc4873 Paul E. McKenney 2014-05-04  888   * acquires irq-disabled locks.
f27bc4873 Paul E. McKenney 2014-05-04  889   *
f27bc4873 Paul E. McKenney 2014-05-04  890   * The second of these two approaches is best in most situations,
f27bc4873 Paul E. McKenney 2014-05-04  891   * however, the first approach can also be useful, at least to those
f27bc4873 Paul E. McKenney 2014-05-04  892   * developers willing to keep abreast of the set of locks acquired by
f27bc4873 Paul E. McKenney 2014-05-04  893   * rt_mutex_unlock().
f27bc4873 Paul E. McKenney 2014-05-04  894   *
3d76c0829 Paul E. McKenney 2009-09-28  895   * See rcu_read_lock() for more information.
3d76c0829 Paul E. McKenney 2009-09-28  896   */
bc33f24bd Paul E. McKenney 2009-08-22  897  static inline void rcu_read_unlock(void)
bc33f24bd Paul E. McKenney 2009-08-22  898  {
5c173eb8b Paul E. McKenney 2013-09-13  899  	rcu_lockdep_assert(rcu_is_watching(),
bde23c689 Heiko Carstens   2012-02-01  900  			   "rcu_read_unlock() used illegally while idle");
bc33f24bd Paul E. McKenney 2009-08-22 @901  	__release(RCU);
bc33f24bd Paul E. McKenney 2009-08-22  902  	__rcu_read_unlock();
d24209bb6 Paul E. McKenney 2015-01-21  903  	rcu_lock_release(&rcu_lock_map); /* Keep acq info for rls diags. */
bc33f24bd Paul E. McKenney 2009-08-22  904  }
^1da177e4 Linus Torvalds   2005-04-16  905  
^1da177e4 Linus Torvalds   2005-04-16  906  /**
ca5ecddfa Paul E. McKenney 2010-04-28  907   * rcu_read_lock_bh() - mark the beginning of an RCU-bh critical section
^1da177e4 Linus Torvalds   2005-04-16  908   *
^1da177e4 Linus Torvalds   2005-04-16  909   * This is equivalent of rcu_read_lock(), but to be used when updates

:::::: The code at line 901 was first introduced by commit
:::::: bc33f24bdca8b6e97376e3a182ab69e6cdefa989 rcu: Consolidate sparse and lockdep declarations in include/linux/rcupdate.h

:::::: TO: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
:::::: CC: Ingo Molnar <mingo@elte.hu>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
