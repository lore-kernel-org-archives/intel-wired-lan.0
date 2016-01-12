From: kbuild test robot <fengguang.wu@intel.com>
Date: Tue, 12 Jan 2016 20:27:06 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 107/108]
 drivers/net/ethernet/intel/i40e/i40e_common.c:2451:7: error: 'i' undeclared
Message-ID: <201601122001.sCg0EOMH%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   e25ea07c9001bc7fe498060ad16260fbe6743838
commit: b5b59c3266add18574fc8687d4b34906d7552b55 [107/108] i40e: set shared bit for multicast filters
config: x86_64-randconfig-x015-01110856 (attached as .config)
reproduce:
        git checkout b5b59c3266add18574fc8687d4b34906d7552b55
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All error/warnings (new ones prefixed by >>):

   drivers/net/ethernet/intel/i40e/i40e_common.c: In function 'i40e_aq_add_macvlan':
>> drivers/net/ethernet/intel/i40e/i40e_common.c:2451:7: error: 'i' undeclared (first use in this function)
     for (i = 0; i < count; i++)
          ^
   drivers/net/ethernet/intel/i40e/i40e_common.c:2451:7: note: each undeclared identifier is reported only once for each function it appears in
   drivers/net/ethernet/intel/i40e/i40e_common.c: In function 'i40e_aq_remove_macvlan':
>> drivers/net/ethernet/intel/i40e/i40e_common.c:2485:6: warning: unused variable 'i' [-Wunused-variable]
     int i;
         ^

vim +/i +2451 drivers/net/ethernet/intel/i40e/i40e_common.c

  2445		i40e_fill_default_direct_cmd_desc(&desc, i40e_aqc_opc_add_macvlan);
  2446		cmd->num_addresses = cpu_to_le16(count);
  2447		cmd->seid[0] = cpu_to_le16(I40E_AQC_MACVLAN_CMD_SEID_VALID | seid);
  2448		cmd->seid[1] = 0;
  2449		cmd->seid[2] = 0;
  2450	
> 2451		for (i = 0; i < count; i++)
  2452			if (is_multicast_ether_addr(mv_list[i].mac_addr))
  2453				mv_list[i].flags |=
  2454				       cpu_to_le16(I40E_AQC_MACVLAN_ADD_USE_SHARED_MAC);
  2455	
  2456		desc.flags |= cpu_to_le16((u16)(I40E_AQ_FLAG_BUF | I40E_AQ_FLAG_RD));
  2457		if (buf_size > I40E_AQ_LARGE_BUF)
  2458			desc.flags |= cpu_to_le16((u16)I40E_AQ_FLAG_LB);
  2459	
  2460		status = i40e_asq_send_command(hw, &desc, mv_list, buf_size,
  2461					       cmd_details);
  2462	
  2463		return status;
  2464	}
  2465	
  2466	/**
  2467	 * i40e_aq_remove_macvlan
  2468	 * @hw: pointer to the hw struct
  2469	 * @seid: VSI for the mac address
  2470	 * @mv_list: list of macvlans to be removed
  2471	 * @count: length of the list
  2472	 * @cmd_details: pointer to command details structure or NULL
  2473	 *
  2474	 * Remove MAC/VLAN addresses from the HW filtering
  2475	 **/
  2476	i40e_status i40e_aq_remove_macvlan(struct i40e_hw *hw, u16 seid,
  2477				struct i40e_aqc_remove_macvlan_element_data *mv_list,
  2478				u16 count, struct i40e_asq_cmd_details *cmd_details)
  2479	{
  2480		struct i40e_aq_desc desc;
  2481		struct i40e_aqc_macvlan *cmd =
  2482			(struct i40e_aqc_macvlan *)&desc.params.raw;
  2483		i40e_status status;
  2484		u16 buf_size;
> 2485		int i;
  2486	
  2487		if (count == 0 || !mv_list || !hw)
  2488			return I40E_ERR_PARAM;

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 25694 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160112/7f2a6588/attachment-0001.obj>
