From: Julia Lawall <julia.lawall@lip6.fr>
Date: Thu, 9 Aug 2018 23:46:17 +0200 (CEST)
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 27/70]
 drivers/net/ethernet/intel/i40e/i40e_main.c:13868:3-9: ERROR: missing
 iounmap;
 ioremap on line 13750 and execution via conditional on line 13867 (fwd)
Message-ID: <alpine.DEB.2.20.1808092342280.2860@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

There is a kfree of pf on line 13670 that is immediately followed by a
derference of the same value.

There is not enough context information to see the complete problem, but
Coccinelle seems to expect an iounmap on line 13868.  Probably there is an
iounmap at the destination of some of the gotos shown below, and so the
direct return looks suspicious.

julia

---------- Forwarded message ----------
Date: Fri, 10 Aug 2018 05:21:55 +0800
From: kbuild test robot <lkp@intel.com>
To: kbuild@01.org
Cc: Julia Lawall <julia.lawall@lip6.fr>
Subject: [jkirsher-next-queue:dev-queue 27/70]
    drivers/net/ethernet/intel/i40e/i40e_main.c:13868:3-9: ERROR: missing
    iounmap; ioremap on line 13750 and execution via conditional on line 13867

CC: kbuild-all at 01.org
CC: intel-wired-lan at lists.osuosl.org
TO: Mariusz Stachura <mariusz.stachura@intel.com>
CC: Jeff Kirsher <jeffrey.t.kirsher@intel.com>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   a775e094cd94aab3220a66487e1f4717f3bb5fb1
commit: 59533cb2e2943f2800880ded74b0f26e7cee63a7 [27/70] i40e: Introduce recovery mode support
:::::: branch date: 3 hours ago
:::::: commit date: 3 hours ago

>> drivers/net/ethernet/intel/i40e/i40e_main.c:13868:3-9: ERROR: missing iounmap; ioremap on line 13750 and execution via conditional on line 13867
--
>> drivers/net/ethernet/intel/i40e/i40e_main.c:13671:34-36: ERROR: reference preceded by free on line 13670

# https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git/commit/?id=59533cb2e2943f2800880ded74b0f26e7cee63a7
git remote add jkirsher-next-queue https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git
git remote update jkirsher-next-queue
git checkout 59533cb2e2943f2800880ded74b0f26e7cee63a7
vim +13868 drivers/net/ethernet/intel/i40e/i40e_main.c

