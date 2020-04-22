From: kbuild test robot <lkp@intel.com>
Date: Wed, 22 Apr 2020 14:47:47 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 60/60]
 drivers/net/ethernet/intel/i40e/i40e_main.c:15350:24: error: use of
 undeclared identifier 'I40E_PRTGL_SAH'
Message-ID: <202004221405.farOcFWC%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   826a1eed0402b218f4374a26b6a1009404d6ba65
commit: 826a1eed0402b218f4374a26b6a1009404d6ba65 [60/60] i40e: Add a check to see if MFS is set
config: powerpc-pseries_defconfig (attached as .config)
compiler: clang version 11.0.0 (https://github.com/llvm/llvm-project a9b137f9ffba8cb25dfd7dd1fb613e8aac121b37)
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install powerpc cross compiling tool for clang build
        # apt-get install binutils-powerpc-linux-gnu
        git checkout 826a1eed0402b218f4374a26b6a1009404d6ba65
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=powerpc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

>> drivers/net/ethernet/intel/i40e/i40e_main.c:15350:24: error: use of undeclared identifier 'I40E_PRTGL_SAH'
                   val = (rd32(&pf->hw, I40E_PRTGL_SAH + 0x4 * i) &
                                        ^
>> drivers/net/ethernet/intel/i40e/i40e_main.c:15351:10: error: use of undeclared identifier 'I40E_PRTGL_SAH_MFS_MASK'
                          I40E_PRTGL_SAH_MFS_MASK) >> I40E_PRTGL_SAH_MFS_SHIFT;
                          ^
>> drivers/net/ethernet/intel/i40e/i40e_main.c:15351:38: error: use of undeclared identifier 'I40E_PRTGL_SAH_MFS_SHIFT'
                          I40E_PRTGL_SAH_MFS_MASK) >> I40E_PRTGL_SAH_MFS_SHIFT;
                                                      ^
>> drivers/net/ethernet/intel/i40e/i40e_main.c:14833:46: warning: shift count >= width of type [-Wshift-count-overflow]
           err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
                                                       ^~~~~~~~~~~~~~~~
   include/linux/dma-mapping.h:139:54: note: expanded from macro 'DMA_BIT_MASK'
   #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
                                                        ^ ~~~
   1 warning and 3 errors generated.

