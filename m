From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Tue, 30 Jan 2018 16:13:55 +0300
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 117/117]
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c:3017
 i40e_validate_cloud_filter() warn: impossible condition '(() > 65535) =>
 (0-65535 > 65535)'
Message-ID: <20180130131355.ueua4n4xuystnwcr@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   ec620ca1f8683dfae6e70230360024fbbbd8c21e
commit: ec620ca1f8683dfae6e70230360024fbbbd8c21e [117/117] i40e: Add and delete cloud filter

New smatch warnings:
drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c:3017 i40e_validate_cloud_filter() warn: impossible condition '(() > 65535) => (0-65535 > 65535)'

Old smatch warnings:
drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c:471 i40e_config_iwarp_qvlist() error: not allocating enough data 16 vs 4
drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c:3025 i40e_validate_cloud_filter() warn: impossible condition '(() > 65535) => (0-65535 > 65535)'

# https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git/commit/?id=ec620ca1f8683dfae6e70230360024fbbbd8c21e
git remote add jkirsher-next-queue https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git
git remote update jkirsher-next-queue
git checkout ec620ca1f8683dfae6e70230360024fbbbd8c21e
vim +3017 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c

8774370d2 Mariusz Stachura 2017-07-17  2918  
8774370d2 Mariusz Stachura 2017-07-17  2919  /**
ec620ca1f Avinash Dayanand 2018-01-23  2920   * i40e_validate_cloud_filter
ec620ca1f Avinash Dayanand 2018-01-23  2921   * @mask: mask for TC filter
ec620ca1f Avinash Dayanand 2018-01-23  2922   * @data: data for TC filter
ec620ca1f Avinash Dayanand 2018-01-23  2923   *
ec620ca1f Avinash Dayanand 2018-01-23  2924   * This function validates cloud filter programmed as TC filter for ADq
ec620ca1f Avinash Dayanand 2018-01-23  2925   **/
ec620ca1f Avinash Dayanand 2018-01-23  2926  static int i40e_validate_cloud_filter(struct i40e_vf *vf,
ec620ca1f Avinash Dayanand 2018-01-23  2927  				      struct virtchnl_filter *tc_filter)
ec620ca1f Avinash Dayanand 2018-01-23  2928  {
ec620ca1f Avinash Dayanand 2018-01-23  2929  	struct virtchnl_l4_spec mask = tc_filter->mask.tcp_spec;
ec620ca1f Avinash Dayanand 2018-01-23  2930  	struct virtchnl_l4_spec data = tc_filter->data.tcp_spec;
ec620ca1f Avinash Dayanand 2018-01-23  2931  	struct i40e_pf *pf = vf->pf;
ec620ca1f Avinash Dayanand 2018-01-23  2932  	struct i40e_vsi *vsi = NULL;
ec620ca1f Avinash Dayanand 2018-01-23  2933  	struct i40e_mac_filter *f;
ec620ca1f Avinash Dayanand 2018-01-23  2934  	struct hlist_node *h;
ec620ca1f Avinash Dayanand 2018-01-23  2935  	bool found = false;
ec620ca1f Avinash Dayanand 2018-01-23  2936  	int bkt;
ec620ca1f Avinash Dayanand 2018-01-23  2937  
ec620ca1f Avinash Dayanand 2018-01-23  2938  	if (!tc_filter->action) {
ec620ca1f Avinash Dayanand 2018-01-23  2939  		dev_info(&pf->pdev->dev,
ec620ca1f Avinash Dayanand 2018-01-23  2940  			 "VF %d: Currently ADq doesn't support Drop Action\n",
ec620ca1f Avinash Dayanand 2018-01-23  2941  			 vf->vf_id);
ec620ca1f Avinash Dayanand 2018-01-23  2942  		goto err;
ec620ca1f Avinash Dayanand 2018-01-23  2943  	}
ec620ca1f Avinash Dayanand 2018-01-23  2944  
ec620ca1f Avinash Dayanand 2018-01-23  2945  	/* action_meta is TC number here to which the filter is applied */
ec620ca1f Avinash Dayanand 2018-01-23  2946  	if (!tc_filter->action_meta ||
ec620ca1f Avinash Dayanand 2018-01-23  2947  	    tc_filter->action_meta > I40E_MAX_VF_VSI) {
ec620ca1f Avinash Dayanand 2018-01-23  2948  		dev_info(&pf->pdev->dev, "VF %d: Invalid TC number %u\n",
ec620ca1f Avinash Dayanand 2018-01-23  2949  			 vf->vf_id, tc_filter->action_meta);
ec620ca1f Avinash Dayanand 2018-01-23  2950  		goto err;
ec620ca1f Avinash Dayanand 2018-01-23  2951  	}
ec620ca1f Avinash Dayanand 2018-01-23  2952  
ec620ca1f Avinash Dayanand 2018-01-23  2953  	/* Check filter if it's programmed for advanced mode or basic mode.
ec620ca1f Avinash Dayanand 2018-01-23  2954  	 * There are two ADq modes (for VF only),
ec620ca1f Avinash Dayanand 2018-01-23  2955  	 * 1. Basic mode: intended to allow as many filter options as posssible
ec620ca1f Avinash Dayanand 2018-01-23  2956  	 *		  to be added to a VF in Non-trusted mode. Main goal is
ec620ca1f Avinash Dayanand 2018-01-23  2957  	 *		  to add filters to its own MAC and VLAN id.
ec620ca1f Avinash Dayanand 2018-01-23  2958  	 * 2. Advanced mode: is for allowing filters to be applied other than
ec620ca1f Avinash Dayanand 2018-01-23  2959  	 *		  its own MAC or VLAN. This mode requires the VF to be
ec620ca1f Avinash Dayanand 2018-01-23  2960  	 *		  Trusted.
ec620ca1f Avinash Dayanand 2018-01-23  2961  	 */
ec620ca1f Avinash Dayanand 2018-01-23  2962  	if (mask.dst_mac[0] && !mask.dst_ip[0]) {
ec620ca1f Avinash Dayanand 2018-01-23  2963  		vsi = pf->vsi[vf->lan_vsi_idx];
ec620ca1f Avinash Dayanand 2018-01-23  2964  		f = i40e_find_mac(vsi, data.dst_mac);
ec620ca1f Avinash Dayanand 2018-01-23  2965  
ec620ca1f Avinash Dayanand 2018-01-23  2966  		if (!f) {
ec620ca1f Avinash Dayanand 2018-01-23  2967  			dev_info(&pf->pdev->dev,
ec620ca1f Avinash Dayanand 2018-01-23  2968  				 "Destination MAC %pM doesn't belong to VF %d\n",
ec620ca1f Avinash Dayanand 2018-01-23  2969  				 data.dst_mac, vf->vf_id);
ec620ca1f Avinash Dayanand 2018-01-23  2970  			goto err;
ec620ca1f Avinash Dayanand 2018-01-23  2971  		}
ec620ca1f Avinash Dayanand 2018-01-23  2972  
ec620ca1f Avinash Dayanand 2018-01-23  2973  		if (mask.vlan_id) {
ec620ca1f Avinash Dayanand 2018-01-23  2974  			hash_for_each_safe(vsi->mac_filter_hash, bkt, h, f,
ec620ca1f Avinash Dayanand 2018-01-23  2975  					   hlist) {
ec620ca1f Avinash Dayanand 2018-01-23  2976  				if (f->vlan == ntohs(data.vlan_id)) {
ec620ca1f Avinash Dayanand 2018-01-23  2977  					found = true;
ec620ca1f Avinash Dayanand 2018-01-23  2978  					break;
ec620ca1f Avinash Dayanand 2018-01-23  2979  				}
ec620ca1f Avinash Dayanand 2018-01-23  2980  			}
ec620ca1f Avinash Dayanand 2018-01-23  2981  			if (!found) {
ec620ca1f Avinash Dayanand 2018-01-23  2982  				dev_info(&pf->pdev->dev,
ec620ca1f Avinash Dayanand 2018-01-23  2983  					 "VF %d doesn't have any VLAN id %u\n",
ec620ca1f Avinash Dayanand 2018-01-23  2984  					 vf->vf_id, ntohs(data.vlan_id));
ec620ca1f Avinash Dayanand 2018-01-23  2985  				goto err;
ec620ca1f Avinash Dayanand 2018-01-23  2986  			}
ec620ca1f Avinash Dayanand 2018-01-23  2987  		}
ec620ca1f Avinash Dayanand 2018-01-23  2988  	} else {
ec620ca1f Avinash Dayanand 2018-01-23  2989  		/* Check if VF is trusted */
ec620ca1f Avinash Dayanand 2018-01-23  2990  		if (!test_bit(I40E_VIRTCHNL_VF_CAP_PRIVILEGE, &vf->vf_caps)) {
ec620ca1f Avinash Dayanand 2018-01-23  2991  			dev_err(&pf->pdev->dev,
ec620ca1f Avinash Dayanand 2018-01-23  2992  				"VF %d not trusted, make VF trusted to add advanced mode ADq cloud filters\n",
ec620ca1f Avinash Dayanand 2018-01-23  2993  				vf->vf_id);
ec620ca1f Avinash Dayanand 2018-01-23  2994  			return I40E_ERR_CONFIG;
ec620ca1f Avinash Dayanand 2018-01-23  2995  		}
ec620ca1f Avinash Dayanand 2018-01-23  2996  	}
ec620ca1f Avinash Dayanand 2018-01-23  2997  
ec620ca1f Avinash Dayanand 2018-01-23  2998  	if (mask.dst_mac[0] & data.dst_mac[0]) {
ec620ca1f Avinash Dayanand 2018-01-23  2999  		if (is_broadcast_ether_addr(data.dst_mac) ||
ec620ca1f Avinash Dayanand 2018-01-23  3000  		    is_zero_ether_addr(data.dst_mac)) {
ec620ca1f Avinash Dayanand 2018-01-23  3001  			dev_info(&pf->pdev->dev, "VF %d: Invalid Dest MAC addr %pM\n",
ec620ca1f Avinash Dayanand 2018-01-23  3002  				 vf->vf_id, data.dst_mac);
ec620ca1f Avinash Dayanand 2018-01-23  3003  			goto err;
ec620ca1f Avinash Dayanand 2018-01-23  3004  		}
ec620ca1f Avinash Dayanand 2018-01-23  3005  	}
ec620ca1f Avinash Dayanand 2018-01-23  3006  
ec620ca1f Avinash Dayanand 2018-01-23  3007  	if (mask.src_mac[0] & data.src_mac[0]) {
ec620ca1f Avinash Dayanand 2018-01-23  3008  		if (is_broadcast_ether_addr(data.src_mac) ||
ec620ca1f Avinash Dayanand 2018-01-23  3009  		    is_zero_ether_addr(data.src_mac)) {
ec620ca1f Avinash Dayanand 2018-01-23  3010  			dev_info(&pf->pdev->dev, "VF %d: Invalid Source MAC addr %pM\n",
ec620ca1f Avinash Dayanand 2018-01-23  3011  				 vf->vf_id, data.src_mac);
ec620ca1f Avinash Dayanand 2018-01-23  3012  			goto err;
ec620ca1f Avinash Dayanand 2018-01-23  3013  		}
ec620ca1f Avinash Dayanand 2018-01-23  3014  	}
ec620ca1f Avinash Dayanand 2018-01-23  3015  
ec620ca1f Avinash Dayanand 2018-01-23  3016  	if (mask.dst_port & data.dst_port) {
ec620ca1f Avinash Dayanand 2018-01-23 @3017  		if (!data.dst_port || be16_to_cpu(data.dst_port) > 0xFFFF) {
                                                                              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Normally, I wouldn't report these impossible conditions because I agree
with Linus, that to a human reader it helps to have an upper bound.
Smatch ignores impossible limits if there in a canonical bounds check
format like this "if (foo < LOW || foo > HIGH) {".

Here the "be16_" implies that it can't be higher than 0xFFFF so it's
kind of built-in that this condition can never be true... I believe
newer versions of GCC start complain though so you might want to get rid
of the condition.  Or you can leave it as-is...

ec620ca1f Avinash Dayanand 2018-01-23  3018  			dev_info(&pf->pdev->dev, "VF %d: Invalid Dest port\n",
ec620ca1f Avinash Dayanand 2018-01-23  3019  				 vf->vf_id);
ec620ca1f Avinash Dayanand 2018-01-23  3020  			goto err;
ec620ca1f Avinash Dayanand 2018-01-23  3021  		}
ec620ca1f Avinash Dayanand 2018-01-23  3022  	}
ec620ca1f Avinash Dayanand 2018-01-23  3023  
ec620ca1f Avinash Dayanand 2018-01-23  3024  	if (mask.src_port & data.src_port) {
ec620ca1f Avinash Dayanand 2018-01-23  3025  		if (!data.src_port || be16_to_cpu(data.src_port) > 0xFFFF) {
ec620ca1f Avinash Dayanand 2018-01-23  3026  			dev_info(&pf->pdev->dev, "VF %d: Invalid Source port\n",
ec620ca1f Avinash Dayanand 2018-01-23  3027  				 vf->vf_id);
ec620ca1f Avinash Dayanand 2018-01-23  3028  			goto err;
ec620ca1f Avinash Dayanand 2018-01-23  3029  		}
ec620ca1f Avinash Dayanand 2018-01-23  3030  	}
ec620ca1f Avinash Dayanand 2018-01-23  3031  
ec620ca1f Avinash Dayanand 2018-01-23  3032  	if (tc_filter->flow_type != VIRTCHNL_TCP_V6_FLOW &&
ec620ca1f Avinash Dayanand 2018-01-23  3033  	    tc_filter->flow_type != VIRTCHNL_TCP_V4_FLOW) {
ec620ca1f Avinash Dayanand 2018-01-23  3034  		dev_info(&pf->pdev->dev, "VF %d: Invalid Flow type\n",
ec620ca1f Avinash Dayanand 2018-01-23  3035  			 vf->vf_id);
ec620ca1f Avinash Dayanand 2018-01-23  3036  		goto err;
ec620ca1f Avinash Dayanand 2018-01-23  3037  	}
ec620ca1f Avinash Dayanand 2018-01-23  3038  
ec620ca1f Avinash Dayanand 2018-01-23  3039  	if (mask.vlan_id & data.vlan_id) {
ec620ca1f Avinash Dayanand 2018-01-23  3040  		if (ntohs(data.vlan_id) > I40E_MAX_VLANID) {
ec620ca1f Avinash Dayanand 2018-01-23  3041  			dev_info(&pf->pdev->dev, "VF %d: invalid VLAN ID\n",
ec620ca1f Avinash Dayanand 2018-01-23  3042  				 vf->vf_id);
ec620ca1f Avinash Dayanand 2018-01-23  3043  			goto err;
ec620ca1f Avinash Dayanand 2018-01-23  3044  		}
ec620ca1f Avinash Dayanand 2018-01-23  3045  	}
ec620ca1f Avinash Dayanand 2018-01-23  3046  
ec620ca1f Avinash Dayanand 2018-01-23  3047  	return I40E_SUCCESS;
ec620ca1f Avinash Dayanand 2018-01-23  3048  err:
ec620ca1f Avinash Dayanand 2018-01-23  3049  	return I40E_ERR_CONFIG;
ec620ca1f Avinash Dayanand 2018-01-23  3050  }
ec620ca1f Avinash Dayanand 2018-01-23  3051  

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
