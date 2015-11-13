From: kbuild test robot <fengguang.wu@intel.com>
Date: Sat, 14 Nov 2015 05:29:40 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 156/160]
 drivers/net/ethernet/intel/i40e/i40e_main.c:8477:14: error:
 'UDP_TUNNEL_VXLAN' undeclared
Message-ID: <201511140538.GzH1xIOU%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   7c2cae61768b0da68519e4c45a86aafab84dda28
commit: b38838432894149338100207df9c2b0b6b38a536 [156/160] net: Generalize udp based tunnel offload
config: x86_64-rhel (attached as .config)
reproduce:
        git checkout b38838432894149338100207df9c2b0b6b38a536
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   drivers/net/ethernet/intel/i40e/i40e_main.c: In function 'i40e_add_tunnel_port':
>> drivers/net/ethernet/intel/i40e/i40e_main.c:8477:14: error: 'UDP_TUNNEL_VXLAN' undeclared (first use in this function)
     if (type != UDP_TUNNEL_VXLAN)
                 ^
   drivers/net/ethernet/intel/i40e/i40e_main.c:8477:14: note: each undeclared identifier is reported only once for each function it appears in
   drivers/net/ethernet/intel/i40e/i40e_main.c:8483:2: error: implicit declaration of function 'i40e_get_vxlan_port_idx' [-Werror=implicit-function-declaration]
     idx = i40e_get_vxlan_port_idx(pf, port);
     ^
   drivers/net/ethernet/intel/i40e/i40e_main.c:8502:4: error: 'struct i40e_pf' has no member named 'vxlan_ports'
     pf->vxlan_ports[next_idx] = port;
       ^
   drivers/net/ethernet/intel/i40e/i40e_main.c:8503:4: error: 'struct i40e_pf' has no member named 'pending_vxlan_bitmap'
     pf->pending_vxlan_bitmap |= BIT_ULL(next_idx);
       ^
   drivers/net/ethernet/intel/i40e/i40e_main.c:8504:15: error: 'I40E_FLAG_VXLAN_FILTER_SYNC' undeclared (first use in this function)
     pf->flags |= I40E_FLAG_VXLAN_FILTER_SYNC;
                  ^
   drivers/net/ethernet/intel/i40e/i40e_main.c: In function 'i40e_del_tunnel_port':
   drivers/net/ethernet/intel/i40e/i40e_main.c:8525:14: error: 'UDP_TUNNEL_VXLAN' undeclared (first use in this function)
     if (type != UDP_TUNNEL_VXLAN)
                 ^
   drivers/net/ethernet/intel/i40e/i40e_main.c:8538:5: error: 'struct i40e_pf' has no member named 'vxlan_ports'
      pf->vxlan_ports[idx] = 0;
        ^
   drivers/net/ethernet/intel/i40e/i40e_main.c:8539:5: error: 'struct i40e_pf' has no member named 'pending_vxlan_bitmap'
      pf->pending_vxlan_bitmap |= BIT_ULL(idx);
        ^
   drivers/net/ethernet/intel/i40e/i40e_main.c:8540:16: error: 'I40E_FLAG_VXLAN_FILTER_SYNC' undeclared (first use in this function)
      pf->flags |= I40E_FLAG_VXLAN_FILTER_SYNC;
                   ^
   cc1: some warnings being treated as errors

vim +/UDP_TUNNEL_VXLAN +8477 drivers/net/ethernet/intel/i40e/i40e_main.c

  8471		struct i40e_netdev_priv *np = netdev_priv(netdev);
  8472		struct i40e_vsi *vsi = np->vsi;
  8473		struct i40e_pf *pf = vsi->back;
  8474		u8 next_idx;
  8475		u8 idx;
  8476	
> 8477		if (type != UDP_TUNNEL_VXLAN)
  8478			return;
  8479	
  8480		if (sa_family == AF_INET6)

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 35613 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20151114/926e88eb/attachment-0001.obj>
