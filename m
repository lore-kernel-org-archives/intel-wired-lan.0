From: kernel test robot <lkp@intel.com>
Date: Sun, 15 Aug 2021 00:18:02 +0800
Subject: [Intel-wired-lan] [PATCH v5 intel-next 3/9] ice: split ice_ring
 onto Tx/Rx separate structs
In-Reply-To: <20210814140812.46632-4-maciej.fijalkowski@intel.com>
References: <20210814140812.46632-4-maciej.fijalkowski@intel.com>
Message-ID: <202108150013.21EvMzfS-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Maciej,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on ipvs/master]
[also build test WARNING on v5.14-rc5 next-20210813]
[cannot apply to tnguy-next-queue/dev-queue sparc-next/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Maciej-Fijalkowski/XDP_TX-improvements-for-ice/20210814-222504
base:   https://git.kernel.org/pub/scm/linux/kernel/git/horms/ipvs.git master
config: powerpc-allyesconfig (attached as .config)
compiler: powerpc-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/945abe6bbe5afc453bca1dcb66593b2d9e47f7c8
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Maciej-Fijalkowski/XDP_TX-improvements-for-ice/20210814-222504
        git checkout 945abe6bbe5afc453bca1dcb66593b2d9e47f7c8
        # save the attached .config to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/net/ethernet/intel/ice/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/intel/ice/ice_base.c:213: warning: expecting prototype for ice_calc_q_handle(). Prototype was for ice_calc_txq_handle() instead


vim +213 drivers/net/ethernet/intel/ice/ice_base.c

eff380aaffedb2 Anirudh Venkataramanan 2019-10-24  205  
e75d1b2c373199 Maciej Fijalkowski     2019-10-24  206  /**
e75d1b2c373199 Maciej Fijalkowski     2019-10-24  207   * ice_calc_q_handle - calculate the queue handle
e75d1b2c373199 Maciej Fijalkowski     2019-10-24  208   * @vsi: VSI that ring belongs to
e75d1b2c373199 Maciej Fijalkowski     2019-10-24  209   * @ring: ring to get the absolute queue index
e75d1b2c373199 Maciej Fijalkowski     2019-10-24  210   * @tc: traffic class number
e75d1b2c373199 Maciej Fijalkowski     2019-10-24  211   */
945abe6bbe5afc Maciej Fijalkowski     2021-08-14  212  static u16 ice_calc_txq_handle(struct ice_vsi *vsi, struct ice_tx_ring *ring, u8 tc)
e75d1b2c373199 Maciej Fijalkowski     2019-10-24 @213  {
af23635a5335aa Jesse Brandeburg       2020-02-13  214  	WARN_ONCE(ice_ring_is_xdp(ring) && tc, "XDP ring can't belong to TC other than 0\n");
efc2214b6047b6 Maciej Fijalkowski     2019-11-04  215  
e75d1b2c373199 Maciej Fijalkowski     2019-10-24  216  	/* Idea here for calculation is that we subtract the number of queue
e75d1b2c373199 Maciej Fijalkowski     2019-10-24  217  	 * count from TC that ring belongs to from it's absolute queue index
e75d1b2c373199 Maciej Fijalkowski     2019-10-24  218  	 * and as a result we get the queue's index within TC.
e75d1b2c373199 Maciej Fijalkowski     2019-10-24  219  	 */
e75d1b2c373199 Maciej Fijalkowski     2019-10-24  220  	return ring->q_index - vsi->tc_cfg.tc_info[tc].qoffset;
e75d1b2c373199 Maciej Fijalkowski     2019-10-24  221  }
e75d1b2c373199 Maciej Fijalkowski     2019-10-24  222  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 73330 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20210815/0a1f7d54/attachment-0001.bin>
