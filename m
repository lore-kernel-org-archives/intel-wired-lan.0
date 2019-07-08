From: kbuild test robot <lkp@intel.com>
Date: Tue, 9 Jul 2019 00:23:24 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 26/51]
 drivers/net//ethernet/intel/ice/ice_lib.c:3165:11: error: implicit
 declaration of function 'ice_schedule_reset';
 did you mean 'ice_check_reset'?
Message-ID: <201907090023.WeyYjytL%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://kernel.googlesource.com/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   46065ef1595f1bba9b1c9ed45cb501b95ea23259
commit: 84af3c2be0fede32af62516ffb6100145cffabab [26/51] ice: Implement ethtool ops for channels
config: arm-allmodconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (GCC) 7.4.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 84af3c2be0fede32af62516ffb6100145cffabab
        # save the attached .config to linux build tree
        GCC_VERSION=7.4.0 make.cross ARCH=arm 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/net//ethernet/intel/ice/ice_lib.c: In function 'ice_vsi_rebuild':
>> drivers/net//ethernet/intel/ice/ice_lib.c:3165:11: error: implicit declaration of function 'ice_schedule_reset'; did you mean 'ice_check_reset'? [-Werror=implicit-function-declaration]
       return ice_schedule_reset(pf, ICE_RESET_PFR);
              ^~~~~~~~~~~~~~~~~~
              ice_check_reset
   cc1: some warnings being treated as errors

