From: kbuild test robot <lkp@intel.com>
Date: Mon, 2 Jul 2018 23:14:18 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 9/15]
 net/core/dev.c:3595:35: error: 'struct net_device' has no member named
 'xps_maps'
Message-ID: <201807022316.jJ8PUnyV%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   a033baf24be32dbc9f75d84b5dd90600ab65f2c4
commit: fba8131dba987290a4f14a04ad74870654f81a6b [9/15] net: Add support for subordinate traffic classes to netdev_pick_tx
config: x86_64-randconfig-s5-07022124 (attached as .config)
compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
reproduce:
        git checkout fba8131dba987290a4f14a04ad74870654f81a6b
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/rculist.h:11:0,
                    from include/linux/pid.h:5,
                    from include/linux/sched.h:14,
                    from include/linux/uaccess.h:5,
                    from net/core/dev.c:75:
   net/core/dev.c: In function 'get_xps_queue':
>> net/core/dev.c:3595:35: error: 'struct net_device' has no member named 'xps_maps'
     dev_maps = rcu_dereference(sb_dev->xps_maps);
                                      ^
   include/linux/rcupdate.h:350:10: note: in definition of macro '__rcu_dereference_check'
     typeof(*p) *________p1 = (typeof(*p) *__force)READ_ONCE(p); \
             ^
   include/linux/rcupdate.h:545:28: note: in expansion of macro 'rcu_dereference_check'
    #define rcu_dereference(p) rcu_dereference_check(p, 0)
                               ^~~~~~~~~~~~~~~~~~~~~
>> net/core/dev.c:3595:13: note: in expansion of macro 'rcu_dereference'
     dev_maps = rcu_dereference(sb_dev->xps_maps);
                ^~~~~~~~~~~~~~~
>> net/core/dev.c:3595:35: error: 'struct net_device' has no member named 'xps_maps'
     dev_maps = rcu_dereference(sb_dev->xps_maps);
                                      ^
   include/linux/rcupdate.h:350:36: note: in definition of macro '__rcu_dereference_check'
     typeof(*p) *________p1 = (typeof(*p) *__force)READ_ONCE(p); \
                                       ^
   include/linux/rcupdate.h:545:28: note: in expansion of macro 'rcu_dereference_check'
    #define rcu_dereference(p) rcu_dereference_check(p, 0)
                               ^~~~~~~~~~~~~~~~~~~~~
>> net/core/dev.c:3595:13: note: in expansion of macro 'rcu_dereference'
     dev_maps = rcu_dereference(sb_dev->xps_maps);
                ^~~~~~~~~~~~~~~
   In file included from arch/x86/include/asm/current.h:5:0,
                    from include/linux/sched.h:12,
                    from include/linux/uaccess.h:5,
                    from net/core/dev.c:75:
>> net/core/dev.c:3595:35: error: 'struct net_device' has no member named 'xps_maps'
     dev_maps = rcu_dereference(sb_dev->xps_maps);
                                      ^
   include/linux/compiler.h:250:17: note: in definition of macro '__READ_ONCE'
     union { typeof(x) __val; char __c[1]; } __u;   \
                    ^
   include/linux/rcupdate.h:350:48: note: in expansion of macro 'READ_ONCE'
     typeof(*p) *________p1 = (typeof(*p) *__force)READ_ONCE(p); \
                                                   ^~~~~~~~~
   include/linux/rcupdate.h:487:2: note: in expansion of macro '__rcu_dereference_check'
     __rcu_dereference_check((p), (c) || rcu_read_lock_held(), __rcu)
     ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:545:28: note: in expansion of macro 'rcu_dereference_check'
    #define rcu_dereference(p) rcu_dereference_check(p, 0)
                               ^~~~~~~~~~~~~~~~~~~~~
>> net/core/dev.c:3595:13: note: in expansion of macro 'rcu_dereference'
     dev_maps = rcu_dereference(sb_dev->xps_maps);
                ^~~~~~~~~~~~~~~
>> net/core/dev.c:3595:35: error: 'struct net_device' has no member named 'xps_maps'
     dev_maps = rcu_dereference(sb_dev->xps_maps);
                                      ^
   include/linux/compiler.h:252:22: note: in definition of macro '__READ_ONCE'
      __read_once_size(&(x), __u.__c, sizeof(x));  \
                         ^
   include/linux/rcupdate.h:350:48: note: in expansion of macro 'READ_ONCE'
     typeof(*p) *________p1 = (typeof(*p) *__force)READ_ONCE(p); \
                                                   ^~~~~~~~~
   include/linux/rcupdate.h:487:2: note: in expansion of macro '__rcu_dereference_check'
     __rcu_dereference_check((p), (c) || rcu_read_lock_held(), __rcu)
     ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:545:28: note: in expansion of macro 'rcu_dereference_check'
    #define rcu_dereference(p) rcu_dereference_check(p, 0)
                               ^~~~~~~~~~~~~~~~~~~~~
>> net/core/dev.c:3595:13: note: in expansion of macro 'rcu_dereference'
     dev_maps = rcu_dereference(sb_dev->xps_maps);
                ^~~~~~~~~~~~~~~
>> net/core/dev.c:3595:35: error: 'struct net_device' has no member named 'xps_maps'
     dev_maps = rcu_dereference(sb_dev->xps_maps);
                                      ^
   include/linux/compiler.h:252:42: note: in definition of macro '__READ_ONCE'
      __read_once_size(&(x), __u.__c, sizeof(x));  \
                                             ^
   include/linux/rcupdate.h:350:48: note: in expansion of macro 'READ_ONCE'
     typeof(*p) *________p1 = (typeof(*p) *__force)READ_ONCE(p); \
                                                   ^~~~~~~~~
   include/linux/rcupdate.h:487:2: note: in expansion of macro '__rcu_dereference_check'
     __rcu_dereference_check((p), (c) || rcu_read_lock_held(), __rcu)
     ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:545:28: note: in expansion of macro 'rcu_dereference_check'
    #define rcu_dereference(p) rcu_dereference_check(p, 0)
                               ^~~~~~~~~~~~~~~~~~~~~
