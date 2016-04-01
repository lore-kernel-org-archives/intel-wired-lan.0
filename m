From: kbuild test robot <lkp@intel.com>
Date: Fri, 1 Apr 2016 21:10:10 +0800
Subject: [Intel-wired-lan] [next PATCH] i40evf: properly handle VLAN
 features
In-Reply-To: <1459445708-20029-1-git-send-email-mitch.a.williams@intel.com>
Message-ID: <201604012100.ihdUeNAj%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Mitch,

[auto build test ERROR on net/master]
[also build test ERROR on v4.6-rc1 next-20160401]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Mitch-Williams/i40evf-properly-handle-VLAN-features/20160401-014314
config: i386-allmodconfig (attached as .config)
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   drivers/net/ethernet/intel/i40evf/i40evf_main.c: In function 'i40evf_process_config':
>> drivers/net/ethernet/intel/i40evf/i40evf_main.c:2358:6: error: 'vfres' undeclared (first use in this function)
     if (vfres->vf_offload_flags & I40E_VIRTCHNL_VF_OFFLOAD_VLAN) {
         ^
   drivers/net/ethernet/intel/i40evf/i40evf_main.c:2358:6: note: each undeclared identifier is reported only once for each function it appears in

vim +/vfres +2358 drivers/net/ethernet/intel/i40evf/i40evf_main.c

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

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 54390 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160401/99664dce/attachment-0001.obj>
