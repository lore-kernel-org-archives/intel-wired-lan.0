From: kernel test robot <lkp@intel.com>
Date: Tue, 12 Oct 2021 07:15:38 +0800
Subject: [Intel-wired-lan] [PATCH net-next 3/4] ice: low level support
 for tunnels
In-Reply-To: <20211011094821.5286-4-michal.swiatkowski@linux.intel.com>
References: <20211011094821.5286-4-michal.swiatkowski@linux.intel.com>
Message-ID: <202110120715.pAB0j6LV-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Michal,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on tnguy-next-queue/dev-queue]
[cannot apply to net-next/master v5.15-rc5 next-20211011]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Michal-Swiatkowski/support-for-tunnel-in-ice-eswitch/20211011-175106
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
config: x86_64-randconfig-a001-20211011 (attached as .config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project f95d9c95bbf4cf662b9a181245fc6dcede39f590)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/f4c17653182af5b6d1de81aad68469380b734f1e
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Michal-Swiatkowski/support-for-tunnel-in-ice-eswitch/20211011-175106
        git checkout f4c17653182af5b6d1de81aad68469380b734f1e
        # save the attached .config to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/net/ethernet/intel/ice/ice_switch.c:4346:1: error: incomplete result type 'enum ice_status' in function definition
   ice_add_special_words(struct ice_adv_rule_info *rinfo,
   ^
   drivers/net/ethernet/intel/ice/ice_switch.c:4345:13: note: forward declaration of 'enum ice_status'
   static enum ice_status
               ^
>> drivers/net/ethernet/intel/ice/ice_switch.c:4362:11: error: use of undeclared identifier 'ICE_ERR_MAX_LIMIT'
                           return ICE_ERR_MAX_LIMIT;
                                  ^
>> drivers/net/ethernet/intel/ice/ice_switch.c:4366:9: error: use of undeclared identifier 'ICE_SUCCESS'
           return ICE_SUCCESS;
                  ^
   drivers/net/ethernet/intel/ice/ice_switch.c:4792:1: error: incomplete result type 'enum ice_status' in function definition
   ice_fill_adv_packet_tun(struct ice_hw *hw, enum ice_sw_tunnel_type tun_type,
   ^
   drivers/net/ethernet/intel/ice/ice_switch.c:4345:13: note: forward declaration of 'enum ice_status'
   static enum ice_status
               ^
>> drivers/net/ethernet/intel/ice/ice_switch.c:4801:11: error: use of undeclared identifier 'ICE_ERR_CFG'
                           return ICE_ERR_CFG;
                                  ^
   drivers/net/ethernet/intel/ice/ice_switch.c:4806:10: error: use of undeclared identifier 'ICE_SUCCESS'
                   return ICE_SUCCESS;
                          ^
   drivers/net/ethernet/intel/ice/ice_switch.c:4819:11: error: use of undeclared identifier 'ICE_SUCCESS'
                           return ICE_SUCCESS;
                                  ^
   drivers/net/ethernet/intel/ice/ice_switch.c:4823:9: error: use of undeclared identifier 'ICE_ERR_CFG'
           return ICE_ERR_CFG;
                  ^
   8 errors generated.


vim +4346 drivers/net/ethernet/intel/ice/ice_switch.c

  4339	
  4340	/**
  4341	 * ice_add_special_words - Add words that are not protocols, such as metadata
  4342	 * @rinfo: other information regarding the rule e.g. priority and action info
  4343	 * @lkup_exts: lookup word structure
  4344	 */
  4345	static enum ice_status
> 4346	ice_add_special_words(struct ice_adv_rule_info *rinfo,
  4347			      struct ice_prot_lkup_ext *lkup_exts)
  4348	{
  4349		u16 mask;
  4350	
  4351		/* If this is a tunneled packet, then add recipe index to match the
  4352		 * tunnel bit in the packet metadata flags.
  4353		 */
  4354		if (ice_tun_type_match_word(rinfo->tun_type, &mask)) {
  4355			if (lkup_exts->n_val_words < ICE_MAX_CHAIN_WORDS) {
  4356				u8 word = lkup_exts->n_val_words++;
  4357	
  4358				lkup_exts->fv_words[word].prot_id = ICE_META_DATA_ID_HW;
  4359				lkup_exts->fv_words[word].off = ICE_TUN_FLAG_MDID_OFF;
  4360				lkup_exts->field_mask[word] = mask;
  4361			} else {
> 4362				return ICE_ERR_MAX_LIMIT;
  4363			}
  4364		}
  4365	
> 4366		return ICE_SUCCESS;
  4367	}
  4368	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 44255 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20211012/e0332ab2/attachment-0001.bin>
