From: kernel test robot <lkp@intel.com>
Date: Thu, 28 Oct 2021 07:11:33 +0800
Subject: [Intel-wired-lan] [PATCH net v1] iavf: Fix adopting new
 combined setting
In-Reply-To: <20211027155156.54453-1-michal.maloszewski@intel.com>
References: <20211027155156.54453-1-michal.maloszewski@intel.com>
Message-ID: <202110280743.wanmmhQd-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Michal,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on net/master]

url:    https://github.com/0day-ci/linux/commits/Michal-Maloszewski/iavf-Fix-adopting-new-combined-setting/20211027-235410
base:   https://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git 440ffcdd9db4758f1503a25fb49a8e15ca83d6bc
config: i386-allyesconfig (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/d8f58ff85a3ec0d3ae2ff0779cceee3fb1c947b7
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Michal-Maloszewski/iavf-Fix-adopting-new-combined-setting/20211027-235410
        git checkout d8f58ff85a3ec0d3ae2ff0779cceee3fb1c947b7
        # save the attached .config to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/net/ethernet/intel/iavf/ lib/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/net/ethernet/intel/iavf/iavf_main.c: In function 'iavf_reset_task':
>> drivers/net/ethernet/intel/iavf/iavf_main.c:2213:24: error: 'IAVF_FLAG_REINIT_MSIX_NEEDED' undeclared (first use in this function); did you mean 'IAVF_FLAG_REINIT_ITR_NEEDED'?
    2213 |  if ((adapter->flags & IAVF_FLAG_REINIT_MSIX_NEEDED) ||
         |                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                        IAVF_FLAG_REINIT_ITR_NEEDED
   drivers/net/ethernet/intel/iavf/iavf_main.c:2213:24: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/net/ethernet/intel/iavf/iavf_main.c:2288:3: error: this 'if' clause does not guard... [-Werror=misleading-indentation]
    2288 |   if (err)
         |   ^~
   drivers/net/ethernet/intel/iavf/iavf_main.c:2291:4: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'if'
    2291 |    adapter->flags &= ~IAVF_FLAG_REINIT_ITR_NEEDED;
         |    ^~~~~~~
   cc1: all warnings being treated as errors


vim +2213 drivers/net/ethernet/intel/iavf/iavf_main.c

  2088	
  2089	/**
  2090	 * iavf_reset_task - Call-back task to handle hardware reset
  2091	 * @work: pointer to work_struct
  2092	 *
  2093	 * During reset we need to shut down and reinitialize the admin queue
  2094	 * before we can use it to communicate with the PF again. We also clear
  2095	 * and reinit the rings because that context is lost as well.
  2096	 **/
  2097	static void iavf_reset_task(struct work_struct *work)
  2098	{
  2099		struct iavf_adapter *adapter = container_of(work,
  2100							      struct iavf_adapter,
  2101							      reset_task);
  2102		struct virtchnl_vf_resource *vfres = adapter->vf_res;
  2103		struct net_device *netdev = adapter->netdev;
  2104		struct iavf_hw *hw = &adapter->hw;
  2105		struct iavf_mac_filter *f, *ftmp;
  2106		struct iavf_vlan_filter *vlf;
  2107		struct iavf_cloud_filter *cf;
  2108		u32 reg_val;
  2109		int i = 0, err;
  2110		bool running;
  2111	
  2112		/* When device is being removed it doesn't make sense to run the reset
  2113		 * task, just return in such a case.
  2114		 */
  2115		if (mutex_is_locked(&adapter->remove_lock))
  2116			return;
  2117	
  2118		if (iavf_lock_timeout(&adapter->crit_lock, 200)) {
  2119			schedule_work(&adapter->reset_task);
  2120			return;
  2121		}
  2122		while (!mutex_trylock(&adapter->client_lock))
  2123			usleep_range(500, 1000);
  2124		if (CLIENT_ENABLED(adapter)) {
  2125			adapter->flags &= ~(IAVF_FLAG_CLIENT_NEEDS_OPEN |
  2126					    IAVF_FLAG_CLIENT_NEEDS_CLOSE |
  2127					    IAVF_FLAG_CLIENT_NEEDS_L2_PARAMS |
  2128					    IAVF_FLAG_SERVICE_CLIENT_REQUESTED);
  2129			cancel_delayed_work_sync(&adapter->client_task);
  2130			iavf_notify_client_close(&adapter->vsi, true);
  2131		}
  2132		iavf_misc_irq_disable(adapter);
  2133		if (adapter->flags & IAVF_FLAG_RESET_NEEDED) {
  2134			adapter->flags &= ~IAVF_FLAG_RESET_NEEDED;
  2135			/* Restart the AQ here. If we have been reset but didn't
  2136			 * detect it, or if the PF had to reinit, our AQ will be hosed.
  2137			 */
  2138			iavf_shutdown_adminq(hw);
  2139			iavf_init_adminq(hw);
  2140			iavf_request_reset(adapter);
  2141		}
  2142		adapter->flags |= IAVF_FLAG_RESET_PENDING;
  2143	
  2144		/* poll until we see the reset actually happen */
  2145		for (i = 0; i < IAVF_RESET_WAIT_DETECTED_COUNT; i++) {
  2146			reg_val = rd32(hw, IAVF_VF_ARQLEN1) &
  2147				  IAVF_VF_ARQLEN1_ARQENABLE_MASK;
  2148			if (!reg_val)
  2149				break;
  2150			usleep_range(5000, 10000);
  2151		}
  2152		if (i == IAVF_RESET_WAIT_DETECTED_COUNT) {
  2153			dev_info(&adapter->pdev->dev, "Never saw reset\n");
  2154			goto continue_reset; /* act like the reset happened */
  2155		}
  2156	
  2157		/* wait until the reset is complete and the PF is responding to us */
  2158		for (i = 0; i < IAVF_RESET_WAIT_COMPLETE_COUNT; i++) {
  2159			/* sleep first to make sure a minimum wait time is met */
  2160			msleep(IAVF_RESET_WAIT_MS);
  2161	
  2162			reg_val = rd32(hw, IAVF_VFGEN_RSTAT) &
  2163				  IAVF_VFGEN_RSTAT_VFR_STATE_MASK;
  2164			if (reg_val == VIRTCHNL_VFR_VFACTIVE)
  2165				break;
  2166		}
  2167	
  2168		pci_set_master(adapter->pdev);
  2169	
  2170		if (i == IAVF_RESET_WAIT_COMPLETE_COUNT) {
  2171			dev_err(&adapter->pdev->dev, "Reset never finished (%x)\n",
  2172				reg_val);
  2173			iavf_disable_vf(adapter);
  2174			mutex_unlock(&adapter->client_lock);
  2175			return; /* Do not attempt to reinit. It's dead, Jim. */
  2176		}
  2177	
  2178	continue_reset:
  2179		/* We don't use netif_running() because it may be true prior to
  2180		 * ndo_open() returning, so we can't assume it means all our open
  2181		 * tasks have finished, since we're not holding the rtnl_lock here.
  2182		 */
  2183		running = ((adapter->state == __IAVF_RUNNING) ||
  2184			   (adapter->state == __IAVF_RESETTING));
  2185	
  2186		if (running) {
  2187			netif_carrier_off(netdev);
  2188			netif_tx_stop_all_queues(netdev);
  2189			adapter->link_up = false;
  2190			iavf_napi_disable_all(adapter);
  2191		}
  2192		iavf_irq_disable(adapter);
  2193	
  2194		adapter->state = __IAVF_RESETTING;
  2195		adapter->flags &= ~IAVF_FLAG_RESET_PENDING;
  2196	
  2197		/* free the Tx/Rx rings and descriptors, might be better to just
  2198		 * re-use them sometime in the future
  2199		 */
  2200		iavf_free_all_rx_resources(adapter);
  2201		iavf_free_all_tx_resources(adapter);
  2202	
  2203		adapter->flags |= IAVF_FLAG_QUEUES_DISABLED;
  2204		/* kill and reinit the admin queue */
  2205		iavf_shutdown_adminq(hw);
  2206		adapter->current_op = VIRTCHNL_OP_UNKNOWN;
  2207		err = iavf_init_adminq(hw);
  2208		if (err)
  2209			dev_info(&adapter->pdev->dev, "Failed to init adminq: %d\n",
  2210				 err);
  2211		adapter->aq_required = 0;
  2212	
> 2213		if ((adapter->flags & IAVF_FLAG_REINIT_MSIX_NEEDED) ||
  2214		    (adapter->flags & IAVF_FLAG_REINIT_ITR_NEEDED)) {
  2215			err = iavf_reinit_interrupt_scheme(adapter);
  2216			if (err)
  2217				goto reset_err;
  2218		}
  2219	
  2220		if (RSS_AQ(adapter)) {
  2221			adapter->aq_required |= IAVF_FLAG_AQ_CONFIGURE_RSS;
  2222		} else {
  2223			err = iavf_init_rss(adapter);
  2224			if (err)
  2225				goto reset_err;
  2226		}
  2227	
  2228		adapter->aq_required |= IAVF_FLAG_AQ_GET_CONFIG;
  2229		adapter->aq_required |= IAVF_FLAG_AQ_MAP_VECTORS;
  2230	
  2231		spin_lock_bh(&adapter->mac_vlan_list_lock);
  2232	
  2233		/* Delete filter for the current MAC address, it could have
  2234		 * been changed by the PF via administratively set MAC.
  2235		 * Will be re-added via VIRTCHNL_OP_GET_VF_RESOURCES.
  2236		 */
  2237		list_for_each_entry_safe(f, ftmp, &adapter->mac_filter_list, list) {
  2238			if (ether_addr_equal(f->macaddr, adapter->hw.mac.addr)) {
  2239				list_del(&f->list);
  2240				kfree(f);
  2241			}
  2242		}
  2243		/* re-add all MAC filters */
  2244		list_for_each_entry(f, &adapter->mac_filter_list, list) {
  2245			f->add = true;
  2246		}
  2247		/* re-add all VLAN filters */
  2248		list_for_each_entry(vlf, &adapter->vlan_filter_list, list) {
  2249			vlf->add = true;
  2250		}
  2251	
  2252		spin_unlock_bh(&adapter->mac_vlan_list_lock);
  2253	
  2254		/* check if TCs are running and re-add all cloud filters */
  2255		spin_lock_bh(&adapter->cloud_filter_list_lock);
  2256		if ((vfres->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_ADQ) &&
  2257		    adapter->num_tc) {
  2258			list_for_each_entry(cf, &adapter->cloud_filter_list, list) {
  2259				cf->add = true;
  2260			}
  2261		}
  2262		spin_unlock_bh(&adapter->cloud_filter_list_lock);
  2263	
  2264		adapter->aq_required |= IAVF_FLAG_AQ_ADD_MAC_FILTER;
  2265		adapter->aq_required |= IAVF_FLAG_AQ_ADD_VLAN_FILTER;
  2266		adapter->aq_required |= IAVF_FLAG_AQ_ADD_CLOUD_FILTER;
  2267		iavf_misc_irq_enable(adapter);
  2268	
  2269		mod_delayed_work(iavf_wq, &adapter->watchdog_task, 2);
  2270	
  2271		/* We were running when the reset started, so we need to restore some
  2272		 * state here.
  2273		 */
  2274		if (running) {
  2275			/* allocate transmit descriptors */
  2276			err = iavf_setup_all_tx_resources(adapter);
  2277			if (err)
  2278				goto reset_err;
  2279	
  2280			/* allocate receive descriptors */
  2281			err = iavf_setup_all_rx_resources(adapter);
  2282			if (err)
  2283				goto reset_err;
  2284	
  2285		if ((adapter->flags & IAVF_FLAG_REINIT_MSIX_NEEDED) ||
  2286		    (adapter->flags & IAVF_FLAG_REINIT_ITR_NEEDED)) {
  2287			err = iavf_request_traffic_irqs(adapter, netdev->name);
> 2288			if (err)
  2289				goto reset_err;
  2290	
  2291				adapter->flags &= ~IAVF_FLAG_REINIT_ITR_NEEDED;
  2292			}
  2293	
  2294			iavf_configure(adapter);
  2295	
  2296			iavf_up_complete(adapter);
  2297	
  2298			iavf_irq_enable(adapter, true);
  2299		} else {
  2300			adapter->state = __IAVF_DOWN;
  2301			wake_up(&adapter->down_waitqueue);
  2302		}
  2303	
  2304		adapter->flags &= ~IAVF_FLAG_REINIT_ITR_NEEDED;
  2305		mutex_unlock(&adapter->client_lock);
  2306		mutex_unlock(&adapter->crit_lock);
  2307	
  2308		return;
  2309	reset_err:
  2310		mutex_unlock(&adapter->client_lock);
  2311		mutex_unlock(&adapter->crit_lock);
  2312		dev_err(&adapter->pdev->dev, "failed to allocate resources during reinit\n");
  2313		iavf_close(netdev);
  2314	}
  2315	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 66087 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20211028/609c8fd3/attachment-0001.bin>
