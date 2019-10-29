From: kbuild test robot <lkp@intel.com>
Date: Wed, 30 Oct 2019 03:02:16 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 61/66]
 drivers/net/ethernet/intel/ice/ice_dcb_lib.c:173:1-8: alloc with no test,
 possible model on line 176
Message-ID: <201910300316.DlrnkW44%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   cb2dcdacc18ac93f735552203907ecd54d527b40
commit: 162edbdf278fe8325905aaa6657e87db55126b95 [61/66] ice: Use ice_ena_vsi and ice_dis_vsi in DCB configuration flow

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


coccinelle warnings: (new ones prefixed by >>)

>> drivers/net/ethernet/intel/ice/ice_dcb_lib.c:173:1-8: alloc with no test, possible model on line 176

vim +173 drivers/net/ethernet/intel/ice/ice_dcb_lib.c

   141	
   142	/**
   143	 * ice_pf_dcb_cfg - Apply new DCB configuration
   144	 * @pf: pointer to the PF struct
   145	 * @new_cfg: DCBX config to apply
   146	 * @locked: is the RTNL held
   147	 */
   148	static
   149	int ice_pf_dcb_cfg(struct ice_pf *pf, struct ice_dcbx_cfg *new_cfg, bool locked)
   150	{
   151		struct ice_dcbx_cfg *old_cfg, *curr_cfg;
   152		struct ice_aqc_port_ets_elem buf = { 0 };
   153		struct ice_vsi *pf_vsi;
   154		int ret = 0;
   155	
   156		curr_cfg = &pf->hw.port_info->local_dcbx_cfg;
   157	
   158		/* Enable DCB tagging only when more than one TC */
   159		if (ice_dcb_get_num_tc(new_cfg) > 1) {
   160			dev_dbg(&pf->pdev->dev, "DCB tagging enabled (num TC > 1)\n");
   161			set_bit(ICE_FLAG_DCB_ENA, pf->flags);
   162		} else {
   163			dev_dbg(&pf->pdev->dev, "DCB tagging disabled (num TC = 1)\n");
   164			clear_bit(ICE_FLAG_DCB_ENA, pf->flags);
   165		}
   166	
   167		if (!memcmp(new_cfg, curr_cfg, sizeof(*new_cfg))) {
   168			dev_dbg(&pf->pdev->dev, "No change in DCB config required\n");
   169			return ret;
   170		}
   171	
   172		/* Store old config in case FW config fails */
 > 173		old_cfg = kzalloc(sizeof(*old_cfg), GFP_KERNEL);
   174		memcpy(old_cfg, curr_cfg, sizeof(*old_cfg));
   175	
 > 176		pf_vsi = ice_get_main_vsi(pf);
   177		if (!pf_vsi) {
   178			dev_dbg(&pf->pdev->dev, "PF VSI doesn't exist\n");
   179			ret = -EINVAL;
   180			goto free_cfg;
   181		}
   182	
   183		/* avoid race conditions by holding the lock while disabling and
   184		 * re-enabling the VSI
   185		 */
   186		if (!locked)
   187			rtnl_lock();
   188		ice_dis_vsi(pf_vsi, true);
   189	
   190		memcpy(curr_cfg, new_cfg, sizeof(*curr_cfg));
   191		memcpy(&curr_cfg->etsrec, &curr_cfg->etscfg, sizeof(curr_cfg->etsrec));
   192	
   193		/* Only send new config to HW if we are in SW LLDP mode. Otherwise,
   194		 * the new config came from the HW in the first place.
   195		 */
   196		if (pf->hw.port_info->is_sw_lldp) {
   197			ret = ice_set_dcb_cfg(pf->hw.port_info);
   198			if (ret) {
   199				dev_err(&pf->pdev->dev, "Set DCB Config failed\n");
   200				/* Restore previous settings to local config */
   201				memcpy(curr_cfg, old_cfg, sizeof(*curr_cfg));
   202				goto out;
   203			}
   204		}
   205	
   206		ret = ice_query_port_ets(pf->hw.port_info, &buf, sizeof(buf), NULL);
   207		if (ret) {
   208			dev_err(&pf->pdev->dev, "Query Port ETS failed\n");
   209			goto out;
   210		}
   211	
   212		ice_pf_dcb_recfg(pf);
   213	
   214	out:
   215		ice_ena_vsi(pf_vsi, true);
   216		if (!locked)
   217			rtnl_unlock();
   218	free_cfg:
   219		kfree(old_cfg);
   220		return ret;
   221	}
   222	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
