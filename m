From: kbuild test robot <lkp@intel.com>
Date: Thu, 13 Jul 2017 16:46:06 +0800
Subject: [Intel-wired-lan] [next PATCH S75-V3 10/11] i40e/i40evf:
 support for VF VLAN tag stripping control
In-Reply-To: <20170712094614.76501-10-alice.michael@intel.com>
Message-ID: <201707131624.oAHRD9Wo%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Mariusz,

[auto build test WARNING on jkirsher-next-queue/dev-queue]
[also build test WARNING on v4.12 next-20170712]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Alice-Michael/i40evf-use-netdev-variable-in-reset-task/20170713-123145
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   include/linux/compiler.h:260:8: sparse: attribute 'no_sanitize_address': unknown attribute
   drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c:2555:44: sparse: undefined identifier 'VIRTCHNL_OP_ENABLE_VLAN_STRIPPING'
   drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c:2582:44: sparse: undefined identifier 'VIRTCHNL_OP_DISABLE_VLAN_STRIPPING'
   drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c:2705:14: sparse: undefined identifier 'VIRTCHNL_OP_ENABLE_VLAN_STRIPPING'
   drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c:2708:14: sparse: undefined identifier 'VIRTCHNL_OP_DISABLE_VLAN_STRIPPING'
>> drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c:2705:14: sparse: incompatible types for 'case' statement
   drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c:2708:14: sparse: incompatible types for 'case' statement
   drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c:2705:14: sparse: Expected constant expression in case statement
   drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c:2708:14: sparse: Expected constant expression in case statement
   drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c: In function 'i40e_vc_enable_vlan_stripping':
   drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c:2555:37: error: 'VIRTCHNL_OP_ENABLE_VLAN_STRIPPING' undeclared (first use in this function)
     return i40e_vc_send_resp_to_vf(vf, VIRTCHNL_OP_ENABLE_VLAN_STRIPPING,
                                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c:2555:37: note: each undeclared identifier is reported only once for each function it appears in
   drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c: In function 'i40e_vc_disable_vlan_stripping':
   drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c:2582:37: error: 'VIRTCHNL_OP_DISABLE_VLAN_STRIPPING' undeclared (first use in this function)
     return i40e_vc_send_resp_to_vf(vf, VIRTCHNL_OP_DISABLE_VLAN_STRIPPING,
                                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c: In function 'i40e_vc_process_vf_msg':
   drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c:2705:7: error: 'VIRTCHNL_OP_ENABLE_VLAN_STRIPPING' undeclared (first use in this function)
     case VIRTCHNL_OP_ENABLE_VLAN_STRIPPING:
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c:2708:7: error: 'VIRTCHNL_OP_DISABLE_VLAN_STRIPPING' undeclared (first use in this function)
     case VIRTCHNL_OP_DISABLE_VLAN_STRIPPING:
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

vim +/case +2705 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c

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
  2582		return i40e_vc_send_resp_to_vf(vf, VIRTCHNL_OP_DISABLE_VLAN_STRIPPING,
  2583					       aq_ret);
  2584	}
  2585	
  2586	/**
  2587	 * i40e_vc_process_vf_msg
  2588	 * @pf: pointer to the PF structure
  2589	 * @vf_id: source VF id
  2590	 * @msg: pointer to the msg buffer
  2591	 * @msglen: msg length
  2592	 * @msghndl: msg handle
  2593	 *
  2594	 * called from the common aeq/arq handler to
  2595	 * process request from VF
  2596	 **/
  2597	int i40e_vc_process_vf_msg(struct i40e_pf *pf, s16 vf_id, u32 v_opcode,
  2598				   u32 v_retval, u8 *msg, u16 msglen)
  2599	{
  2600		struct i40e_hw *hw = &pf->hw;
  2601		int local_vf_id = vf_id - (s16)hw->func_caps.vf_base_id;
  2602		struct i40e_vf *vf;
  2603		int ret;
  2604	
  2605		pf->vf_aq_requests++;
  2606		if (local_vf_id >= pf->num_alloc_vfs)
  2607			return -EINVAL;
  2608		vf = &(pf->vf[local_vf_id]);
  2609	
  2610		/* Check if VF is disabled. */
  2611		if (test_bit(I40E_VF_STATE_DISABLED, &vf->vf_states))
  2612			return I40E_ERR_PARAM;
  2613	
  2614		/* perform basic checks on the msg */
  2615		ret = virtchnl_vc_validate_vf_msg(&vf->vf_ver, v_opcode, msg, msglen);
  2616	
  2617		/* perform additional checks specific to this driver */
  2618		if (v_opcode == VIRTCHNL_OP_CONFIG_RSS_KEY) {
  2619			struct virtchnl_rss_key *vrk = (struct virtchnl_rss_key *)msg;
  2620	
  2621			if (vrk->key_len != I40E_HKEY_ARRAY_SIZE)
  2622				ret = -EINVAL;
  2623		} else if (v_opcode == VIRTCHNL_OP_CONFIG_RSS_LUT) {
  2624			struct virtchnl_rss_lut *vrl = (struct virtchnl_rss_lut *)msg;
  2625	
  2626			if (vrl->lut_entries != I40E_VF_HLUT_ARRAY_SIZE)
  2627				ret = -EINVAL;
  2628		}
  2629	
  2630		if (ret) {
  2631			i40e_vc_send_resp_to_vf(vf, v_opcode, I40E_ERR_PARAM);
  2632			dev_err(&pf->pdev->dev, "Invalid message from VF %d, opcode %d, len %d\n",
  2633				local_vf_id, v_opcode, msglen);
  2634			switch (ret) {
  2635			case VIRTCHNL_ERR_PARAM:
  2636				return -EPERM;
  2637			default:
  2638				return -EINVAL;
  2639			}
  2640		}
  2641	
  2642		switch (v_opcode) {
  2643		case VIRTCHNL_OP_VERSION:
  2644			ret = i40e_vc_get_version_msg(vf, msg);
  2645			break;
  2646		case VIRTCHNL_OP_GET_VF_RESOURCES:
  2647			ret = i40e_vc_get_vf_resources_msg(vf, msg);
  2648			break;
  2649		case VIRTCHNL_OP_RESET_VF:
  2650			i40e_vc_reset_vf_msg(vf);
  2651			ret = 0;
  2652			break;
  2653		case VIRTCHNL_OP_CONFIG_PROMISCUOUS_MODE:
  2654			ret = i40e_vc_config_promiscuous_mode_msg(vf, msg, msglen);
  2655			break;
  2656		case VIRTCHNL_OP_CONFIG_VSI_QUEUES:
  2657			ret = i40e_vc_config_queues_msg(vf, msg, msglen);
  2658			break;
  2659		case VIRTCHNL_OP_CONFIG_IRQ_MAP:
  2660			ret = i40e_vc_config_irq_map_msg(vf, msg, msglen);
  2661			break;
  2662		case VIRTCHNL_OP_ENABLE_QUEUES:
  2663			ret = i40e_vc_enable_queues_msg(vf, msg, msglen);
  2664			i40e_vc_notify_vf_link_state(vf);
  2665			break;
  2666		case VIRTCHNL_OP_DISABLE_QUEUES:
  2667			ret = i40e_vc_disable_queues_msg(vf, msg, msglen);
  2668			break;
  2669		case VIRTCHNL_OP_ADD_ETH_ADDR:
  2670			ret = i40e_vc_add_mac_addr_msg(vf, msg, msglen);
  2671			break;
  2672		case VIRTCHNL_OP_DEL_ETH_ADDR:
  2673			ret = i40e_vc_del_mac_addr_msg(vf, msg, msglen);
  2674			break;
  2675		case VIRTCHNL_OP_ADD_VLAN:
  2676			ret = i40e_vc_add_vlan_msg(vf, msg, msglen);
  2677			break;
  2678		case VIRTCHNL_OP_DEL_VLAN:
  2679			ret = i40e_vc_remove_vlan_msg(vf, msg, msglen);
  2680			break;
  2681		case VIRTCHNL_OP_GET_STATS:
  2682			ret = i40e_vc_get_stats_msg(vf, msg, msglen);
  2683			break;
  2684		case VIRTCHNL_OP_IWARP:
  2685			ret = i40e_vc_iwarp_msg(vf, msg, msglen);
  2686			break;
  2687		case VIRTCHNL_OP_CONFIG_IWARP_IRQ_MAP:
  2688			ret = i40e_vc_iwarp_qvmap_msg(vf, msg, msglen, true);
  2689			break;
  2690		case VIRTCHNL_OP_RELEASE_IWARP_IRQ_MAP:
  2691			ret = i40e_vc_iwarp_qvmap_msg(vf, msg, msglen, false);
  2692			break;
  2693		case VIRTCHNL_OP_CONFIG_RSS_KEY:
  2694			ret = i40e_vc_config_rss_key(vf, msg, msglen);
  2695			break;
  2696		case VIRTCHNL_OP_CONFIG_RSS_LUT:
  2697			ret = i40e_vc_config_rss_lut(vf, msg, msglen);
  2698			break;
  2699		case VIRTCHNL_OP_GET_RSS_HENA_CAPS:
  2700			ret = i40e_vc_get_rss_hena(vf, msg, msglen);
  2701			break;
  2702		case VIRTCHNL_OP_SET_RSS_HENA:
  2703			ret = i40e_vc_set_rss_hena(vf, msg, msglen);
  2704			break;
> 2705		case VIRTCHNL_OP_ENABLE_VLAN_STRIPPING:
  2706			ret = i40e_vc_enable_vlan_stripping(vf, msg, msglen);
  2707			break;
  2708		case VIRTCHNL_OP_DISABLE_VLAN_STRIPPING:
  2709			ret = i40e_vc_disable_vlan_stripping(vf, msg, msglen);
  2710			break;
  2711	
  2712		case VIRTCHNL_OP_UNKNOWN:
  2713		default:
  2714			dev_err(&pf->pdev->dev, "Unsupported opcode %d from VF %d\n",
  2715				v_opcode, local_vf_id);
  2716			ret = i40e_vc_send_resp_to_vf(vf, v_opcode,
  2717						      I40E_ERR_NOT_IMPLEMENTED);
  2718			break;
  2719		}
  2720	
  2721		return ret;
  2722	}
  2723	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
