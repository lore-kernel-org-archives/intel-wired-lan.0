From: kernel test robot <lkp@intel.com>
Date: Thu, 10 Mar 2022 01:21:25 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue 192/252]
 include/net/tcp.h:1697:1: error: expected identifier or '(' before '{'
 token
Message-ID: <202203100120.Jk1QDYfg-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
head:   1f3c9cdce1f36b6edf8296139dafa6cb39826543
commit: 1330b6ef3313fcec577d2b020c290dc8b9f11f1a [192/252] skb: make drop reason booleanable
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20220310/202203100120.Jk1QDYfg-lkp at intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git/commit/?id=1330b6ef3313fcec577d2b020c290dc8b9f11f1a
        git remote add tnguy-next-queue https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git
        git fetch --no-tags tnguy-next-queue dev-queue
        git checkout 1330b6ef3313fcec577d2b020c290dc8b9f11f1a
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=um SUBARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/net/slip/slhc.c:74:
>> include/net/tcp.h:1697:1: error: expected identifier or '(' before '{' token
    1697 | {
         | ^
   include/net/tcp.h:1694:1: warning: 'tcp_inbound_md5_hash' declared 'static' but never defined [-Wunused-function]
    1694 | tcp_inbound_md5_hash(const struct sock *sk, const struct sk_buff *skb,
         | ^~~~~~~~~~~~~~~~~~~~
--
   In file included from net/ipv4/tcp_ipv4.c:64:
>> include/net/tcp.h:1697:1: error: expected identifier or '(' before '{' token
    1697 | {
         | ^
   include/net/tcp.h:1694:1: warning: 'tcp_inbound_md5_hash' used but never defined
    1694 | tcp_inbound_md5_hash(const struct sock *sk, const struct sk_buff *skb,
         | ^~~~~~~~~~~~~~~~~~~~
--
   In file included from net/ipv4/route.c:95:
>> include/net/tcp.h:1697:1: error: expected identifier or '(' before '{' token
    1697 | {
         | ^
   net/ipv4/route.c: In function 'ip_rt_send_redirect':
   net/ipv4/route.c:869:6: warning: variable 'log_martians' set but not used [-Wunused-but-set-variable]
     869 |  int log_martians;
         |      ^~~~~~~~~~~~
   In file included from net/ipv4/route.c:95:
   net/ipv4/route.c: At top level:
   include/net/tcp.h:1694:1: warning: 'tcp_inbound_md5_hash' declared 'static' but never defined [-Wunused-function]
    1694 | tcp_inbound_md5_hash(const struct sock *sk, const struct sk_buff *skb,
         | ^~~~~~~~~~~~~~~~~~~~


vim +1697 include/net/tcp.h

1330b6ef3313fc Jakub Kicinski    2022-03-07  1692  
1330b6ef3313fc Jakub Kicinski    2022-03-07  1693  static inline enum skb_drop_reason
1330b6ef3313fc Jakub Kicinski    2022-03-07  1694  tcp_inbound_md5_hash(const struct sock *sk, const struct sk_buff *skb,
7bbb765b734966 Dmitry Safonov    2022-02-23  1695  		     const void *saddr, const void *daddr,
1330b6ef3313fc Jakub Kicinski    2022-03-07  1696  		     int family, int dif, int sdif);
7bbb765b734966 Dmitry Safonov    2022-02-23 @1697  {
1330b6ef3313fc Jakub Kicinski    2022-03-07  1698  	return SKB_NOT_DROPPED_YET;
7bbb765b734966 Dmitry Safonov    2022-02-23  1699  }
9501f9722922f2 YOSHIFUJI Hideaki 2008-04-18  1700  #define tcp_twsk_md5_key(twsk)	NULL
9501f9722922f2 YOSHIFUJI Hideaki 2008-04-18  1701  #endif
9501f9722922f2 YOSHIFUJI Hideaki 2008-04-18  1702  

:::::: The code at line 1697 was first introduced by commit
:::::: 7bbb765b73496699a165d505ecdce962f903b422 net/tcp: Merge TCP-MD5 inbound callbacks

:::::: TO: Dmitry Safonov <dima@arista.com>
:::::: CC: Jakub Kicinski <kuba@kernel.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
