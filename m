From: kbuild test robot <lkp@intel.com>
Date: Mon, 1 Jun 2020 01:32:27 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 8/57]
 drivers/net/ethernet/intel/ice/ice_idc.c:432:7: error: implicit declaration
 of function 'ice_pf_state_is_nominal'
Message-ID: <202006010125.xuYNZ2xQ%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   cf731225b28c18d6e612900febee69b61a395ed8
commit: d0ed22b261179970c5551628fd3b78ea4c0652ac [8/57] ice: Support resource allocation requests
config: ia64-allmodconfig (attached as .config)
compiler: ia64-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout d0ed22b261179970c5551628fd3b78ea4c0652ac
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=ia64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

drivers/net/ethernet/intel/ice/ice_idc.c: In function 'ice_peer_alloc_rdma_qsets':
drivers/net/ethernet/intel/ice/ice_idc.c:270:7: error: implicit declaration of function 'ice_validate_peer_dev' [-Werror=implicit-function-declaration]
270 |  if (!ice_validate_peer_dev(peer_dev) || !res)
|       ^~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/ice/ice_idc.c: In function 'ice_peer_alloc_res':
>> drivers/net/ethernet/intel/ice/ice_idc.c:432:7: error: implicit declaration of function 'ice_pf_state_is_nominal' [-Werror=implicit-function-declaration]
432 |  if (!ice_pf_state_is_nominal(pf))
|       ^~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/ice/ice_idc.c: In function 'ice_peer_unregister':
drivers/net/ethernet/intel/ice/ice_idc.c:496:17: error: implicit declaration of function 'peer_to_ice_dev_int' [-Werror=implicit-function-declaration]
496 |  peer_dev_int = peer_to_ice_dev_int(peer_dev);
|                 ^~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/intel/ice/ice_idc.c:496:15: warning: assignment to 'struct ice_peer_dev_int *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
496 |  peer_dev_int = peer_to_ice_dev_int(peer_dev);
|               ^
drivers/net/ethernet/intel/ice/ice_idc.c:498:8: error: implicit declaration of function 'ice_peer_close'; did you mean 'ice_vsi_close'? [-Werror=implicit-function-declaration]
498 |  ret = ice_peer_close(peer_dev_int, &reason);
|        ^~~~~~~~~~~~~~
|        ice_vsi_close
drivers/net/ethernet/intel/ice/ice_idc.c: In function 'ice_peer_register':
drivers/net/ethernet/intel/ice/ice_idc.c:543:15: warning: assignment to 'struct ice_peer_dev_int *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
543 |  peer_dev_int = peer_to_ice_dev_int(peer_dev);
|               ^
drivers/net/ethernet/intel/ice/ice_idc.c: In function 'ice_peer_update_vsi_filter':
>> drivers/net/ethernet/intel/ice/ice_idc.c:581:8: error: implicit declaration of function 'ice_cfg_iwarp_fltr' [-Werror=implicit-function-declaration]
581 |  ret = ice_cfg_iwarp_fltr(&pf->hw, vsi->idx, enable);
|        ^~~~~~~~~~~~~~~~~~
At top level:
drivers/net/ethernet/intel/ice/ice_idc.c:597:30: warning: 'ops' defined but not used [-Wunused-const-variable=]
597 | static const struct iidc_ops ops = {
|                              ^~~
cc1: some warnings being treated as errors

vim +/ice_pf_state_is_nominal +432 drivers/net/ethernet/intel/ice/ice_idc.c

   247	
   248	/**
   249	 * ice_peer_alloc_rdma_qsets - Allocate Leaf Nodes for RDMA Qset
   250	 * @peer_dev: peer that is requesting the Leaf Nodes
   251	 * @res: Resources to be allocated
   252	 * @partial_acceptable: If partial allocation is acceptable to the peer
   253	 *
   254	 * This function allocates Leaf Nodes for given RDMA Qset resources
   255	 * for the peer device.
   256	 */
   257	static int
   258	ice_peer_alloc_rdma_qsets(struct iidc_peer_dev *peer_dev, struct iidc_res *res,
   259				  int __always_unused partial_acceptable)
   260	{
   261		u16 max_rdmaqs[ICE_MAX_TRAFFIC_CLASS];
   262		enum ice_status status;
   263		struct ice_vsi *vsi;
   264		struct device *dev;
   265		struct ice_pf *pf;
   266		int i, ret = 0;
   267		u32 *qset_teid;
   268		u16 *qs_handle;
   269	
 > 270		if (!ice_validate_peer_dev(peer_dev) || !res)
   271			return -EINVAL;
   272	
   273		pf = pci_get_drvdata(peer_dev->pdev);
   274		dev = ice_pf_to_dev(pf);
   275	
   276		if (res->cnt_req > ICE_MAX_TXQ_PER_TXQG)
   277			return -EINVAL;
   278	
   279		qset_teid = kcalloc(res->cnt_req, sizeof(*qset_teid), GFP_KERNEL);
   280		if (!qset_teid)
   281			return -ENOMEM;
   282	
   283		qs_handle = kcalloc(res->cnt_req, sizeof(*qs_handle), GFP_KERNEL);
   284		if (!qs_handle) {
   285			kfree(qset_teid);
   286			return -ENOMEM;
   287		}
   288	
   289		ice_for_each_traffic_class(i)
   290			max_rdmaqs[i] = 0;
   291	
   292		for (i = 0; i < res->cnt_req; i++) {
   293			struct iidc_rdma_qset_params *qset;
   294	
   295			qset = &res->res[i].res.qsets;
   296			if (qset->vsi_id != peer_dev->pf_vsi_num) {
   297				dev_err(dev, "RDMA QSet invalid VSI requested\n");
   298				ret = -EINVAL;
   299				goto out;
   300			}
   301			max_rdmaqs[qset->tc]++;
   302			qs_handle[i] = qset->qs_handle;
   303		}
   304	
   305		vsi = ice_find_vsi(pf, peer_dev->pf_vsi_num);
   306		if (!vsi) {
   307			dev_err(dev, "RDMA QSet invalid VSI\n");
   308			ret = -EINVAL;
   309			goto out;
   310		}
   311	
   312		status = ice_cfg_vsi_rdma(vsi->port_info, vsi->idx, vsi->tc_cfg.ena_tc,
   313					  max_rdmaqs);
   314		if (status) {
   315			dev_err(dev, "Failed VSI RDMA qset config\n");
   316			ret = -EINVAL;
   317			goto out;
   318		}
   319	
   320		for (i = 0; i < res->cnt_req; i++) {
   321			struct iidc_rdma_qset_params *qset;
   322	
   323			qset = &res->res[i].res.qsets;
   324			status = ice_ena_vsi_rdma_qset(vsi->port_info, vsi->idx,
   325						       qset->tc, &qs_handle[i], 1,
   326						       &qset_teid[i]);
   327			if (status) {
   328				dev_err(dev, "Failed VSI RDMA qset enable\n");
   329				ret = -EINVAL;
   330				goto out;
   331			}
   332			vsi->qset_handle[qset->tc] = qset->qs_handle;
   333			qset->teid = qset_teid[i];
   334		}
   335	
   336	out:
   337		kfree(qset_teid);
   338		kfree(qs_handle);
   339		return ret;
   340	}
   341	
   342	/**
   343	 * ice_peer_free_rdma_qsets - Free leaf nodes for RDMA Qset
   344	 * @peer_dev: peer that requested qsets to be freed
   345	 * @res: Resource to be freed
   346	 */
   347	static int
   348	ice_peer_free_rdma_qsets(struct iidc_peer_dev *peer_dev, struct iidc_res *res)
   349	{
   350		enum ice_status status;
   351		int count, i, ret = 0;
   352		struct ice_vsi *vsi;
   353		struct device *dev;
   354		struct ice_pf *pf;
   355		u16 vsi_id;
   356		u32 *teid;
   357		u16 *q_id;
   358	
   359		if (!ice_validate_peer_dev(peer_dev) || !res)
   360			return -EINVAL;
   361	
   362		pf = pci_get_drvdata(peer_dev->pdev);
   363		dev = ice_pf_to_dev(pf);
   364	
   365		count = res->res_allocated;
   366		if (count > ICE_MAX_TXQ_PER_TXQG)
   367			return -EINVAL;
   368	
   369		teid = kcalloc(count, sizeof(*teid), GFP_KERNEL);
   370		if (!teid)
   371			return -ENOMEM;
   372	
   373		q_id = kcalloc(count, sizeof(*q_id), GFP_KERNEL);
   374		if (!q_id) {
   375			kfree(teid);
   376			return -ENOMEM;
   377		}
   378	
   379		vsi_id = res->res[0].res.qsets.vsi_id;
   380		vsi = ice_find_vsi(pf, vsi_id);
   381		if (!vsi) {
   382			dev_err(dev, "RDMA Invalid VSI\n");
   383			ret = -EINVAL;
   384			goto rdma_free_out;
   385		}
   386	
   387		for (i = 0; i < count; i++) {
   388			struct iidc_rdma_qset_params *qset;
   389	
   390			qset = &res->res[i].res.qsets;
   391			if (qset->vsi_id != vsi_id) {
   392				dev_err(dev, "RDMA Invalid VSI ID\n");
   393				ret = -EINVAL;
   394				goto rdma_free_out;
   395			}
   396			q_id[i] = qset->qs_handle;
   397			teid[i] = qset->teid;
   398	
   399			vsi->qset_handle[qset->tc] = 0;
   400		}
   401	
   402		status = ice_dis_vsi_rdma_qset(vsi->port_info, count, teid, q_id);
   403		if (status)
   404			ret = -EINVAL;
   405	
   406	rdma_free_out:
   407		kfree(teid);
   408		kfree(q_id);
   409	
   410		return ret;
   411	}
   412	
   413	/**
   414	 * ice_peer_alloc_res - Allocate requested resources for peer device
   415	 * @peer_dev: peer that is requesting resources
   416	 * @res: Resources to be allocated
   417	 * @partial_acceptable: If partial allocation is acceptable to the peer
   418	 *
   419	 * This function allocates requested resources for the peer device.
   420	 */
   421	static int
   422	ice_peer_alloc_res(struct iidc_peer_dev *peer_dev, struct iidc_res *res,
   423			   int partial_acceptable)
   424	{
   425		struct ice_pf *pf;
   426		int ret;
   427	
   428		if (!ice_validate_peer_dev(peer_dev) || !res)
   429			return -EINVAL;
   430	
   431		pf = pci_get_drvdata(peer_dev->pdev);
 > 432		if (!ice_pf_state_is_nominal(pf))
   433			return -EBUSY;
   434	
   435		switch (res->res_type) {
   436		case IIDC_RDMA_QSETS_TXSCHED:
   437			ret = ice_peer_alloc_rdma_qsets(peer_dev, res,
   438							partial_acceptable);
   439			break;
   440		default:
   441			ret = -EINVAL;
   442			break;
   443		}
   444	
   445		return ret;
   446	}
   447	
   448	/**
   449	 * ice_peer_free_res - Free given resources
   450	 * @peer_dev: peer that is requesting freeing of resources
   451	 * @res: Resources to be freed
   452	 *
   453	 * Free/Release resources allocated to given peer device.
   454	 */
   455	static int
   456	ice_peer_free_res(struct iidc_peer_dev *peer_dev, struct iidc_res *res)
   457	{
   458		int ret;
   459	
   460		if (!ice_validate_peer_dev(peer_dev) || !res)
   461			return -EINVAL;
   462	
   463		switch (res->res_type) {
   464		case IIDC_RDMA_QSETS_TXSCHED:
   465			ret = ice_peer_free_rdma_qsets(peer_dev, res);
   466			break;
   467		default:
   468			ret = -EINVAL;
   469			break;
   470		}
   471	
   472		return ret;
   473	}
   474	
   475	/**
   476	 * ice_peer_unregister - request to unregister peer
   477	 * @peer_dev: peer device
   478	 *
   479	 * This function triggers close/remove on peer_dev allowing peer
   480	 * to unregister.
   481	 */
   482	static int ice_peer_unregister(struct iidc_peer_dev *peer_dev)
   483	{
   484		enum iidc_close_reason reason = IIDC_REASON_PEER_DEV_UNINIT;
   485		struct ice_peer_dev_int *peer_dev_int;
   486		struct ice_pf *pf;
   487		int ret;
   488	
   489		if (!ice_validate_peer_dev(peer_dev))
   490			return -EINVAL;
   491	
   492		pf = pci_get_drvdata(peer_dev->pdev);
   493		if (ice_is_reset_in_progress(pf->state))
   494			return -EBUSY;
   495	
   496		peer_dev_int = peer_to_ice_dev_int(peer_dev);
   497	
 > 498		ret = ice_peer_close(peer_dev_int, &reason);
   499		if (ret)
   500			return ret;
   501	
   502		peer_dev->peer_ops = NULL;
   503	
   504		ice_peer_state_change(peer_dev_int, ICE_PEER_DEV_STATE_REMOVED, false);
   505	
   506		return 0;
   507	}
   508	
   509	/**
   510	 * ice_peer_register - Called by peer to open communication with LAN
   511	 * @peer_dev: ptr to peer device
   512	 *
   513	 * registering peer is expected to populate the ice_peerdrv->name field
   514	 * before calling this function.
   515	 */
   516	static int ice_peer_register(struct iidc_peer_dev *peer_dev)
   517	{
   518		struct ice_peer_drv_int *peer_drv_int;
   519		struct ice_peer_dev_int *peer_dev_int;
   520		struct iidc_peer_drv *peer_drv;
   521	
   522		if (!peer_dev) {
   523			pr_err("Failed to reg peer dev: peer_dev ptr NULL\n");
   524			return -EINVAL;
   525		}
   526	
   527		if (!peer_dev->pdev) {
   528			pr_err("Failed to reg peer dev: peer dev pdev NULL\n");
   529			return -EINVAL;
   530		}
   531	
   532		if (!peer_dev->peer_ops || !peer_dev->ops) {
   533			pr_err("Failed to reg peer dev: peer dev peer_ops/ops NULL\n");
   534			return -EINVAL;
   535		}
   536	
   537		peer_drv = peer_dev->peer_drv;
   538		if (!peer_drv) {
   539			pr_err("Failed to reg peer dev: peer drv NULL\n");
   540			return -EINVAL;
   541		}
   542	
   543		peer_dev_int = peer_to_ice_dev_int(peer_dev);
   544		peer_drv_int = peer_dev_int->peer_drv_int;
   545		if (!peer_drv_int) {
   546			pr_err("Failed to match peer_drv_int to peer_dev\n");
   547			return -EINVAL;
   548		}
   549	
   550		peer_drv_int->peer_drv = peer_drv;
   551	
   552		ice_peer_state_change(peer_dev_int, ICE_PEER_DEV_STATE_PROBED, false);
   553	
   554		return 0;
   555	}
   556	
   557	/**
   558	 * ice_peer_update_vsi_filter - update main VSI filters for RDMA
   559	 * @peer_dev: pointer to RDMA peer device
   560	 * @filter: selection of filters to enable or disable
   561	 * @enable: bool whether to enable or disable filters
   562	 */
   563	static int
   564	ice_peer_update_vsi_filter(struct iidc_peer_dev *peer_dev,
   565				   enum iidc_rdma_filter __always_unused filter,
   566				   bool enable)
   567	{
   568		struct ice_vsi *vsi;
   569		struct ice_pf *pf;
   570		int ret;
   571	
   572		if (!ice_validate_peer_dev(peer_dev))
   573			return -EINVAL;
   574	
   575		pf = pci_get_drvdata(peer_dev->pdev);
   576	
   577		vsi = ice_get_main_vsi(pf);
   578		if (!vsi)
   579			return -EINVAL;
   580	
 > 581		ret = ice_cfg_iwarp_fltr(&pf->hw, vsi->idx, enable);
   582	
   583		if (ret) {
   584			dev_err(ice_pf_to_dev(pf), "Failed to  %sable iWARP filtering\n",
   585				enable ? "en" : "dis");
   586		} else {
   587			if (enable)
   588				vsi->info.q_opt_flags |= ICE_AQ_VSI_Q_OPT_PE_FLTR_EN;
   589			else
   590				vsi->info.q_opt_flags &= ~ICE_AQ_VSI_Q_OPT_PE_FLTR_EN;
   591		}
   592	
   593		return ret;
   594	}
   595	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 57849 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20200601/edfbb316/attachment-0001.bin>