vim +/I40E_PRTGL_SAH +15350 drivers/net/ethernet/intel/i40e/i40e_main.c

 15248	
 15249		if (pf->flags & I40E_FLAG_IWARP_ENABLED) {
 15250			pf->iwarp_base_vector = i40e_get_lump(pf, pf->irq_pile,
 15251							      pf->num_iwarp_msix,
 15252							      I40E_IWARP_IRQ_PILE_ID);
 15253			if (pf->iwarp_base_vector < 0) {
 15254				dev_info(&pdev->dev,
 15255					 "failed to get tracking for %d vectors for IWARP err=%d\n",
 15256					 pf->num_iwarp_msix, pf->iwarp_base_vector);
 15257				pf->flags &= ~I40E_FLAG_IWARP_ENABLED;
 15258			}
 15259		}
 15260	
 15261		i40e_dbg_pf_init(pf);
 15262	
 15263		/* tell the firmware that we're starting */
 15264		i40e_send_version(pf);
 15265	
 15266		/* since everything's happy, start the service_task timer */
 15267		mod_timer(&pf->service_timer,
 15268			  round_jiffies(jiffies + pf->service_timer_period));
 15269	
 15270		/* add this PF to client device list and launch a client service task */
 15271		if (pf->flags & I40E_FLAG_IWARP_ENABLED) {
 15272			err = i40e_lan_add_device(pf);
 15273			if (err)
 15274				dev_info(&pdev->dev, "Failed to add PF to client API service list: %d\n",
 15275					 err);
 15276		}
 15277	
 15278	#define PCI_SPEED_SIZE 8
 15279	#define PCI_WIDTH_SIZE 8
 15280		/* Devices on the IOSF bus do not have this information
 15281		 * and will report PCI Gen 1 x 1 by default so don't bother
 15282		 * checking them.
 15283		 */
 15284		if (!(pf->hw_features & I40E_HW_NO_PCI_LINK_CHECK)) {
 15285			char speed[PCI_SPEED_SIZE] = "Unknown";
 15286			char width[PCI_WIDTH_SIZE] = "Unknown";
 15287	
 15288			/* Get the negotiated link width and speed from PCI config
 15289			 * space
 15290			 */
 15291			pcie_capability_read_word(pf->pdev, PCI_EXP_LNKSTA,
 15292						  &link_status);
 15293	
 15294			i40e_set_pci_config_data(hw, link_status);
 15295	
 15296			switch (hw->bus.speed) {
 15297			case i40e_bus_speed_8000:
 15298				strlcpy(speed, "8.0", PCI_SPEED_SIZE); break;
 15299			case i40e_bus_speed_5000:
 15300				strlcpy(speed, "5.0", PCI_SPEED_SIZE); break;
 15301			case i40e_bus_speed_2500:
 15302				strlcpy(speed, "2.5", PCI_SPEED_SIZE); break;
 15303			default:
 15304				break;
 15305			}
 15306			switch (hw->bus.width) {
 15307			case i40e_bus_width_pcie_x8:
 15308				strlcpy(width, "8", PCI_WIDTH_SIZE); break;
 15309			case i40e_bus_width_pcie_x4:
 15310				strlcpy(width, "4", PCI_WIDTH_SIZE); break;
 15311			case i40e_bus_width_pcie_x2:
 15312				strlcpy(width, "2", PCI_WIDTH_SIZE); break;
 15313			case i40e_bus_width_pcie_x1:
 15314				strlcpy(width, "1", PCI_WIDTH_SIZE); break;
 15315			default:
 15316				break;
 15317			}
 15318	
 15319			dev_info(&pdev->dev, "PCI-Express: Speed %sGT/s Width x%s\n",
 15320				 speed, width);
 15321	
 15322			if (hw->bus.width < i40e_bus_width_pcie_x8 ||
 15323			    hw->bus.speed < i40e_bus_speed_8000) {
 15324				dev_warn(&pdev->dev, "PCI-Express bandwidth available for this device may be insufficient for optimal performance.\n");
 15325				dev_warn(&pdev->dev, "Please move the device to a different PCI-e link with more lanes and/or higher transfer rate.\n");
 15326			}
 15327		}
 15328	
 15329		/* get the requested speeds from the fw */
 15330		err = i40e_aq_get_phy_capabilities(hw, false, false, &abilities, NULL);
 15331		if (err)
 15332			dev_dbg(&pf->pdev->dev, "get requested speeds ret =  %s last_status =  %s\n",
 15333				i40e_stat_str(&pf->hw, err),
 15334				i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
 15335		pf->hw.phy.link_info.requested_speeds = abilities.link_speed;
 15336	
 15337		/* set the FEC config due to the board capabilities */
 15338		i40e_set_fec_in_flags(abilities.fec_cfg_curr_mod_ext_info, &pf->flags);
 15339	
 15340		/* get the supported phy types from the fw */
 15341		err = i40e_aq_get_phy_capabilities(hw, false, true, &abilities, NULL);
 15342		if (err)
 15343			dev_dbg(&pf->pdev->dev, "get supported phy types ret =  %s last_status =  %s\n",
 15344				i40e_stat_str(&pf->hw, err),
 15345				i40e_aq_str(&pf->hw, pf->hw.aq.asq_last_status));
 15346	
 15347		/* make sure the MFS hasn't been set lower than the default */
 15348	#define MAX_FRAME_SIZE_DEFAULT 0x2600
 15349		for (i = 0; i < 4; i++) {
 15350			val = (rd32(&pf->hw, I40E_PRTGL_SAH + 0x4 * i) &
 15351			       I40E_PRTGL_SAH_MFS_MASK) >> I40E_PRTGL_SAH_MFS_SHIFT;
 15352			if (val < MAX_FRAME_SIZE_DEFAULT)
 15353				dev_warn(&pdev->dev, "MFS for port %x has been set below the default: %x\n", i, val);
 15354		}
 15355	
 15356		/* Add a filter to drop all Flow control frames from any VSI from being
 15357		 * transmitted. By doing so we stop a malicious VF from sending out
 15358		 * PAUSE or PFC frames and potentially controlling traffic for other
 15359		 * PF/VF VSIs.
 15360		 * The FW can still send Flow control frames if enabled.
 15361		 */
 15362		i40e_add_filter_to_drop_tx_flow_control_frames(&pf->hw,
 15363							       pf->main_vsi_seid);
 15364	
 15365		if ((pf->hw.device_id == I40E_DEV_ID_10G_BASE_T) ||
 15366			(pf->hw.device_id == I40E_DEV_ID_10G_BASE_T4))
 15367			pf->hw_features |= I40E_HW_PHY_CONTROLS_LEDS;
 15368		if (pf->hw.device_id == I40E_DEV_ID_SFP_I_X722)
 15369			pf->hw_features |= I40E_HW_HAVE_CRT_RETIMER;
 15370		/* print a string summarizing features */
 15371		i40e_print_features(pf);
 15372	
 15373		return 0;
 15374	
 15375		/* Unwind what we've done if something failed in the setup */
 15376	err_vsis:
 15377		set_bit(__I40E_DOWN, pf->state);
 15378		i40e_clear_interrupt_scheme(pf);
 15379		kfree(pf->vsi);
 15380	err_switch_setup:
 15381		i40e_reset_interrupt_capability(pf);
 15382		del_timer_sync(&pf->service_timer);
 15383	err_mac_addr:
 15384	err_configure_lan_hmc:
 15385		(void)i40e_shutdown_lan_hmc(hw);
 15386	err_init_lan_hmc:
 15387		kfree(pf->qp_pile);
 15388	err_sw_init:
 15389	err_adminq_setup:
 15390	err_pf_reset:
 15391		iounmap(hw->hw_addr);
 15392	err_ioremap:
 15393		kfree(pf);
 15394	err_pf_alloc:
 15395		pci_disable_pcie_error_reporting(pdev);
 15396		pci_release_mem_regions(pdev);
 15397	err_pci_reg:
 15398	err_dma:
 15399		pci_disable_device(pdev);
 15400		return err;
 15401	}
 15402	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 24434 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20200422/84cd89b0/attachment-0001.bin>
