From: kbuild test robot <lkp@intel.com>
Date: Fri, 1 Apr 2016 13:17:02 +0800
Subject: [Intel-wired-lan] [next PATCH] i40evf: properly handle VLAN
 features
In-Reply-To: <1459445708-20029-1-git-send-email-mitch.a.williams@intel.com>
Message-ID: <201604011318.l1KFK9Jc%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Mitch,

[auto build test WARNING on net/master]
[also build test WARNING on v4.6-rc1 next-20160401]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Mitch-Williams/i40evf-properly-handle-VLAN-features/20160401-014314
config: i386-randconfig-x011-04011139 (attached as .config)
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All warnings (new ones prefixed by >>):

   In file included from include/uapi/linux/stddef.h:1:0,
                    from include/linux/stddef.h:4,
                    from include/uapi/linux/posix_types.h:4,
                    from include/uapi/linux/types.h:13,
                    from include/linux/types.h:5,
                    from include/linux/list.h:4,
                    from include/linux/module.h:9,
                    from drivers/net/ethernet/intel/i40evf/i40evf.h:30,
                    from drivers/net/ethernet/intel/i40evf/i40evf_main.c:27:
   drivers/net/ethernet/intel/i40evf/i40evf_main.c: In function 'i40evf_process_config':
   drivers/net/ethernet/intel/i40evf/i40evf_main.c:2358:6: error: 'vfres' undeclared (first use in this function)
     if (vfres->vf_offload_flags & I40E_VIRTCHNL_VF_OFFLOAD_VLAN) {
         ^
   include/linux/compiler.h:151:30: note: in definition of macro '__trace_if'
     if (__builtin_constant_p(!!(cond)) ? !!(cond) :   \
                                 ^
>> drivers/net/ethernet/intel/i40evf/i40evf_main.c:2358:2: note: in expansion of macro 'if'
     if (vfres->vf_offload_flags & I40E_VIRTCHNL_VF_OFFLOAD_VLAN) {
     ^
   drivers/net/ethernet/intel/i40evf/i40evf_main.c:2358:6: note: each undeclared identifier is reported only once for each function it appears in
     if (vfres->vf_offload_flags & I40E_VIRTCHNL_VF_OFFLOAD_VLAN) {
         ^
   include/linux/compiler.h:151:30: note: in definition of macro '__trace_if'
     if (__builtin_constant_p(!!(cond)) ? !!(cond) :   \
                                 ^
>> drivers/net/ethernet/intel/i40evf/i40evf_main.c:2358:2: note: in expansion of macro 'if'
     if (vfres->vf_offload_flags & I40E_VIRTCHNL_VF_OFFLOAD_VLAN) {
     ^

vim +/if +2358 drivers/net/ethernet/intel/i40evf/i40evf_main.c

  2342					   NETIF_F_TSO		       |
  2343					   NETIF_F_TSO6		       |
  2344					   NETIF_F_TSO_ECN	       |
  2345					   NETIF_F_GSO_GRE	       |
  2346					   NETIF_F_GSO_UDP_TUNNEL      |
  2347					   NETIF_F_GSO_UDP_TUNNEL_CSUM;
  2348	
  2349		if (adapter->flags & I40EVF_FLAG_OUTER_UDP_CSUM_CAPABLE)
  2350			netdev->features |= NETIF_F_GSO_UDP_TUNNEL_CSUM;
  2351	
  2352		/* copy netdev features into list of user selectable features */
  2353		netdev->hw_features |= netdev->features;
  2354		netdev->hw_features &= ~NETIF_F_RXCSUM;
  2355		netdev->hw_features &= ~(I40EVF_VLAN_FEATURES);
  2356		netdev->features &= ~(I40EVF_VLAN_FEATURES);
  2357	
> 2358		if (vfres->vf_offload_flags & I40E_VIRTCHNL_VF_OFFLOAD_VLAN) {
  2359			netdev->vlan_features = netdev->features;
  2360			netdev->features |= I40EVF_VLAN_FEATURES;
  2361		}
  2362	
  2363		adapter->vsi.id = adapter->vsi_res->vsi_id;
  2364	
  2365		adapter->vsi.back = adapter;
  2366		adapter->vsi.base_vector = 1;

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 29120 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160401/94f07b57/attachment-0001.obj>
