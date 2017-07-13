From: kbuild test robot <lkp@intel.com>
Date: Thu, 13 Jul 2017 13:14:47 +0800
Subject: [Intel-wired-lan] [next PATCH S75-V3 10/11] i40e/i40evf:
 support for VF VLAN tag stripping control
In-Reply-To: <20170712094614.76501-10-alice.michael@intel.com>
Message-ID: <201707131326.RGikSZKV%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Mariusz,

[auto build test ERROR on jkirsher-next-queue/dev-queue]
[also build test ERROR on v4.12 next-20170712]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Alice-Michael/i40evf-use-netdev-variable-in-reset-task/20170713-123145
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
config: xtensa-allyesconfig (attached as .config)
compiler: xtensa-linux-gcc (GCC) 4.9.0
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=xtensa 

All errors (new ones prefixed by >>):

   drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c: In function 'i40e_vc_enable_vlan_stripping':
>> drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c:2555:37: error: 'VIRTCHNL_OP_ENABLE_VLAN_STRIPPING' undeclared (first use in this function)
     return i40e_vc_send_resp_to_vf(vf, VIRTCHNL_OP_ENABLE_VLAN_STRIPPING,
                                        ^
   drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c:2555:37: note: each undeclared identifier is reported only once for each function it appears in
   drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c: In function 'i40e_vc_disable_vlan_stripping':
>> drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c:2582:37: error: 'VIRTCHNL_OP_DISABLE_VLAN_STRIPPING' undeclared (first use in this function)
     return i40e_vc_send_resp_to_vf(vf, VIRTCHNL_OP_DISABLE_VLAN_STRIPPING,
                                        ^
   drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c: In function 'i40e_vc_process_vf_msg':
   drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c:2705:7: error: 'VIRTCHNL_OP_ENABLE_VLAN_STRIPPING' undeclared (first use in this function)
     case VIRTCHNL_OP_ENABLE_VLAN_STRIPPING:
          ^
   drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c:2708:7: error: 'VIRTCHNL_OP_DISABLE_VLAN_STRIPPING' undeclared (first use in this function)
     case VIRTCHNL_OP_DISABLE_VLAN_STRIPPING:
          ^
--
   drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c: In function 'i40evf_enable_vlan_stripping':
>> drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c:837:24: error: 'VIRTCHNL_OP_ENABLE_VLAN_STRIPPING' undeclared (first use in this function)
     adapter->current_op = VIRTCHNL_OP_ENABLE_VLAN_STRIPPING;
                           ^
   drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c:837:24: note: each undeclared identifier is reported only once for each function it appears in
   drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c: In function 'i40evf_disable_vlan_stripping':
>> drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c:857:24: error: 'VIRTCHNL_OP_DISABLE_VLAN_STRIPPING' undeclared (first use in this function)
     adapter->current_op = VIRTCHNL_OP_DISABLE_VLAN_STRIPPING;
                           ^

vim +/VIRTCHNL_OP_ENABLE_VLAN_STRIPPING +2555 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c

  2531	
  2532	/**
  2533	 * i40e_vc_enable_vlan_stripping
  2534	 * @vf: pointer to the VF info
  2535	 * @msg: pointer to the msg buffer
  2536	 * @msglen: msg length
  2537	 *
  2538	 * Enable vlan header stripping for the VF
  2539	 **/
  2540	static int i40e_vc_enable_vlan_stripping(struct i40e_vf *vf, u8 *msg,
  2541						 u16 msglen)
  2542	{
  2543		struct i40e_vsi *vsi = vf->pf->vsi[vf->lan_vsi_idx];
  2544		i40e_status aq_ret = 0;
  2545	
  2546		if (!test_bit(I40E_VF_STATE_ACTIVE, &vf->vf_states)) {
  2547			aq_ret = I40E_ERR_PARAM;
  2548			goto err;
  2549		}
  2550	
  2551		i40e_vlan_stripping_enable(vsi);
  2552	
  2553		/* send the response to the VF */
  2554	err:
> 2555		return i40e_vc_send_resp_to_vf(vf, VIRTCHNL_OP_ENABLE_VLAN_STRIPPING,
  2556					       aq_ret);
  2557	}
  2558	
  2559	/**
  2560	 * i40e_vc_disable_vlan_stripping
  2561	 * @vf: pointer to the VF info
  2562	 * @msg: pointer to the msg buffer
  2563	 * @msglen: msg length
  2564	 *
  2565	 * Disable vlan header stripping for the VF
  2566	 **/
  2567	static int i40e_vc_disable_vlan_stripping(struct i40e_vf *vf, u8 *msg,
  2568						  u16 msglen)
  2569	{
  2570		struct i40e_vsi *vsi = vf->pf->vsi[vf->lan_vsi_idx];
  2571		i40e_status aq_ret = 0;
  2572	
  2573		if (!test_bit(I40E_VF_STATE_ACTIVE, &vf->vf_states)) {
  2574			aq_ret = I40E_ERR_PARAM;
  2575			goto err;
  2576		}
  2577	
  2578		i40e_vlan_stripping_disable(vsi);
  2579	
  2580		/* send the response to the VF */
  2581	err:
> 2582		return i40e_vc_send_resp_to_vf(vf, VIRTCHNL_OP_DISABLE_VLAN_STRIPPING,
  2583					       aq_ret);
  2584	}
  2585	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 50562 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20170713/3b171cb6/attachment-0001.bin>
