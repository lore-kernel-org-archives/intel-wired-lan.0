From: kernel test robot <lkp@intel.com>
Date: Tue, 1 Mar 2022 01:36:22 +0800
Subject: [Intel-wired-lan] [PATCH net 3/3] ixgbevf: add disable link
 state
In-Reply-To: <20220228132752.17522-3-slawomirx.mrozowicz@intel.com>
References: <20220228132752.17522-3-slawomirx.mrozowicz@intel.com>
Message-ID: <202203010040.hGBnlm7i-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Slawomir,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on net/master]

url:    https://github.com/0day-ci/linux/commits/Slawomir-Mrozowicz/ixgbe-add-the-ability-for-the-PF-to-disable-VF-link-state/20220228-225053
base:   https://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git 519ca6fa960587d02904a9f8f79d587ac874fb03
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20220301/202203010040.hGBnlm7i-lkp at intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/74e631f4b502bf5cda71dd25f255cd7eca42d280
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Slawomir-Mrozowicz/ixgbe-add-the-ability-for-the-PF-to-disable-VF-link-state/20220228-225053
        git checkout 74e631f4b502bf5cda71dd25f255cd7eca42d280
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=alpha SHELL=/bin/bash drivers/net/ethernet/intel/ixgbevf/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/intel/ixgbevf/vf.c:594:5: warning: no previous prototype for 'ixgbevf_get_link_state_vf' [-Wmissing-prototypes]
     594 | s32 ixgbevf_get_link_state_vf(struct ixgbe_hw *hw, bool *link_state)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~


vim +/ixgbevf_get_link_state_vf +594 drivers/net/ethernet/intel/ixgbevf/vf.c

   586	
   587	/**
   588	 * ixgbevf_get_link_state_vf - Get VF link state from PF
   589	 * @hw: pointer to the HW structure
   590	 * @link_state: link state storage
   591	 *
   592	 * Returns state of the operation error or success.
   593	 */
 > 594	s32 ixgbevf_get_link_state_vf(struct ixgbe_hw *hw, bool *link_state)
   595	{
   596		u32 msgbuf[2];
   597		s32 ret_val;
   598		s32 err;
   599	
   600		msgbuf[0] = IXGBE_VF_GET_LINK_STATE;
   601		msgbuf[1] = 0x0;
   602	
   603		err = ixgbevf_write_msg_read_ack(hw, msgbuf, msgbuf, 2);
   604	
   605		if (err || (msgbuf[0] & IXGBE_VT_MSGTYPE_FAILURE)) {
   606			ret_val = IXGBE_ERR_MBX;
   607		} else {
   608			ret_val = 0;
   609			*link_state = msgbuf[1];
   610		}
   611	
   612		return ret_val;
   613	}
   614	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
