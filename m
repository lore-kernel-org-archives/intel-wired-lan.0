From: kernel test robot <lkp@intel.com>
Date: Thu, 19 Aug 2021 06:39:18 +0800
Subject: [Intel-wired-lan] [PATCH v6 intel-next 3/9] ice: split ice_ring
 onto Tx/Rx separate structs
In-Reply-To: <20210818135916.25007-4-maciej.fijalkowski@intel.com>
References: <20210818135916.25007-4-maciej.fijalkowski@intel.com>
Message-ID: <202108190612.1cjFNkPk-lkp@intel.com>
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
config: x86_64-allyesconfig (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/8efea0970271c16b9bab35cf49ce219c16a7479b
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Maciej-Fijalkowski/XDP_TX-improvements-for-ice/20210818-221906
        git checkout 8efea0970271c16b9bab35cf49ce219c16a7479b
        # save the attached .config to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/net/ethernet/intel/ice/ice_eswitch.c: In function 'ice_eswitch_remap_rings_to_vectors':
>> drivers/net/ethernet/intel/ice/ice_eswitch.c:97:16: error: 'struct ice_ring_container' has no member named 'ring'; did you mean 'rx_ring'?
      97 |   q_vector->tx.ring = tx_ring;
         |                ^~~~
         |                rx_ring
>> drivers/net/ethernet/intel/ice/ice_eswitch.c:100:21: error: 'netdev' undeclared (first use in this function); did you mean 'net_eq'?
     100 |   tx_ring->netdev = netdev;
         |                     ^~~~~~
         |                     net_eq
   drivers/net/ethernet/intel/ice/ice_eswitch.c:100:21: note: each undeclared identifier is reported only once for each function it appears in
   drivers/net/ethernet/intel/ice/ice_eswitch.c:107:16: error: 'struct ice_ring_container' has no member named 'ring'; did you mean 'rx_ring'?
     107 |   q_vector->rx.ring = rx_ring;
         |                ^~~~
         |                rx_ring
   drivers/net/ethernet/intel/ice/ice_eswitch.c: In function 'ice_eswitch_set_rxdid':
>> drivers/net/ethernet/intel/ice/ice_eswitch.c:382:27: error: initialization of 'struct ice_ring *' from incompatible pointer type 'struct ice_rx_ring *' [-Werror=incompatible-pointer-types]
     382 |   struct ice_ring *ring = vsi->rx_rings[i];
         |                           ^~~
>> drivers/net/ethernet/intel/ice/ice_eswitch.c:383:31: error: dereferencing pointer to incomplete type 'struct ice_ring'
     383 |   u16 pf_q = vsi->rxq_map[ring->q_index];
         |                               ^~
   cc1: some warnings being treated as errors


vim +97 drivers/net/ethernet/intel/ice/ice_eswitch.c

bc0412448da587 Grzegorz Nitka     2021-08-03   70  
bc0412448da587 Grzegorz Nitka     2021-08-03   71  /**
bc0412448da587 Grzegorz Nitka     2021-08-03   72   * ice_eswitch_remap_rings_to_vectors - reconfigure rings of switchdev ctrl VSI
bc0412448da587 Grzegorz Nitka     2021-08-03   73   * @pf: pointer to PF struct
bc0412448da587 Grzegorz Nitka     2021-08-03   74   *
bc0412448da587 Grzegorz Nitka     2021-08-03   75   * In switchdev number of allocated Tx/Rx rings is equal.
bc0412448da587 Grzegorz Nitka     2021-08-03   76   *
bc0412448da587 Grzegorz Nitka     2021-08-03   77   * This function fills q_vectors structures associated with representator and
bc0412448da587 Grzegorz Nitka     2021-08-03   78   * move each ring pairs to port representator netdevs. Each port representor
bc0412448da587 Grzegorz Nitka     2021-08-03   79   * will have dedicated 1 Tx/Rx ring pair, so number of rings pair is equal to
bc0412448da587 Grzegorz Nitka     2021-08-03   80   * number of VFs.
bc0412448da587 Grzegorz Nitka     2021-08-03   81   */
bc0412448da587 Grzegorz Nitka     2021-08-03   82  static void ice_eswitch_remap_rings_to_vectors(struct ice_pf *pf)
bc0412448da587 Grzegorz Nitka     2021-08-03   83  {
bc0412448da587 Grzegorz Nitka     2021-08-03   84  	struct ice_vsi *vsi = pf->switchdev.control_vsi;
bc0412448da587 Grzegorz Nitka     2021-08-03   85  	int q_id;
bc0412448da587 Grzegorz Nitka     2021-08-03   86  
bc0412448da587 Grzegorz Nitka     2021-08-03   87  	ice_for_each_txq(vsi, q_id) {
bc0412448da587 Grzegorz Nitka     2021-08-03   88  		struct ice_repr *repr = pf->vf[q_id].repr;
bc0412448da587 Grzegorz Nitka     2021-08-03   89  		struct ice_q_vector *q_vector = repr->q_vector;
8efea0970271c1 Maciej Fijalkowski 2021-08-18   90  		struct ice_tx_ring *tx_ring = vsi->tx_rings[q_id];
8efea0970271c1 Maciej Fijalkowski 2021-08-18   91  		struct ice_rx_ring *rx_ring = vsi->rx_rings[q_id];
bc0412448da587 Grzegorz Nitka     2021-08-03   92  
bc0412448da587 Grzegorz Nitka     2021-08-03   93  		q_vector->vsi = vsi;
bc0412448da587 Grzegorz Nitka     2021-08-03   94  		q_vector->reg_idx = vsi->q_vectors[0]->reg_idx;
bc0412448da587 Grzegorz Nitka     2021-08-03   95  
bc0412448da587 Grzegorz Nitka     2021-08-03   96  		q_vector->num_ring_tx = 1;
bc0412448da587 Grzegorz Nitka     2021-08-03  @97  		q_vector->tx.ring = tx_ring;
8efea0970271c1 Maciej Fijalkowski 2021-08-18   98  		tx_ring->q_vector = q_vector;
8efea0970271c1 Maciej Fijalkowski 2021-08-18   99  		tx_ring->next = NULL;
8efea0970271c1 Maciej Fijalkowski 2021-08-18 @100  		tx_ring->netdev = netdev;
bc0412448da587 Grzegorz Nitka     2021-08-03  101  		/* In switchdev mode, from OS stack perspective, there is only
bc0412448da587 Grzegorz Nitka     2021-08-03  102  		 * one queue for given netdev, so it needs to be indexed as 0.
bc0412448da587 Grzegorz Nitka     2021-08-03  103  		 */
bc0412448da587 Grzegorz Nitka     2021-08-03  104  		tx_ring->q_index = 0;
bc0412448da587 Grzegorz Nitka     2021-08-03  105  
bc0412448da587 Grzegorz Nitka     2021-08-03  106  		q_vector->num_ring_rx = 1;
bc0412448da587 Grzegorz Nitka     2021-08-03  107  		q_vector->rx.ring = rx_ring;
8efea0970271c1 Maciej Fijalkowski 2021-08-18  108  		rx_ring->q_vector = q_vector;
8efea0970271c1 Maciej Fijalkowski 2021-08-18  109  		rx_ring->next = NULL;
8efea0970271c1 Maciej Fijalkowski 2021-08-18  110  		rx_ring->netdev = netdev;
bc0412448da587 Grzegorz Nitka     2021-08-03  111  	}
bc0412448da587 Grzegorz Nitka     2021-08-03  112  }
bc0412448da587 Grzegorz Nitka     2021-08-03  113  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 65637 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20210819/c22917a7/attachment-0001.bin>