59533cb2e2 Mariusz Stachura      2018-08-09  13572
59533cb2e2 Mariusz Stachura      2018-08-09  13573  /**
59533cb2e2 Mariusz Stachura      2018-08-09  13574   * i40e_init_recovery_mode - initialize subsystems needed in recovery mode
59533cb2e2 Mariusz Stachura      2018-08-09  13575   * @pf: board private structure
59533cb2e2 Mariusz Stachura      2018-08-09  13576   * @hw: ptr to the hardware info
59533cb2e2 Mariusz Stachura      2018-08-09  13577   *
59533cb2e2 Mariusz Stachura      2018-08-09  13578   * This function does a minimal setup of all subsystems needed for running
59533cb2e2 Mariusz Stachura      2018-08-09  13579   * recovery mode.
59533cb2e2 Mariusz Stachura      2018-08-09  13580   *
59533cb2e2 Mariusz Stachura      2018-08-09  13581   * Returns 0 on success, negative on failure
59533cb2e2 Mariusz Stachura      2018-08-09  13582   **/
59533cb2e2 Mariusz Stachura      2018-08-09  13583  static int i40e_init_recovery_mode(struct i40e_pf *pf, struct i40e_hw *hw)
59533cb2e2 Mariusz Stachura      2018-08-09  13584  {
59533cb2e2 Mariusz Stachura      2018-08-09  13585  	struct i40e_vsi *vsi;
59533cb2e2 Mariusz Stachura      2018-08-09  13586  	int err;
59533cb2e2 Mariusz Stachura      2018-08-09  13587  	int v_idx;
59533cb2e2 Mariusz Stachura      2018-08-09  13588
59533cb2e2 Mariusz Stachura      2018-08-09  13589  	err = i40e_sw_init(pf);
59533cb2e2 Mariusz Stachura      2018-08-09  13590  	if (err) {
59533cb2e2 Mariusz Stachura      2018-08-09  13591  		dev_info(&pf->pdev->dev, "sw_init failed: %d\n", err);
59533cb2e2 Mariusz Stachura      2018-08-09  13592  		goto err_sw_init;
59533cb2e2 Mariusz Stachura      2018-08-09  13593  	}
59533cb2e2 Mariusz Stachura      2018-08-09  13594
59533cb2e2 Mariusz Stachura      2018-08-09  13595  	/* allow a platform config to override the HW addr */
59533cb2e2 Mariusz Stachura      2018-08-09  13596  	i40e_get_platform_mac_addr(pf->pdev, pf);
59533cb2e2 Mariusz Stachura      2018-08-09  13597
59533cb2e2 Mariusz Stachura      2018-08-09  13598  	if (!is_valid_ether_addr(hw->mac.addr)) {
59533cb2e2 Mariusz Stachura      2018-08-09  13599  		/* normally we would return -EIO here */
59533cb2e2 Mariusz Stachura      2018-08-09  13600  		dev_info(&pf->pdev->dev, "invalid MAC address %pM\n",
59533cb2e2 Mariusz Stachura      2018-08-09  13601  			 hw->mac.addr);
59533cb2e2 Mariusz Stachura      2018-08-09  13602  	} else {
59533cb2e2 Mariusz Stachura      2018-08-09  13603  		dev_info(&pf->pdev->dev, "MAC address: %pM\n", hw->mac.addr);
59533cb2e2 Mariusz Stachura      2018-08-09  13604  	}
59533cb2e2 Mariusz Stachura      2018-08-09  13605  	ether_addr_copy(hw->mac.perm_addr, hw->mac.addr);
59533cb2e2 Mariusz Stachura      2018-08-09  13606  	i40e_get_port_mac_addr(hw, hw->mac.port_addr);
59533cb2e2 Mariusz Stachura      2018-08-09  13607  	if (is_valid_ether_addr(hw->mac.port_addr))
59533cb2e2 Mariusz Stachura      2018-08-09  13608  		pf->hw_features |= I40E_HW_PORT_ID_VALID;
59533cb2e2 Mariusz Stachura      2018-08-09  13609
59533cb2e2 Mariusz Stachura      2018-08-09  13610  	pci_save_state(pf->pdev);
59533cb2e2 Mariusz Stachura      2018-08-09  13611
59533cb2e2 Mariusz Stachura      2018-08-09  13612  	/* set up periodic task facility */
59533cb2e2 Mariusz Stachura      2018-08-09  13613  	timer_setup(&pf->service_timer, i40e_service_timer, (unsigned long)pf);
59533cb2e2 Mariusz Stachura      2018-08-09  13614  	pf->service_timer_period = HZ;
59533cb2e2 Mariusz Stachura      2018-08-09  13615
59533cb2e2 Mariusz Stachura      2018-08-09  13616  	INIT_WORK(&pf->service_task, i40e_service_task);
59533cb2e2 Mariusz Stachura      2018-08-09  13617  	clear_bit(__I40E_SERVICE_SCHED, pf->state);
59533cb2e2 Mariusz Stachura      2018-08-09  13618
59533cb2e2 Mariusz Stachura      2018-08-09  13619  	err = i40e_init_interrupt_scheme(pf);
59533cb2e2 Mariusz Stachura      2018-08-09  13620  	if (err)
59533cb2e2 Mariusz Stachura      2018-08-09  13621  		goto err_switch_setup;
59533cb2e2 Mariusz Stachura      2018-08-09  13622
59533cb2e2 Mariusz Stachura      2018-08-09  13623  	/* The number of VSIs reported by the FW is the minimum guaranteed
59533cb2e2 Mariusz Stachura      2018-08-09  13624  	 * to us; HW supports far more and we share the remaining pool with
59533cb2e2 Mariusz Stachura      2018-08-09  13625  	 * the other PFs. We allocate space for more than the guarantee with
59533cb2e2 Mariusz Stachura      2018-08-09  13626  	 * the understanding that we might not get them all later.
59533cb2e2 Mariusz Stachura      2018-08-09  13627  	 */
59533cb2e2 Mariusz Stachura      2018-08-09  13628  	if (pf->hw.func_caps.num_vsis < I40E_MIN_VSI_ALLOC)
59533cb2e2 Mariusz Stachura      2018-08-09  13629  		pf->num_alloc_vsi = I40E_MIN_VSI_ALLOC;
59533cb2e2 Mariusz Stachura      2018-08-09  13630  	else
59533cb2e2 Mariusz Stachura      2018-08-09  13631  		pf->num_alloc_vsi = pf->hw.func_caps.num_vsis;
59533cb2e2 Mariusz Stachura      2018-08-09  13632
59533cb2e2 Mariusz Stachura      2018-08-09  13633  	/* Set up the *vsi struct and our local tracking of the MAIN PF vsi. */
59533cb2e2 Mariusz Stachura      2018-08-09  13634  	pf->vsi = kcalloc(pf->num_alloc_vsi, sizeof(struct i40e_vsi *),
59533cb2e2 Mariusz Stachura      2018-08-09  13635  			  GFP_KERNEL);
59533cb2e2 Mariusz Stachura      2018-08-09  13636  	if (!pf->vsi) {
59533cb2e2 Mariusz Stachura      2018-08-09  13637  		err = -ENOMEM;
59533cb2e2 Mariusz Stachura      2018-08-09  13638  		goto err_switch_setup;
59533cb2e2 Mariusz Stachura      2018-08-09  13639  	}
59533cb2e2 Mariusz Stachura      2018-08-09  13640
59533cb2e2 Mariusz Stachura      2018-08-09  13641  	v_idx = i40e_vsi_mem_alloc(pf, I40E_VSI_MAIN);
59533cb2e2 Mariusz Stachura      2018-08-09  13642  	if (v_idx < 0)
59533cb2e2 Mariusz Stachura      2018-08-09  13643  		goto err_switch_setup;
59533cb2e2 Mariusz Stachura      2018-08-09  13644  	vsi = pf->vsi[v_idx];
59533cb2e2 Mariusz Stachura      2018-08-09  13645  	if (!vsi)
59533cb2e2 Mariusz Stachura      2018-08-09  13646  		goto err_switch_setup;
59533cb2e2 Mariusz Stachura      2018-08-09  13647  	err = i40e_config_netdev(vsi);
59533cb2e2 Mariusz Stachura      2018-08-09  13648  	if (err)
59533cb2e2 Mariusz Stachura      2018-08-09  13649  		goto err_switch_setup;
59533cb2e2 Mariusz Stachura      2018-08-09  13650  	err = register_netdev(vsi->netdev);
59533cb2e2 Mariusz Stachura      2018-08-09  13651  	if (err)
59533cb2e2 Mariusz Stachura      2018-08-09  13652  		goto err_switch_setup;
59533cb2e2 Mariusz Stachura      2018-08-09  13653  	i40e_dbg_pf_init(pf);
59533cb2e2 Mariusz Stachura      2018-08-09  13654
59533cb2e2 Mariusz Stachura      2018-08-09  13655  	/* tell the firmware that we're starting */
59533cb2e2 Mariusz Stachura      2018-08-09  13656  	i40e_send_version(pf);
59533cb2e2 Mariusz Stachura      2018-08-09  13657
59533cb2e2 Mariusz Stachura      2018-08-09  13658  	/* since everything's happy, start the service_task timer */
59533cb2e2 Mariusz Stachura      2018-08-09  13659  	mod_timer(&pf->service_timer,
59533cb2e2 Mariusz Stachura      2018-08-09  13660  		  round_jiffies(jiffies + pf->service_timer_period));
59533cb2e2 Mariusz Stachura      2018-08-09  13661
59533cb2e2 Mariusz Stachura      2018-08-09  13662  	return 0;
59533cb2e2 Mariusz Stachura      2018-08-09  13663
59533cb2e2 Mariusz Stachura      2018-08-09  13664  err_switch_setup:
59533cb2e2 Mariusz Stachura      2018-08-09  13665  	i40e_reset_interrupt_capability(pf);
59533cb2e2 Mariusz Stachura      2018-08-09  13666  	del_timer_sync(&pf->service_timer);
59533cb2e2 Mariusz Stachura      2018-08-09  13667  err_sw_init:
59533cb2e2 Mariusz Stachura      2018-08-09  13668  	i40e_shutdown_adminq(hw);
59533cb2e2 Mariusz Stachura      2018-08-09  13669  	iounmap(hw->hw_addr);
59533cb2e2 Mariusz Stachura      2018-08-09 @13670  	kfree(pf);
59533cb2e2 Mariusz Stachura      2018-08-09 @13671  	pci_disable_pcie_error_reporting(pf->pdev);
59533cb2e2 Mariusz Stachura      2018-08-09  13672  	pci_release_selected_regions(pf->pdev,
59533cb2e2 Mariusz Stachura      2018-08-09  13673  				     pci_select_bars(pf->pdev,
59533cb2e2 Mariusz Stachura      2018-08-09  13674  						     IORESOURCE_MEM));
59533cb2e2 Mariusz Stachura      2018-08-09  13675  	pci_disable_device(pf->pdev);
59533cb2e2 Mariusz Stachura      2018-08-09  13676
59533cb2e2 Mariusz Stachura      2018-08-09  13677  	return err;
59533cb2e2 Mariusz Stachura      2018-08-09  13678  }
59533cb2e2 Mariusz Stachura      2018-08-09  13679
59533cb2e2 Mariusz Stachura      2018-08-09  13680  /**
41c445ff0f Jesse Brandeburg      2013-09-11  13681   * i40e_probe - Device initialization routine
41c445ff0f Jesse Brandeburg      2013-09-11  13682   * @pdev: PCI device information struct
41c445ff0f Jesse Brandeburg      2013-09-11  13683   * @ent: entry in i40e_pci_tbl
41c445ff0f Jesse Brandeburg      2013-09-11  13684   *
b40c82e6ae Jeff Kirsher          2015-02-27  13685   * i40e_probe initializes a PF identified by a pci_dev structure.
b40c82e6ae Jeff Kirsher          2015-02-27  13686   * The OS initialization, configuring of the PF private structure,
41c445ff0f Jesse Brandeburg      2013-09-11  13687   * and a hardware reset occur.
41c445ff0f Jesse Brandeburg      2013-09-11  13688   *
41c445ff0f Jesse Brandeburg      2013-09-11  13689   * Returns 0 on success, negative on failure
41c445ff0f Jesse Brandeburg      2013-09-11  13690   **/
41c445ff0f Jesse Brandeburg      2013-09-11  13691  static int i40e_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
41c445ff0f Jesse Brandeburg      2013-09-11  13692  {
e827845c7d Catherine Sullivan    2015-02-06  13693  	struct i40e_aq_get_phy_abilities_resp abilities;
41c445ff0f Jesse Brandeburg      2013-09-11  13694  	struct i40e_pf *pf;
41c445ff0f Jesse Brandeburg      2013-09-11  13695  	struct i40e_hw *hw;
93cd765bb2 Anjali Singhai Jain   2013-11-20  13696  	static u16 pfs_found;
1d5109d187 Shannon Nelson        2015-08-26  13697  	u16 wol_nvm_bits;
d4dfb81af7 Catherine Sullivan    2013-11-28  13698  	u16 link_status;
6f66a484f1 Jean Sacren           2015-09-19  13699  	int err;
4f2f017c61 Anjali Singhai Jain   2015-10-21  13700  	u32 val;
8a9eb7d3cb Shannon Nelson        2014-03-14  13701  	u32 i;
58fc3267f1 Helin Zhang           2015-10-01  13702  	u8 set_fc_aq_fail;
41c445ff0f Jesse Brandeburg      2013-09-11  13703
41c445ff0f Jesse Brandeburg      2013-09-11  13704  	err = pci_enable_device_mem(pdev);
41c445ff0f Jesse Brandeburg      2013-09-11  13705  	if (err)
41c445ff0f Jesse Brandeburg      2013-09-11  13706  		return err;
41c445ff0f Jesse Brandeburg      2013-09-11  13707
41c445ff0f Jesse Brandeburg      2013-09-11  13708  	/* set up for high or low dma */
6494294f27 Mitch Williams        2014-02-11  13709  	err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
e3e3bfdd1d Jean Sacren           2014-03-25  13710  	if (err) {
6494294f27 Mitch Williams        2014-02-11  13711  		err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
6494294f27 Mitch Williams        2014-02-11  13712  		if (err) {
6494294f27 Mitch Williams        2014-02-11  13713  			dev_err(&pdev->dev,
6494294f27 Mitch Williams        2014-02-11  13714  				"DMA configuration failed: 0x%x\n", err);
41c445ff0f Jesse Brandeburg      2013-09-11  13715  			goto err_dma;
41c445ff0f Jesse Brandeburg      2013-09-11  13716  		}
e3e3bfdd1d Jean Sacren           2014-03-25  13717  	}
41c445ff0f Jesse Brandeburg      2013-09-11  13718
41c445ff0f Jesse Brandeburg      2013-09-11  13719  	/* set up pci connections */
56d766d64c Johannes Thumshirn    2016-06-07  13720  	err = pci_request_mem_regions(pdev, i40e_driver_name);
41c445ff0f Jesse Brandeburg      2013-09-11  13721  	if (err) {
41c445ff0f Jesse Brandeburg      2013-09-11  13722  		dev_info(&pdev->dev,
41c445ff0f Jesse Brandeburg      2013-09-11  13723  			 "pci_request_selected_regions failed %d\n", err);
41c445ff0f Jesse Brandeburg      2013-09-11  13724  		goto err_pci_reg;
41c445ff0f Jesse Brandeburg      2013-09-11  13725  	}
41c445ff0f Jesse Brandeburg      2013-09-11  13726
41c445ff0f Jesse Brandeburg      2013-09-11  13727  	pci_enable_pcie_error_reporting(pdev);
41c445ff0f Jesse Brandeburg      2013-09-11  13728  	pci_set_master(pdev);
41c445ff0f Jesse Brandeburg      2013-09-11  13729
41c445ff0f Jesse Brandeburg      2013-09-11  13730  	/* Now that we have a PCI connection, we need to do the
41c445ff0f Jesse Brandeburg      2013-09-11  13731  	 * low level device setup.  This is primarily setting up
41c445ff0f Jesse Brandeburg      2013-09-11  13732  	 * the Admin Queue structures and then querying for the
41c445ff0f Jesse Brandeburg      2013-09-11  13733  	 * device's current profile information.
41c445ff0f Jesse Brandeburg      2013-09-11  13734  	 */
41c445ff0f Jesse Brandeburg      2013-09-11  13735  	pf = kzalloc(sizeof(*pf), GFP_KERNEL);
41c445ff0f Jesse Brandeburg      2013-09-11  13736  	if (!pf) {
41c445ff0f Jesse Brandeburg      2013-09-11  13737  		err = -ENOMEM;
41c445ff0f Jesse Brandeburg      2013-09-11  13738  		goto err_pf_alloc;
41c445ff0f Jesse Brandeburg      2013-09-11  13739  	}
41c445ff0f Jesse Brandeburg      2013-09-11  13740  	pf->next_vsi = 0;
41c445ff0f Jesse Brandeburg      2013-09-11  13741  	pf->pdev = pdev;
9e6c9c0f2c Mauro S. M. Rodrigues 2017-05-12  13742  	set_bit(__I40E_DOWN, pf->state);
41c445ff0f Jesse Brandeburg      2013-09-11  13743
41c445ff0f Jesse Brandeburg      2013-09-11  13744  	hw = &pf->hw;
41c445ff0f Jesse Brandeburg      2013-09-11  13745  	hw->back = pf;
232f47060a Anjali Singhai        2015-02-26  13746
2ac8b675d9 Shannon Nelson        2015-07-23  13747  	pf->ioremap_len = min_t(int, pci_resource_len(pdev, 0),
232f47060a Anjali Singhai        2015-02-26  13748  				I40E_MAX_CSR_SPACE);
232f47060a Anjali Singhai        2015-02-26  13749
2ac8b675d9 Shannon Nelson        2015-07-23 @13750  	hw->hw_addr = ioremap(pci_resource_start(pdev, 0), pf->ioremap_len);
41c445ff0f Jesse Brandeburg      2013-09-11  13751  	if (!hw->hw_addr) {
41c445ff0f Jesse Brandeburg      2013-09-11  13752  		err = -EIO;
41c445ff0f Jesse Brandeburg      2013-09-11  13753  		dev_info(&pdev->dev, "ioremap(0x%04x, 0x%04x) failed: 0x%x\n",
41c445ff0f Jesse Brandeburg      2013-09-11  13754  			 (unsigned int)pci_resource_start(pdev, 0),
2ac8b675d9 Shannon Nelson        2015-07-23  13755  			 pf->ioremap_len, err);
41c445ff0f Jesse Brandeburg      2013-09-11  13756  		goto err_ioremap;
41c445ff0f Jesse Brandeburg      2013-09-11  13757  	}
41c445ff0f Jesse Brandeburg      2013-09-11  13758  	hw->vendor_id = pdev->vendor;
41c445ff0f Jesse Brandeburg      2013-09-11  13759  	hw->device_id = pdev->device;
41c445ff0f Jesse Brandeburg      2013-09-11  13760  	pci_read_config_byte(pdev, PCI_REVISION_ID, &hw->revision_id);
41c445ff0f Jesse Brandeburg      2013-09-11  13761  	hw->subsystem_vendor_id = pdev->subsystem_vendor;
41c445ff0f Jesse Brandeburg      2013-09-11  13762  	hw->subsystem_device_id = pdev->subsystem_device;
41c445ff0f Jesse Brandeburg      2013-09-11  13763  	hw->bus.device = PCI_SLOT(pdev->devfn);
41c445ff0f Jesse Brandeburg      2013-09-11  13764  	hw->bus.func = PCI_FUNC(pdev->devfn);
b3f028fc8a Sudheer Mogilappagari 2017-02-09  13765  	hw->bus.bus_id = pdev->bus->number;
93cd765bb2 Anjali Singhai Jain   2013-11-20  13766  	pf->instance = pfs_found;
41c445ff0f Jesse Brandeburg      2013-09-11  13767
ab243ec940 Scott Peterson        2017-08-22  13768  	/* Select something other than the 802.1ad ethertype for the
ab243ec940 Scott Peterson        2017-08-22  13769  	 * switch to use internally and drop on ingress.
ab243ec940 Scott Peterson        2017-08-22  13770  	 */
ab243ec940 Scott Peterson        2017-08-22  13771  	hw->switch_tag = 0xffff;
ab243ec940 Scott Peterson        2017-08-22  13772  	hw->first_tag = ETH_P_8021AD;
ab243ec940 Scott Peterson        2017-08-22  13773  	hw->second_tag = ETH_P_8021Q;
ab243ec940 Scott Peterson        2017-08-22  13774
0e588de17f Jacob Keller          2017-02-06  13775  	INIT_LIST_HEAD(&pf->l3_flex_pit_list);
0e588de17f Jacob Keller          2017-02-06  13776  	INIT_LIST_HEAD(&pf->l4_flex_pit_list);
0e588de17f Jacob Keller          2017-02-06  13777
de03d2b0ef Shannon Nelson        2016-03-10  13778  	/* set up the locks for the AQ, do this only once in probe
de03d2b0ef Shannon Nelson        2016-03-10  13779  	 * and destroy them only once in remove
de03d2b0ef Shannon Nelson        2016-03-10  13780  	 */
de03d2b0ef Shannon Nelson        2016-03-10  13781  	mutex_init(&hw->aq.asq_mutex);
de03d2b0ef Shannon Nelson        2016-03-10  13782  	mutex_init(&hw->aq.arq_mutex);
de03d2b0ef Shannon Nelson        2016-03-10  13783
5d4ca23e58 Alexander Duyck       2016-09-30  13784  	pf->msg_enable = netif_msg_init(debug,
5d4ca23e58 Alexander Duyck       2016-09-30  13785  					NETIF_MSG_DRV |
5d4ca23e58 Alexander Duyck       2016-09-30  13786  					NETIF_MSG_PROBE |
5d4ca23e58 Alexander Duyck       2016-09-30  13787  					NETIF_MSG_LINK);
5d4ca23e58 Alexander Duyck       2016-09-30  13788  	if (debug < -1)
5d4ca23e58 Alexander Duyck       2016-09-30  13789  		pf->hw.debug_mask = debug;
5b5faa434a Shannon Nelson        2014-10-17  13790
7134f9cee0 Jesse Brandeburg      2013-11-26  13791  	/* do a special CORER for clearing PXE mode once at init */
7134f9cee0 Jesse Brandeburg      2013-11-26  13792  	if (hw->revision_id == 0 &&
7134f9cee0 Jesse Brandeburg      2013-11-26  13793  	    (rd32(hw, I40E_GLLAN_RCTL_0) & I40E_GLLAN_RCTL_0_PXE_MODE_MASK)) {
7134f9cee0 Jesse Brandeburg      2013-11-26  13794  		wr32(hw, I40E_GLGEN_RTRIG, I40E_GLGEN_RTRIG_CORER_MASK);
7134f9cee0 Jesse Brandeburg      2013-11-26  13795  		i40e_flush(hw);
7134f9cee0 Jesse Brandeburg      2013-11-26  13796  		msleep(200);
7134f9cee0 Jesse Brandeburg      2013-11-26  13797  		pf->corer_count++;
7134f9cee0 Jesse Brandeburg      2013-11-26  13798
7134f9cee0 Jesse Brandeburg      2013-11-26  13799  		i40e_clear_pxe_mode(hw);
7134f9cee0 Jesse Brandeburg      2013-11-26  13800  	}
7134f9cee0 Jesse Brandeburg      2013-11-26  13801
41c445ff0f Jesse Brandeburg      2013-09-11  13802  	/* Reset here to make sure all is clean and to define PF 'n' */
838d41d92a Shannon Nelson        2014-06-04  13803  	i40e_clear_hw(hw);
41c445ff0f Jesse Brandeburg      2013-09-11  13804  	err = i40e_pf_reset(hw);
41c445ff0f Jesse Brandeburg      2013-09-11  13805  	if (err) {
41c445ff0f Jesse Brandeburg      2013-09-11  13806  		dev_info(&pdev->dev, "Initial pf_reset failed: %d\n", err);
41c445ff0f Jesse Brandeburg      2013-09-11  13807  		goto err_pf_reset;
41c445ff0f Jesse Brandeburg      2013-09-11  13808  	}
41c445ff0f Jesse Brandeburg      2013-09-11  13809  	pf->pfr_count++;
41c445ff0f Jesse Brandeburg      2013-09-11  13810
41c445ff0f Jesse Brandeburg      2013-09-11  13811  	hw->aq.num_arq_entries = I40E_AQ_LEN;
41c445ff0f Jesse Brandeburg      2013-09-11  13812  	hw->aq.num_asq_entries = I40E_AQ_LEN;
41c445ff0f Jesse Brandeburg      2013-09-11  13813  	hw->aq.arq_buf_size = I40E_MAX_AQ_BUF_SIZE;
41c445ff0f Jesse Brandeburg      2013-09-11  13814  	hw->aq.asq_buf_size = I40E_MAX_AQ_BUF_SIZE;
41c445ff0f Jesse Brandeburg      2013-09-11  13815  	pf->adminq_work_limit = I40E_AQ_WORK_LIMIT;
b2008cbf8a Carolyn Wyborny       2014-11-11  13816
b294ac70fc Carolyn Wyborny       2014-12-11  13817  	snprintf(pf->int_name, sizeof(pf->int_name) - 1,
b2008cbf8a Carolyn Wyborny       2014-11-11  13818  		 "%s-%s:misc",
b2008cbf8a Carolyn Wyborny       2014-11-11  13819  		 dev_driver_string(&pf->pdev->dev), dev_name(&pdev->dev));
41c445ff0f Jesse Brandeburg      2013-09-11  13820
41c445ff0f Jesse Brandeburg      2013-09-11  13821  	err = i40e_init_shared_code(hw);
41c445ff0f Jesse Brandeburg      2013-09-11  13822  	if (err) {
b2a75c5819 Anjali Singhai Jain   2015-04-27  13823  		dev_warn(&pdev->dev, "unidentified MAC or BLANK NVM: %d\n",
b2a75c5819 Anjali Singhai Jain   2015-04-27  13824  			 err);
41c445ff0f Jesse Brandeburg      2013-09-11  13825  		goto err_pf_reset;
41c445ff0f Jesse Brandeburg      2013-09-11  13826  	}
41c445ff0f Jesse Brandeburg      2013-09-11  13827
d52c20b7e4 Jesse Brandeburg      2013-11-26  13828  	/* set up a default setting for link flow control */
d52c20b7e4 Jesse Brandeburg      2013-11-26  13829  	pf->hw.fc.requested_mode = I40E_FC_NONE;
d52c20b7e4 Jesse Brandeburg      2013-11-26  13830
41c445ff0f Jesse Brandeburg      2013-09-11  13831  	err = i40e_init_adminq(hw);
2b2426a760 Carolyn Wyborny       2015-10-26  13832  	if (err) {
2b2426a760 Carolyn Wyborny       2015-10-26  13833  		if (err == I40E_ERR_FIRMWARE_API_VERSION)
2b2426a760 Carolyn Wyborny       2015-10-26  13834  			dev_info(&pdev->dev,
2b2426a760 Carolyn Wyborny       2015-10-26  13835  				 "The driver for the device stopped because the NVM image is newer than expected. You must install the most recent version of the network driver.\n");
2b2426a760 Carolyn Wyborny       2015-10-26  13836  		else
2b2426a760 Carolyn Wyborny       2015-10-26  13837  			dev_info(&pdev->dev,
2b2426a760 Carolyn Wyborny       2015-10-26  13838  				 "The driver for the device stopped because the device firmware failed to init. Try updating your NVM image.\n");
2b2426a760 Carolyn Wyborny       2015-10-26  13839
2b2426a760 Carolyn Wyborny       2015-10-26  13840  		goto err_pf_reset;
2b2426a760 Carolyn Wyborny       2015-10-26  13841  	}
5bbb2e2045 Filip Sadowski        2017-06-07  13842  	i40e_get_oem_version(hw);
f0b4444014 Carolyn Wyborny       2015-08-31  13843
6dec101765 Shannon Nelson        2015-09-28  13844  	/* provide nvm, fw, api versions */
6dec101765 Shannon Nelson        2015-09-28  13845  	dev_info(&pdev->dev, "fw %d.%d.%05d api %d.%d nvm %s\n",
6dec101765 Shannon Nelson        2015-09-28  13846  		 hw->aq.fw_maj_ver, hw->aq.fw_min_ver, hw->aq.fw_build,
6dec101765 Shannon Nelson        2015-09-28  13847  		 hw->aq.api_maj_ver, hw->aq.api_min_ver,
6dec101765 Shannon Nelson        2015-09-28  13848  		 i40e_nvm_version_str(hw));
f0b4444014 Carolyn Wyborny       2015-08-31  13849
7aa6761317 Catherine Sullivan    2014-07-09  13850  	if (hw->aq.api_maj_ver == I40E_FW_API_VERSION_MAJOR &&
22b96551f2 Mitch Williams        2017-07-14  13851  	    hw->aq.api_min_ver > I40E_FW_MINOR_VERSION(hw))
278b6f629c Shannon Nelson        2014-06-04  13852  		dev_info(&pdev->dev,
7aa6761317 Catherine Sullivan    2014-07-09  13853  			 "The driver for the device detected a newer version of the NVM image than expected. Please install the most recent version of the network driver.\n");
e04ea00217 Mariusz Stachura      2017-07-14  13854  	else if (hw->aq.api_maj_ver == 1 && hw->aq.api_min_ver < 4)
278b6f629c Shannon Nelson        2014-06-04  13855  		dev_info(&pdev->dev,
7aa6761317 Catherine Sullivan    2014-07-09  13856  			 "The driver for the device detected an older version of the NVM image than expected. Please update the NVM image.\n");
278b6f629c Shannon Nelson        2014-06-04  13857
4eb3f7685f Shannon Nelson        2014-03-06  13858  	i40e_verify_eeprom(pf);
4eb3f7685f Shannon Nelson        2014-03-06  13859
2c5fe33bdb Jesse Brandeburg      2014-04-23  13860  	/* Rev 0 hardware was never productized */
2c5fe33bdb Jesse Brandeburg      2014-04-23  13861  	if (hw->revision_id < 1)
2c5fe33bdb Jesse Brandeburg      2014-04-23  13862  		dev_warn(&pdev->dev, "This device is a pre-production adapter/LOM. Please be aware there may be issues with your hardware. If you are experiencing problems please contact your Intel or hardware representative who provided you with this hardware.\n");
2c5fe33bdb Jesse Brandeburg      2014-04-23  13863
6ff4ef86be Shannon Nelson        2013-12-21  13864  	i40e_clear_pxe_mode(hw);
59533cb2e2 Mariusz Stachura      2018-08-09  13865
59533cb2e2 Mariusz Stachura      2018-08-09  13866  	if (pf->hw.mac.type == I40E_MAC_X722)
59533cb2e2 Mariusz Stachura      2018-08-09 @13867  		if (i40e_check_recovery_mode(pf))
59533cb2e2 Mariusz Stachura      2018-08-09 @13868  			return i40e_init_recovery_mode(pf, hw);
59533cb2e2 Mariusz Stachura      2018-08-09  13869
2f4b411a3d Amritha Nambiar       2017-10-27  13870  	err = i40e_get_capabilities(pf, i40e_aqc_opc_list_func_capabilities);
41c445ff0f Jesse Brandeburg      2013-09-11  13871  	if (err)
41c445ff0f Jesse Brandeburg      2013-09-11  13872  		goto err_adminq_setup;
41c445ff0f Jesse Brandeburg      2013-09-11  13873
41c445ff0f Jesse Brandeburg      2013-09-11  13874  	err = i40e_sw_init(pf);
41c445ff0f Jesse Brandeburg      2013-09-11  13875  	if (err) {
41c445ff0f Jesse Brandeburg      2013-09-11  13876  		dev_info(&pdev->dev, "sw_init failed: %d\n", err);
41c445ff0f Jesse Brandeburg      2013-09-11  13877  		goto err_sw_init;
41c445ff0f Jesse Brandeburg      2013-09-11  13878  	}
41c445ff0f Jesse Brandeburg      2013-09-11  13879
41c445ff0f Jesse Brandeburg      2013-09-11  13880  	err = i40e_init_lan_hmc(hw, hw->func_caps.num_tx_qp,
c76cb6ed54 Alexander Duyck       2017-02-21  13881  				hw->func_caps.num_rx_qp, 0, 0);
41c445ff0f Jesse Brandeburg      2013-09-11  13882  	if (err) {
41c445ff0f Jesse Brandeburg      2013-09-11  13883  		dev_info(&pdev->dev, "init_lan_hmc failed: %d\n", err);
41c445ff0f Jesse Brandeburg      2013-09-11  13884  		goto err_init_lan_hmc;
41c445ff0f Jesse Brandeburg      2013-09-11  13885  	}
41c445ff0f Jesse Brandeburg      2013-09-11  13886
41c445ff0f Jesse Brandeburg      2013-09-11  13887  	err = i40e_configure_lan_hmc(hw, I40E_HMC_MODEL_DIRECT_ONLY);
41c445ff0f Jesse Brandeburg      2013-09-11  13888  	if (err) {
41c445ff0f Jesse Brandeburg      2013-09-11  13889  		dev_info(&pdev->dev, "configure_lan_hmc failed: %d\n", err);
41c445ff0f Jesse Brandeburg      2013-09-11  13890  		err = -ENOENT;
41c445ff0f Jesse Brandeburg      2013-09-11  13891  		goto err_configure_lan_hmc;
41c445ff0f Jesse Brandeburg      2013-09-11  13892  	}
41c445ff0f Jesse Brandeburg      2013-09-11  13893
b686ece59b Neerav Parikh         2014-12-14  13894  	/* Disable LLDP for NICs that have firmware versions lower than v4.3.
b686ece59b Neerav Parikh         2014-12-14  13895  	 * Ignore error return codes because if it was already disabled via
b686ece59b Neerav Parikh         2014-12-14  13896  	 * hardware settings this will fail
b686ece59b Neerav Parikh         2014-12-14  13897  	 */
d36e41dc78 Jacob Keller          2017-06-23  13898  	if (pf->hw_features & I40E_HW_STOP_FW_LLDP) {
b686ece59b Neerav Parikh         2014-12-14  13899  		dev_info(&pdev->dev, "Stopping firmware LLDP agent.\n");
b686ece59b Neerav Parikh         2014-12-14  13900  		i40e_aq_stop_lldp(hw, true, NULL);
b686ece59b Neerav Parikh         2014-12-14  13901  	}
b686ece59b Neerav Parikh         2014-12-14  13902
b499ffb0a2 Sowmini Varadhan      2015-12-07  13903  	/* allow a platform config to override the HW addr */
b499ffb0a2 Sowmini Varadhan      2015-12-07  13904  	i40e_get_platform_mac_addr(pdev, pf);
41c4c2b50d Jacob Keller          2017-04-05  13905
f62b5060d6 Jesse Brandeburg      2013-11-28  13906  	if (!is_valid_ether_addr(hw->mac.addr)) {
41c445ff0f Jesse Brandeburg      2013-09-11  13907  		dev_info(&pdev->dev, "invalid MAC address %pM\n", hw->mac.addr);
41c445ff0f Jesse Brandeburg      2013-09-11  13908  		err = -EIO;
41c445ff0f Jesse Brandeburg      2013-09-11  13909  		goto err_mac_addr;
41c445ff0f Jesse Brandeburg      2013-09-11  13910  	}
41c445ff0f Jesse Brandeburg      2013-09-11  13911  	dev_info(&pdev->dev, "MAC address: %pM\n", hw->mac.addr);
9a173901d9 Greg Rose             2014-05-22  13912  	ether_addr_copy(hw->mac.perm_addr, hw->mac.addr);
1f224ad2f7 Neerav Parikh         2014-02-12  13913  	i40e_get_port_mac_addr(hw, hw->mac.port_addr);
1f224ad2f7 Neerav Parikh         2014-02-12  13914  	if (is_valid_ether_addr(hw->mac.port_addr))
d36e41dc78 Jacob Keller          2017-06-23  13915  		pf->hw_features |= I40E_HW_PORT_ID_VALID;
41c445ff0f Jesse Brandeburg      2013-09-11  13916
41c445ff0f Jesse Brandeburg      2013-09-11  13917  	pci_set_drvdata(pdev, pf);
41c445ff0f Jesse Brandeburg      2013-09-11  13918  	pci_save_state(pdev);
c61c8fe1d5 Dave Ertman           2017-12-27  13919
c61c8fe1d5 Dave Ertman           2017-12-27  13920  	/* Enable FW to write default DCB config on link-up */
c61c8fe1d5 Dave Ertman           2017-12-27  13921  	i40e_aq_set_dcb_parameters(hw, true, NULL);
c61c8fe1d5 Dave Ertman           2017-12-27  13922

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