>> net/core/dev.c:3595:13: note: in expansion of macro 'rcu_dereference'
     dev_maps = rcu_dereference(sb_dev->xps_maps);
                ^~~~~~~~~~~~~~~
>> net/core/dev.c:3595:35: error: 'struct net_device' has no member named 'xps_maps'
     dev_maps = rcu_dereference(sb_dev->xps_maps);
                                      ^
   include/linux/compiler.h:254:30: note: in definition of macro '__READ_ONCE'
      __read_once_size_nocheck(&(x), __u.__c, sizeof(x)); \
                                 ^
   include/linux/rcupdate.h:350:48: note: in expansion of macro 'READ_ONCE'
     typeof(*p) *________p1 = (typeof(*p) *__force)READ_ONCE(p); \
                                                   ^~~~~~~~~
   include/linux/rcupdate.h:487:2: note: in expansion of macro '__rcu_dereference_check'
     __rcu_dereference_check((p), (c) || rcu_read_lock_held(), __rcu)
     ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:545:28: note: in expansion of macro 'rcu_dereference_check'
    #define rcu_dereference(p) rcu_dereference_check(p, 0)
                               ^~~~~~~~~~~~~~~~~~~~~
>> net/core/dev.c:3595:13: note: in expansion of macro 'rcu_dereference'
     dev_maps = rcu_dereference(sb_dev->xps_maps);
                ^~~~~~~~~~~~~~~
>> net/core/dev.c:3595:35: error: 'struct net_device' has no member named 'xps_maps'
     dev_maps = rcu_dereference(sb_dev->xps_maps);
                                      ^
   include/linux/compiler.h:254:50: note: in definition of macro '__READ_ONCE'
      __read_once_size_nocheck(&(x), __u.__c, sizeof(x)); \
                                                     ^
   include/linux/rcupdate.h:350:48: note: in expansion of macro 'READ_ONCE'
     typeof(*p) *________p1 = (typeof(*p) *__force)READ_ONCE(p); \
                                                   ^~~~~~~~~
   include/linux/rcupdate.h:487:2: note: in expansion of macro '__rcu_dereference_check'
     __rcu_dereference_check((p), (c) || rcu_read_lock_held(), __rcu)
     ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:545:28: note: in expansion of macro 'rcu_dereference_check'
    #define rcu_dereference(p) rcu_dereference_check(p, 0)
                               ^~~~~~~~~~~~~~~~~~~~~
>> net/core/dev.c:3595:13: note: in expansion of macro 'rcu_dereference'
     dev_maps = rcu_dereference(sb_dev->xps_maps);
                ^~~~~~~~~~~~~~~
   In file included from include/linux/rculist.h:11:0,
                    from include/linux/pid.h:5,
                    from include/linux/sched.h:14,
                    from include/linux/uaccess.h:5,
                    from net/core/dev.c:75:
>> net/core/dev.c:3595:35: error: 'struct net_device' has no member named 'xps_maps'
     dev_maps = rcu_dereference(sb_dev->xps_maps);
                                      ^
   include/linux/rcupdate.h:353:12: note: in definition of macro '__rcu_dereference_check'
     ((typeof(*p) __force __kernel *)(________p1)); \
               ^
   include/linux/rcupdate.h:545:28: note: in expansion of macro 'rcu_dereference_check'
    #define rcu_dereference(p) rcu_dereference_check(p, 0)
                               ^~~~~~~~~~~~~~~~~~~~~
>> net/core/dev.c:3595:13: note: in expansion of macro 'rcu_dereference'
     dev_maps = rcu_dereference(sb_dev->xps_maps);
                ^~~~~~~~~~~~~~~

vim +3595 net/core/dev.c

  3578	
  3579	static inline int get_xps_queue(struct net_device *dev,
  3580					struct net_device *sb_dev,
  3581					struct sk_buff *skb)
  3582	{
  3583	#ifdef CONFIG_XPS
  3584		struct xps_dev_maps *dev_maps;
  3585		struct sock *sk = skb->sk;
  3586		int queue_index = -1;
  3587	
  3588		if (!static_key_false(&xps_needed))
  3589			return -1;
  3590	
  3591		rcu_read_lock();
  3592		if (!static_key_false(&xps_rxqs_needed))
  3593			goto get_cpus_map;
  3594	
> 3595		dev_maps = rcu_dereference(sb_dev->xps_maps);
  3596		if (dev_maps) {
  3597			int tci = sk_rx_queue_get(sk);
  3598	
  3599			if (tci >= 0 && tci < dev->num_rx_queues)
  3600				queue_index = __get_xps_queue_idx(dev, skb, dev_maps,
  3601								  tci);
  3602		}
  3603	
  3604	get_cpus_map:
  3605		if (queue_index < 0) {
  3606			dev_maps = rcu_dereference(dev->xps_cpus_map);
  3607			if (dev_maps) {
  3608				unsigned int tci = skb->sender_cpu - 1;
  3609	
  3610				queue_index = __get_xps_queue_idx(dev, skb, dev_maps,
  3611								  tci);
  3612			}
  3613		}
  3614		rcu_read_unlock();
  3615	
  3616		return queue_index;
  3617	#else
  3618		return -1;
  3619	#endif
  3620	}
  3621	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 30206 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20180702/bda07c1a/attachment-0001.bin>
