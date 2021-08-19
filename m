From: kernel test robot <lkp@intel.com>
Date: Thu, 19 Aug 2021 08:22:59 +0800
Subject: [Intel-wired-lan] [PATCH v6 intel-next 3/9] ice: split ice_ring
 onto Tx/Rx separate structs
In-Reply-To: <20210818135916.25007-4-maciej.fijalkowski@intel.com>
References: <20210818135916.25007-4-maciej.fijalkowski@intel.com>
Message-ID: <202108190810.x1YdMeqg-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Maciej,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on tnguy-next-queue/dev-queue]
[cannot apply to v5.14-rc6 next-20210818]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Maciej-Fijalkowski/XDP_TX-improvements-for-ice/20210818-221906
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
config: arc-allyesconfig (attached as .config)
compiler: arceb-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/8efea0970271c16b9bab35cf49ce219c16a7479b
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Maciej-Fijalkowski/XDP_TX-improvements-for-ice/20210818-221906
        git checkout 8efea0970271c16b9bab35cf49ce219c16a7479b
        # save the attached .config to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/net/ethernet/intel/ice/ice_eswitch.c: In function 'ice_eswitch_remap_rings_to_vectors':
   drivers/net/ethernet/intel/ice/ice_eswitch.c:97:30: error: 'struct ice_ring_container' has no member named 'ring'; did you mean 'rx_ring'?
      97 |                 q_vector->tx.ring = tx_ring;
         |                              ^~~~
         |                              rx_ring
   drivers/net/ethernet/intel/ice/ice_eswitch.c:100:35: error: 'netdev' undeclared (first use in this function); did you mean 'net_eq'?
     100 |                 tx_ring->netdev = netdev;
         |                                   ^~~~~~
         |                                   net_eq
   drivers/net/ethernet/intel/ice/ice_eswitch.c:100:35: note: each undeclared identifier is reported only once for each function it appears in
   drivers/net/ethernet/intel/ice/ice_eswitch.c:107:30: error: 'struct ice_ring_container' has no member named 'ring'; did you mean 'rx_ring'?
     107 |                 q_vector->rx.ring = rx_ring;
         |                              ^~~~
         |                              rx_ring
   drivers/net/ethernet/intel/ice/ice_eswitch.c: In function 'ice_eswitch_set_rxdid':
   drivers/net/ethernet/intel/ice/ice_eswitch.c:382:41: error: initialization of 'struct ice_ring *' from incompatible pointer type 'struct ice_rx_ring *' [-Werror=incompatible-pointer-types]
     382 |                 struct ice_ring *ring = vsi->rx_rings[i];
         |                                         ^~~
>> drivers/net/ethernet/intel/ice/ice_eswitch.c:383:45: error: invalid use of undefined type 'struct ice_ring'
     383 |                 u16 pf_q = vsi->rxq_map[ring->q_index];
         |                                             ^~
   cc1: some warnings being treated as errors


vim +383 drivers/net/ethernet/intel/ice/ice_eswitch.c

bc0412448da587 Grzegorz Nitka 2021-08-03  370  
bc0412448da587 Grzegorz Nitka 2021-08-03  371  /**
bc0412448da587 Grzegorz Nitka 2021-08-03  372   * ice_eswitch_set_rxdid - configure rxdid on all rx queues from VSI
bc0412448da587 Grzegorz Nitka 2021-08-03  373   * @vsi: VSI to setup rxdid on
bc0412448da587 Grzegorz Nitka 2021-08-03  374   * @rxdid: flex descriptor id
bc0412448da587 Grzegorz Nitka 2021-08-03  375   */
bc0412448da587 Grzegorz Nitka 2021-08-03  376  static void ice_eswitch_set_rxdid(struct ice_vsi *vsi, u32 rxdid)
bc0412448da587 Grzegorz Nitka 2021-08-03  377  {
bc0412448da587 Grzegorz Nitka 2021-08-03  378  	struct ice_hw *hw = &vsi->back->hw;
bc0412448da587 Grzegorz Nitka 2021-08-03  379  	int i;
bc0412448da587 Grzegorz Nitka 2021-08-03  380  
bc0412448da587 Grzegorz Nitka 2021-08-03  381  	ice_for_each_rxq(vsi, i) {
bc0412448da587 Grzegorz Nitka 2021-08-03  382  		struct ice_ring *ring = vsi->rx_rings[i];
bc0412448da587 Grzegorz Nitka 2021-08-03 @383  		u16 pf_q = vsi->rxq_map[ring->q_index];
bc0412448da587 Grzegorz Nitka 2021-08-03  384  
bc0412448da587 Grzegorz Nitka 2021-08-03  385  		ice_write_qrxflxp_cntxt(hw, pf_q, rxdid, 0x3, true);
bc0412448da587 Grzegorz Nitka 2021-08-03  386  	}
bc0412448da587 Grzegorz Nitka 2021-08-03  387  }
bc0412448da587 Grzegorz Nitka 2021-08-03  388  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 68488 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20210819/7bb68e8d/attachment-0001.bin>
