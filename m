From: kernel test robot <lkp@intel.com>
Date: Tue, 30 Nov 2021 08:47:41 +0800
Subject: [Intel-wired-lan] [PATCH net-next 2/6] iavf: Add support for
 VIRTCHNL_VF_OFFLOAD_VLAN_V2 negotiation
In-Reply-To: <20211129192300.14188-3-anthony.l.nguyen@intel.com>
References: <20211129192300.14188-3-anthony.l.nguyen@intel.com>
Message-ID: <202111300803.mYiFKuhQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Tony,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on tnguy-next-queue/dev-queue]
[also build test ERROR on v5.16-rc3 next-20211129]
[cannot apply to net-next/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Tony-Nguyen/iavf-Add-support-for-VIRTCHNL_VF_OFFLOAD_VLAN_V2/20211130-032607
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20211130/202111300803.mYiFKuhQ-lkp at intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/7764feeed253d22b477b98db13e41782ae11a902
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Tony-Nguyen/iavf-Add-support-for-VIRTCHNL_VF_OFFLOAD_VLAN_V2/20211130-032607
        git checkout 7764feeed253d22b477b98db13e41782ae11a902
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/net/ethernet/intel/iavf/iavf_main.c: In function 'iavf_parse_vf_resource_msg':
>> drivers/net/ethernet/intel/iavf/iavf_main.c:1859:35: error: 'IAVF_FLAG_REINIT_MSIX_NEEDED' undeclared (first use in this function); did you mean 'IAVF_FLAG_REINIT_ITR_NEEDED'?
    1859 |                 adapter->flags |= IAVF_FLAG_REINIT_MSIX_NEEDED;
         |                                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                   IAVF_FLAG_REINIT_ITR_NEEDED
   drivers/net/ethernet/intel/iavf/iavf_main.c:1859:35: note: each undeclared identifier is reported only once for each function it appears in
   In file included from include/linux/perf_event.h:25,
                    from include/linux/trace_events.h:10,
                    from include/trace/trace_events.h:21,
                    from include/trace/define_trace.h:102,
                    from drivers/net/ethernet/intel/iavf/iavf_trace.h:209,
                    from drivers/net/ethernet/intel/iavf/iavf_main.c:12:
   At top level:
   arch/arc/include/asm/perf_event.h:126:27: warning: 'arc_pmu_cache_map' defined but not used [-Wunused-const-variable=]
     126 | static const unsigned int arc_pmu_cache_map[C(MAX)][C(OP_MAX)][C(RESULT_MAX)] = {
         |                           ^~~~~~~~~~~~~~~~~
   arch/arc/include/asm/perf_event.h:91:27: warning: 'arc_pmu_ev_hw_map' defined but not used [-Wunused-const-variable=]
      91 | static const char * const arc_pmu_ev_hw_map[] = {
         |                           ^~~~~~~~~~~~~~~~~


vim +1859 drivers/net/ethernet/intel/iavf/iavf_main.c

  1830	
  1831	/**
  1832	 * iavf_parse_vf_resource_msg - parse response from VIRTCHNL_OP_GET_VF_RESOURCES
  1833	 * @adapter: board private structure
  1834	 */
  1835	int iavf_parse_vf_resource_msg(struct iavf_adapter *adapter)
  1836	{
  1837		int i, num_req_queues = adapter->num_req_queues;
  1838		struct iavf_vsi *vsi = &adapter->vsi;
  1839	
  1840		for (i = 0; i < adapter->vf_res->num_vsis; i++) {
  1841			if (adapter->vf_res->vsi_res[i].vsi_type == VIRTCHNL_VSI_SRIOV)
  1842				adapter->vsi_res = &adapter->vf_res->vsi_res[i];
  1843		}
  1844		if (!adapter->vsi_res) {
  1845			dev_err(&adapter->pdev->dev, "No LAN VSI found\n");
  1846			return -ENODEV;
  1847		}
  1848	
  1849		if (num_req_queues &&
  1850		    num_req_queues > adapter->vsi_res->num_queue_pairs) {
  1851			/* Problem.  The PF gave us fewer queues than what we had
  1852			 * negotiated in our request.  Need a reset to see if we can't
  1853			 * get back to a working state.
  1854			 */
  1855			dev_err(&adapter->pdev->dev,
  1856				"Requested %d queues, but PF only gave us %d.\n",
  1857				num_req_queues,
  1858				adapter->vsi_res->num_queue_pairs);
> 1859			adapter->flags |= IAVF_FLAG_REINIT_MSIX_NEEDED;
  1860			adapter->num_req_queues = adapter->vsi_res->num_queue_pairs;
  1861			iavf_schedule_reset(adapter);
  1862	
  1863			return -EAGAIN;
  1864		}
  1865		adapter->num_req_queues = 0;
  1866		adapter->vsi.id = adapter->vsi_res->vsi_id;
  1867	
  1868		adapter->vsi.back = adapter;
  1869		adapter->vsi.base_vector = 1;
  1870		adapter->vsi.work_limit = IAVF_DEFAULT_IRQ_WORK;
  1871		vsi->netdev = adapter->netdev;
  1872		vsi->qs_handle = adapter->vsi_res->qset_handle;
  1873		if (adapter->vf_res->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_RSS_PF) {
  1874			adapter->rss_key_size = adapter->vf_res->rss_key_size;
  1875			adapter->rss_lut_size = adapter->vf_res->rss_lut_size;
  1876		} else {
  1877			adapter->rss_key_size = IAVF_HKEY_ARRAY_SIZE;
  1878			adapter->rss_lut_size = IAVF_HLUT_ARRAY_SIZE;
  1879		}
  1880	
  1881		return 0;
  1882	}
  1883	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