vim +3165 drivers/net//ethernet/intel/ice/ice_lib.c

  3029	
  3030	/**
  3031	 * ice_vsi_rebuild - Rebuild VSI after reset
  3032	 * @vsi: VSI to be rebuild
  3033	 * @init_vsi: is this an initialization or a reconfigure of the VSI
  3034	 *
  3035	 * Returns 0 on success and negative value on failure
  3036	 */
  3037	int ice_vsi_rebuild(struct ice_vsi *vsi, bool init_vsi)
  3038	{
  3039		u16 max_txqs[ICE_MAX_TRAFFIC_CLASS] = { 0 };
  3040		struct ice_vf *vf = NULL;
  3041		enum ice_status status;
  3042		struct ice_pf *pf;
  3043		int ret, i;
  3044	
  3045		if (!vsi)
  3046			return -EINVAL;
  3047	
  3048		pf = vsi->back;
  3049		if (vsi->type == ICE_VSI_VF)
  3050			vf = &pf->vf[vsi->vf_id];
  3051	
  3052		ice_rm_vsi_lan_cfg(vsi->port_info, vsi->idx);
  3053		ice_vsi_free_q_vectors(vsi);
  3054	
  3055		/* SR-IOV determines needed MSIX resources all at once instead of per
  3056		 * VSI since when VFs are spawned we know how many VFs there are and how
  3057		 * many interrupts each VF needs. SR-IOV MSIX resources are also
  3058		 * cleared in the same manner.
  3059		 */
  3060		if (vsi->type != ICE_VSI_VF) {
  3061			/* reclaim SW interrupts back to the common pool */
  3062			ice_free_res(pf->irq_tracker, vsi->base_vector, vsi->idx);
  3063			pf->num_avail_sw_msix += vsi->num_q_vectors;
  3064			vsi->base_vector = 0;
  3065		}
  3066	
  3067		if (ice_is_xdp_ena_vsi(vsi))
  3068			/* return value check can be skipped here, it always returns
  3069			 * 0 if reset is in progress
  3070			 */
  3071			ice_destroy_xdp_rings(vsi);
  3072		ice_vsi_clear_rings(vsi);
  3073		ice_vsi_free_arrays(vsi);
  3074		ice_dev_onetime_setup(&pf->hw);
  3075		if (vsi->req_txq || vsi->req_rxq)
  3076			ice_vsi_put_qs(vsi);
  3077		if (vsi->type == ICE_VSI_VF)
  3078			ice_vsi_set_num_qs(vsi, vf->vf_id);
  3079		else
  3080			ice_vsi_set_num_qs(vsi, ICE_INVAL_VFID);
  3081		if (vsi->req_txq || vsi->req_rxq)
  3082			ice_vsi_get_qs(vsi);
  3083		ice_vsi_set_tc_cfg(vsi);
  3084	
  3085		/* Initialize VSI struct elements and create VSI in FW */
  3086		ret = ice_vsi_init(vsi, init_vsi);
  3087		if (ret < 0)
  3088			goto err_vsi;
  3089	
  3090		ret = ice_vsi_alloc_arrays(vsi);
  3091		if (ret < 0)
  3092			goto err_vsi;
  3093	
  3094		switch (vsi->type) {
  3095		case ICE_VSI_PF:
  3096			ret = ice_vsi_alloc_q_vectors(vsi);
  3097			if (ret)
  3098				goto err_rings;
  3099	
  3100			ret = ice_vsi_setup_vector_base(vsi);
  3101			if (ret)
  3102				goto err_vectors;
  3103	
  3104			ret = ice_vsi_set_q_vectors_reg_idx(vsi);
  3105			if (ret)
  3106				goto err_vectors;
  3107	
  3108			ret = ice_vsi_alloc_rings(vsi);
  3109			if (ret)
  3110				goto err_vectors;
  3111	
  3112			ice_vsi_map_rings_to_vectors(vsi);
  3113			if (ice_is_xdp_ena_vsi(vsi)) {
  3114				vsi->num_xdp_txq = vsi->alloc_txq;
  3115				vsi->xdp_mapping_mode = ICE_VSI_MAP_CONTIG;
  3116				ret = ice_prepare_xdp_rings(vsi);
  3117				if (ret)
  3118					goto err_vectors;
  3119			}
  3120			/* Do not exit if configuring RSS had an issue, at least
  3121			 * receive traffic on first queue. Hence no need to capture
  3122			 * return value
  3123			 */
  3124			if (test_bit(ICE_FLAG_RSS_ENA, pf->flags))
  3125				ice_vsi_cfg_rss_lut_key(vsi);
  3126			break;
  3127		case ICE_VSI_VF:
  3128			ret = ice_vsi_alloc_q_vectors(vsi);
  3129			if (ret)
  3130				goto err_rings;
  3131	
  3132			ret = ice_vsi_set_q_vectors_reg_idx(vsi);
  3133			if (ret)
  3134				goto err_vectors;
  3135	
  3136			ret = ice_vsi_alloc_rings(vsi);
  3137			if (ret)
  3138				goto err_vectors;
  3139	
  3140			pf->q_left_tx -= vsi->alloc_txq;
  3141			pf->q_left_rx -= vsi->alloc_rxq;
  3142			break;
  3143		default:
  3144			break;
  3145		}
  3146	
  3147		/* configure VSI nodes based on number of queues and TC's */
  3148		for (i = 0; i < vsi->tc_cfg.numtc; i++) {
  3149			max_txqs[i] = vsi->alloc_txq;
  3150	
  3151			if (ice_is_xdp_ena_vsi(vsi))
  3152				max_txqs[i] += vsi->num_xdp_txq;
  3153		}
  3154	
  3155		status = ice_cfg_vsi_lan(vsi->port_info, vsi->idx, vsi->tc_cfg.ena_tc,
  3156					 max_txqs);
  3157		if (status) {
  3158			dev_err(&pf->pdev->dev,
  3159				"VSI %d failed lan queue config, error %d\n",
  3160				vsi->vsi_num, status);
  3161			if (init_vsi) {
  3162				ret = -EIO;
  3163				goto err_vectors;
  3164			} else {
> 3165				return ice_schedule_reset(pf, ICE_RESET_PFR);
  3166			}
  3167		}
  3168		return 0;
  3169	
  3170	err_vectors:
  3171		ice_vsi_free_q_vectors(vsi);
  3172	err_rings:
  3173		if (vsi->netdev) {
  3174			vsi->current_netdev_flags = 0;
  3175			unregister_netdev(vsi->netdev);
  3176			free_netdev(vsi->netdev);
  3177			vsi->netdev = NULL;
  3178		}
  3179	err_vsi:
  3180		ice_vsi_clear(vsi);
  3181		set_bit(__ICE_RESET_FAILED, pf->state);
  3182		return ret;
  3183	}
  3184	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 70678 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20190709/656249b9/attachment-0001.bin>
