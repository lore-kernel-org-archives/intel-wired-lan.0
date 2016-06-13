From: kbuild test robot <lkp@intel.com>
Date: Tue, 14 Jun 2016 03:31:29 +0800
Subject: [Intel-wired-lan] [net-next PATCH 04/15] bnxt: Replace
 ndo_add/del_vxlan_port with ndo_add/del_udp_enc_port
In-Reply-To: <20160613174822.15186.55819.stgit@localhost.localdomain>
Message-ID: <201606140312.2GaVilnA%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,

[auto build test WARNING on net/master]
[also build test WARNING on v4.7-rc3 next-20160609]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Alexander-Duyck/Future-proof-tunnel-offload-handlers/20160614-020534
config: x86_64-randconfig-x018-06140233 (attached as .config)
compiler: gcc-6 (Debian 6.1.1-1) 6.1.1 20160430
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All warnings (new ones prefixed by >>):

   In file included from include/uapi/linux/stddef.h:1:0,
                    from include/linux/stddef.h:4,
                    from include/uapi/linux/posix_types.h:4,
                    from include/uapi/linux/types.h:13,
                    from include/linux/types.h:5,
                    from include/linux/list.h:4,
                    from include/linux/module.h:9,
                    from drivers/net/ethernet/broadcom/bnxt/bnxt.c:10:
   drivers/net/ethernet/broadcom/bnxt/bnxt.c: In function 'bnxt_add_vxlan_port':
   drivers/net/ethernet/broadcom/bnxt/bnxt.c:6056:14: error: 'UDP_ENC_OFFLOAD_TYPE_VXLAN' undeclared (first use in this function)
     if (type != UDP_ENC_OFFLOAD_TYPE_VXLAN)
                 ^
   include/linux/compiler.h:151:30: note: in definition of macro '__trace_if'
     if (__builtin_constant_p(!!(cond)) ? !!(cond) :   \
                                 ^~~~
>> drivers/net/ethernet/broadcom/bnxt/bnxt.c:6056:2: note: in expansion of macro 'if'
     if (type != UDP_ENC_OFFLOAD_TYPE_VXLAN)
     ^~
   drivers/net/ethernet/broadcom/bnxt/bnxt.c:6056:14: note: each undeclared identifier is reported only once for each function it appears in
     if (type != UDP_ENC_OFFLOAD_TYPE_VXLAN)
                 ^
   include/linux/compiler.h:151:30: note: in definition of macro '__trace_if'
     if (__builtin_constant_p(!!(cond)) ? !!(cond) :   \
                                 ^~~~
>> drivers/net/ethernet/broadcom/bnxt/bnxt.c:6056:2: note: in expansion of macro 'if'
     if (type != UDP_ENC_OFFLOAD_TYPE_VXLAN)
     ^~
   drivers/net/ethernet/broadcom/bnxt/bnxt.c: In function 'bnxt_del_vxlan_port':
   drivers/net/ethernet/broadcom/bnxt/bnxt.c:6081:14: error: 'UDP_ENC_OFFLOAD_TYPE_VXLAN' undeclared (first use in this function)
     if (type != UDP_ENC_OFFLOAD_TYPE_VXLAN)
                 ^
   include/linux/compiler.h:151:30: note: in definition of macro '__trace_if'
     if (__builtin_constant_p(!!(cond)) ? !!(cond) :   \
                                 ^~~~
   drivers/net/ethernet/broadcom/bnxt/bnxt.c:6081:2: note: in expansion of macro 'if'
     if (type != UDP_ENC_OFFLOAD_TYPE_VXLAN)
     ^~

vim +/if +6056 drivers/net/ethernet/broadcom/bnxt/bnxt.c

  6040			netdev_info(bp->dev, "Receive PF driver unload event!");
  6041	}
  6042	
  6043	#else
  6044	
  6045	static void bnxt_cfg_ntp_filters(struct bnxt *bp)
  6046	{
  6047	}
  6048	
  6049	#endif /* CONFIG_RFS_ACCEL */
  6050	
  6051	static void bnxt_add_vxlan_port(struct net_device *dev, sa_family_t sa_family,
  6052					__be16 port, unsigned int type)
  6053	{
  6054		struct bnxt *bp = netdev_priv(dev);
  6055	
> 6056		if (type != UDP_ENC_OFFLOAD_TYPE_VXLAN)
  6057			return;
  6058	
  6059		if (sa_family != AF_INET6 && sa_family != AF_INET)
  6060			return;
  6061	
  6062		if (!netif_running(dev))
  6063			return;
  6064	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 28968 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160614/33facfcf/attachment-0001.obj>
