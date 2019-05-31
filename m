From: kbuild test robot <lkp@intel.com>
Date: Fri, 31 May 2019 11:44:03 +0800
Subject: [Intel-wired-lan] include/linux/netfilter_ipv6.h:110:9: error:
 implicit declaration of function 'nf_ct_frag6_gather';
 did you mean 'nf_ct_attach'?
Message-ID: <201905311102.PBHsIGJX%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   8b2d002239e0655548bd7a8542d3191346e2abf0
commit: 764dd163ac922f8683b5bcd3007251ce7b26cd33 netfilter: nf_conntrack_bridge: add support for IPv6
date:   6 hours ago
config: x86_64-fedora-25 (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        git checkout 764dd163ac922f8683b5bcd3007251ce7b26cd33
        # save the attached .config to linux build tree
        make ARCH=x86_64 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/uapi/linux/netfilter_ipv6/ip6_tables.h:22:0,
                    from include/linux/netfilter_ipv6/ip6_tables.h:24,
                    from net/netfilter/ipset/ip_set_getport.c:15:
   include/linux/netfilter_ipv6.h: In function 'nf_ipv6_br_defrag':
>> include/linux/netfilter_ipv6.h:110:9: error: implicit declaration of function 'nf_ct_frag6_gather'; did you mean 'nf_ct_attach'? [-Werror=implicit-function-declaration]
     return nf_ct_frag6_gather(net, skb, user);
            ^~~~~~~~~~~~~~~~~~
            nf_ct_attach
   cc1: some warnings being treated as errors
--
   In file included from include/uapi/linux/netfilter_ipv6/ip6_tables.h:22:0,
                    from include/linux/netfilter_ipv6/ip6_tables.h:24,
                    from include/net/ip_vs.h:28,
                    from net/netfilter/ipvs/ip_vs_ftp.c:46:
   include/linux/netfilter_ipv6.h: In function 'nf_ipv6_br_defrag':
>> include/linux/netfilter_ipv6.h:110:9: error: implicit declaration of function 'nf_ct_frag6_gather'; did you mean 'nf_ct_netns_get'? [-Werror=implicit-function-declaration]
     return nf_ct_frag6_gather(net, skb, user);
            ^~~~~~~~~~~~~~~~~~
            nf_ct_netns_get
   cc1: some warnings being treated as errors
--
   In file included from net//netfilter/nf_conntrack_proto.c:29:0:
   include/linux/netfilter_ipv6.h: In function 'nf_ipv6_br_defrag':
>> include/linux/netfilter_ipv6.h:110:9: error: implicit declaration of function 'nf_ct_frag6_gather'; did you mean 'nf_ct_bridge_register'? [-Werror=implicit-function-declaration]
     return nf_ct_frag6_gather(net, skb, user);
            ^~~~~~~~~~~~~~~~~~
            nf_ct_bridge_register
   cc1: some warnings being treated as errors
--
   In file included from security//selinux/hooks.c:54:0:
   include/linux/netfilter_ipv6.h: In function 'nf_ipv6_br_defrag':
>> include/linux/netfilter_ipv6.h:110:9: error: implicit declaration of function 'nf_ct_frag6_gather'; did you mean 'nf_ct_attach'? [-Werror=implicit-function-declaration]
     return nf_ct_frag6_gather(net, skb, user);
            ^~~~~~~~~~~~~~~~~~
            nf_ct_attach
   In file included from security//selinux/hooks.c:96:0:
   security/selinux/include/avc.h: At top level:
   security/selinux/include/avc.h:19:10: fatal error: flask.h: No such file or directory
    #include "flask.h"
             ^~~~~~~~~
   cc1: some warnings being treated as errors
   compilation terminated.

vim +110 include/linux/netfilter_ipv6.h

    98	
    99	static inline int nf_ipv6_br_defrag(struct net *net, struct sk_buff *skb,
   100					    u32 user)
   101	{
   102	#if IS_MODULE(CONFIG_IPV6)
   103		const struct nf_ipv6_ops *v6_ops = nf_get_ipv6_ops();
   104	
   105		if (!v6_ops)
   106			return 1;
   107	
   108		return v6_ops->br_defrag(net, skb, user);
   109	#else
 > 110		return nf_ct_frag6_gather(net, skb, user);
   111	#endif
   112	}
   113	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 50146 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20190531/de8c8b24/attachment-0001.bin>
