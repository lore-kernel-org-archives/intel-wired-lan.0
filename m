From: kernel test robot <lkp@intel.com>
Date: Fri, 5 Feb 2021 20:05:04 +0800
Subject: [Intel-wired-lan] [PATCH net v1] iavf: Fix return of set the
 new channel count
In-Reply-To: <20210205094115.15222-1-mateusz.palczewski@intel.com>
References: <20210205094115.15222-1-mateusz.palczewski@intel.com>
Message-ID: <202102051928.T0Cym4dn-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Mateusz,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on net/master]

url:    https://github.com/0day-ci/linux/commits/Mateusz-Palczewski/iavf-Fix-return-of-set-the-new-channel-count/20210205-174244
base:   https://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git b491e6a7391e3ecdebdd7a097550195cc878924a
config: i386-allyesconfig (attached as .config)
compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/32512ec4203feceb21741acceb536b987b2984de
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Mateusz-Palczewski/iavf-Fix-return-of-set-the-new-channel-count/20210205-174244
        git checkout 32512ec4203feceb21741acceb536b987b2984de
        # save the attached .config to linux build tree
        make W=1 ARCH=i386 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/net/ethernet/intel/iavf/iavf_ethtool.c: In function 'iavf_set_channels':
>> drivers/net/ethernet/intel/iavf/iavf_ethtool.c:920:18: error: 'IAVF_RESET_WAIT_COUNT' undeclared (first use in this function); did you mean 'IAVF_RESET_WAIT_MS'?
     920 |  for (i = 0; i < IAVF_RESET_WAIT_COUNT; i++) {
         |                  ^~~~~~~~~~~~~~~~~~~~~
         |                  IAVF_RESET_WAIT_MS
   drivers/net/ethernet/intel/iavf/iavf_ethtool.c:920:18: note: each undeclared identifier is reported only once for each function it appears in


vim +920 drivers/net/ethernet/intel/iavf/iavf_ethtool.c

   880	
   881	/**
   882	 * iavf_set_channels: set the new channel count
   883	 * @netdev: network interface device structure
   884	 * @ch: channel information structure
   885	 *
   886	 * Negotiate a new number of channels with the PF then do a reset.  During
   887	 * reset we'll realloc queues and fix the RSS table.  Returns 0 on success,
   888	 * negative on failure.
   889	 **/
   890	static int iavf_set_channels(struct net_device *netdev,
   891				     struct ethtool_channels *ch)
   892	{
   893		struct iavf_adapter *adapter = netdev_priv(netdev);
   894		u32 num_req = ch->combined_count;
   895		int i;
   896	
   897		if ((adapter->vf_res->vf_cap_flags & VIRTCHNL_VF_OFFLOAD_ADQ) &&
   898		    adapter->num_tc) {
   899			dev_info(&adapter->pdev->dev, "Cannot set channels since ADq is enabled.\n");
   900			return -EINVAL;
   901		}
   902	
   903		/* All of these should have already been checked by ethtool before this
   904		 * even gets to us, but just to be sure.
   905		 */
   906		if (num_req > adapter->vsi_res->num_queue_pairs)
   907			return -EINVAL;
   908	
   909		if (num_req == adapter->num_active_queues)
   910			return 0;
   911	
   912		if (ch->rx_count || ch->tx_count || ch->other_count != NONQ_VECS)
   913			return -EINVAL;
   914	
   915		adapter->num_req_queues = num_req;
   916		adapter->flags |= IAVF_FLAG_REINIT_ITR_NEEDED;
   917		iavf_schedule_reset(adapter);
   918	
   919		/* wait for the reset is done */
 > 920		for (i = 0; i < IAVF_RESET_WAIT_COUNT; i++) {
   921			msleep(IAVF_RESET_WAIT_MS);
   922			if (adapter->flags & IAVF_FLAG_RESET_PENDING)
   923				continue;
   924			break;
   925		}
   926		if (i == IAVF_RESET_WAIT_COUNT) {
   927			adapter->flags &= ~IAVF_FLAG_REINIT_ITR_NEEDED;
   928			adapter->num_active_queues = num_req;
   929			return -EOPNOTSUPP;
   930		}
   931	
   932		return 0;
   933	}
   934	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 64176 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20210205/044791c7/attachment-0001.bin>
