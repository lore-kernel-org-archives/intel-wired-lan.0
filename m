From: kernel test robot <lkp@intel.com>
Date: Sat, 21 May 2022 18:14:37 +0800
Subject: [Intel-wired-lan] [PATCH net] ice: Fix switchdev rules book
 keeping
In-Reply-To: <20220520084527.123885-1-wojciech.drewek@intel.com>
References: <20220520084527.123885-1-wojciech.drewek@intel.com>
Message-ID: <202205211832.w3XhaNbS-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Wojciech,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on net/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Wojciech-Drewek/ice-Fix-switchdev-rules-book-keeping/20220520-164759
base:   https://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git 9b80ccda233fa6c59de411bf889cc4d0e028f2c7
config: i386-randconfig-a013 (https://download.01.org/0day-ci/archive/20220521/202205211832.w3XhaNbS-lkp at intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project e00cbbec06c08dc616a0d52a20f678b8fbd4e304)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/e04c52f89a78dfae78ac79a71f0c92df8c409146
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Wojciech-Drewek/ice-Fix-switchdev-rules-book-keeping/20220520-164759
        git checkout e04c52f89a78dfae78ac79a71f0c92df8c409146
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/net/ethernet/intel/ice/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/net/ethernet/intel/ice/ice_tc_lib.c:527:8: error: no member named 'dest_vsi_handle' in 'struct ice_tc_flower_fltr'
           fltr->dest_vsi_handle = rule_added.vsi_handle;
           ~~~~  ^
   1 error generated.


vim +527 drivers/net/ethernet/intel/ice/ice_tc_lib.c

   452	
   453	static int
   454	ice_eswitch_add_tc_fltr(struct ice_vsi *vsi, struct ice_tc_flower_fltr *fltr)
   455	{
   456		struct ice_tc_flower_lyr_2_4_hdrs *headers = &fltr->outer_headers;
   457		struct ice_adv_rule_info rule_info = { 0 };
   458		struct ice_rule_query_data rule_added;
   459		struct ice_hw *hw = &vsi->back->hw;
   460		struct ice_adv_lkup_elem *list;
   461		u32 flags = fltr->flags;
   462		int lkups_cnt;
   463		int ret;
   464		int i;
   465	
   466		if (!flags || (flags & ICE_TC_FLWR_FIELD_ENC_SRC_L4_PORT)) {
   467			NL_SET_ERR_MSG_MOD(fltr->extack, "Unsupported encap field(s)");
   468			return -EOPNOTSUPP;
   469		}
   470	
   471		lkups_cnt = ice_tc_count_lkups(flags, headers, fltr);
   472		list = kcalloc(lkups_cnt, sizeof(*list), GFP_ATOMIC);
   473		if (!list)
   474			return -ENOMEM;
   475	
   476		i = ice_tc_fill_rules(hw, flags, fltr, list, &rule_info, NULL);
   477		if (i != lkups_cnt) {
   478			ret = -EINVAL;
   479			goto exit;
   480		}
   481	
   482		/* egress traffic is always redirect to uplink */
   483		if (fltr->direction == ICE_ESWITCH_FLTR_EGRESS)
   484			fltr->dest_vsi = vsi->back->switchdev.uplink_vsi;
   485	
   486		rule_info.sw_act.fltr_act = fltr->action.fltr_act;
   487		if (fltr->action.fltr_act != ICE_DROP_PACKET)
   488			rule_info.sw_act.vsi_handle = fltr->dest_vsi->idx;
   489		/* For now, making priority to be highest, and it also becomes
   490		 * the priority for recipe which will get created as a result of
   491		 * new extraction sequence based on input set.
   492		 * Priority '7' is max val for switch recipe, higher the number
   493		 * results into order of switch rule evaluation.
   494		 */
   495		rule_info.priority = 7;
   496	
   497		if (fltr->direction == ICE_ESWITCH_FLTR_INGRESS) {
   498			rule_info.sw_act.flag |= ICE_FLTR_RX;
   499			rule_info.sw_act.src = hw->pf_id;
   500			rule_info.rx = true;
   501		} else {
   502			rule_info.sw_act.flag |= ICE_FLTR_TX;
   503			rule_info.sw_act.src = vsi->idx;
   504			rule_info.rx = false;
   505			rule_info.flags_info.act = ICE_SINGLE_ACT_LAN_ENABLE;
   506			rule_info.flags_info.act_valid = true;
   507		}
   508	
   509		/* specify the cookie as filter_rule_id */
   510		rule_info.fltr_rule_id = fltr->cookie;
   511	
   512		ret = ice_add_adv_rule(hw, list, lkups_cnt, &rule_info, &rule_added);
   513		if (ret == -EEXIST) {
   514			NL_SET_ERR_MSG_MOD(fltr->extack, "Unable to add filter because it already exist");
   515			ret = -EINVAL;
   516			goto exit;
   517		} else if (ret) {
   518			NL_SET_ERR_MSG_MOD(fltr->extack, "Unable to add filter due to error");
   519			goto exit;
   520		}
   521	
   522		/* store the output params, which are needed later for removing
   523		 * advanced switch filter
   524		 */
   525		fltr->rid = rule_added.rid;
   526		fltr->rule_id = rule_added.rule_id;
 > 527		fltr->dest_vsi_handle = rule_added.vsi_handle;
   528	
   529	exit:
   530		kfree(list);
   531		return ret;
   532	}
   533	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
