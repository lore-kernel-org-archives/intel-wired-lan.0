From: kbuild test robot <lkp@intel.com>
Date: Tue, 14 Jun 2016 04:03:05 +0800
Subject: [Intel-wired-lan] [net-next PATCH 02/15] net: Merge VXLAN and
 GENEVE push notifiers into a single notifier
In-Reply-To: <20160613174806.15186.64702.stgit@localhost.localdomain>
Message-ID: <201606140347.XW2yaHb2%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,

[auto build test ERROR on net/master]
[also build test ERROR on v4.7-rc3 next-20160609]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Alexander-Duyck/Future-proof-tunnel-offload-handlers/20160614-020534
config: x86_64-randconfig-x015-06140233 (attached as .config)
compiler: gcc-6 (Debian 6.1.1-1) 6.1.1 20160430
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   In file included from include/net/vxlan.h:11:0,
                    from drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:53:
   include/net/udp_tunnel.h: In function 'udp_tunnel_handle_offloads':
>> include/net/udp_tunnel.h:130:9: error: implicit declaration of function 'iptunnel_handle_offloads' [-Werror=implicit-function-declaration]
     return iptunnel_handle_offloads(skb, type);
            ^~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +/iptunnel_handle_offloads +130 include/net/udp_tunnel.h

c29a70d2 Pravin B Shelar 2015-08-26  124  				    int md_size);
c29a70d2 Pravin B Shelar 2015-08-26  125  
aed069df Alexander Duyck 2016-04-14  126  static inline int udp_tunnel_handle_offloads(struct sk_buff *skb, bool udp_csum)
6a93cc90 Andy Zhou       2014-09-16  127  {
6a93cc90 Andy Zhou       2014-09-16  128  	int type = udp_csum ? SKB_GSO_UDP_TUNNEL_CSUM : SKB_GSO_UDP_TUNNEL;
6a93cc90 Andy Zhou       2014-09-16  129  
6fa79666 Edward Cree     2016-02-11 @130  	return iptunnel_handle_offloads(skb, type);
6a93cc90 Andy Zhou       2014-09-16  131  }
6a93cc90 Andy Zhou       2014-09-16  132  
6a93cc90 Andy Zhou       2014-09-16  133  static inline void udp_tunnel_encap_enable(struct socket *sock)

:::::: The code at line 130 was first introduced by commit
:::::: 6fa79666e24d32be1b709f5269af41ed9e829e7e net: ip_tunnel: remove 'csum_help' argument to iptunnel_handle_offloads

:::::: TO: Edward Cree <ecree@solarflare.com>
:::::: CC: David S. Miller <davem@davemloft.net>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 28051 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160614/342812b2/attachment-0001.obj>
