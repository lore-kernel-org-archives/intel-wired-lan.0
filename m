From: kernel test robot <lkp@intel.com>
Date: Sat, 7 Aug 2021 00:34:59 +0800
Subject: [Intel-wired-lan] [PATCH v4 intel-next 1/6] ice: split ice_ring
 onto Tx/Rx separate structs
In-Reply-To: <20210806095539.34423-2-maciej.fijalkowski@intel.com>
References: <20210806095539.34423-2-maciej.fijalkowski@intel.com>
Message-ID: <202108070003.U9G2g9hw-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Maciej,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on ipvs/master]
[also build test WARNING on v5.14-rc4 next-20210805]
[cannot apply to tnguy-next-queue/dev-queue sparc-next/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Maciej-Fijalkowski/XDP_TX-improvements-for-ice/20210806-181155
base:   https://git.kernel.org/pub/scm/linux/kernel/git/horms/ipvs.git master
config: x86_64-randconfig-a006-20210804 (attached as .config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 42b9c2a17a0b63cccf3ac197a82f91b28e53e643)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/8d6527ccf7e797a316a0ff3d8713d756ebc56e88
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Maciej-Fijalkowski/XDP_TX-improvements-for-ice/20210806-181155
        git checkout 8d6527ccf7e797a316a0ff3d8713d756ebc56e88
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=x86_64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/intel/ice/ice_main.c:5649:7: warning: variable 'pkts' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
                   if (ring)
                       ^~~~
   drivers/net/ethernet/intel/ice/ice_main.c:5651:28: note: uninitialized use occurs here
                   vsi_stats->tx_packets += pkts;
                                            ^~~~
   drivers/net/ethernet/intel/ice/ice_main.c:5649:3: note: remove the 'if' if its condition is always true
                   if (ring)
                   ^~~~~~~~~
   drivers/net/ethernet/intel/ice/ice_main.c:5646:11: note: initialize the variable 'pkts' to silence this warning
                   u64 pkts, bytes;
                           ^
                            = 0
>> drivers/net/ethernet/intel/ice/ice_main.c:5649:7: warning: variable 'bytes' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
                   if (ring)
                       ^~~~
   drivers/net/ethernet/intel/ice/ice_main.c:5652:26: note: uninitialized use occurs here
                   vsi_stats->tx_bytes += bytes;
                                          ^~~~~
   drivers/net/ethernet/intel/ice/ice_main.c:5649:3: note: remove the 'if' if its condition is always true
                   if (ring)
                   ^~~~~~~~~
   drivers/net/ethernet/intel/ice/ice_main.c:5646:18: note: initialize the variable 'bytes' to silence this warning
                   u64 pkts, bytes;
                                  ^
                                   = 0
   2 warnings generated.
--
>> drivers/net/ethernet/intel/ice/ice_ethtool.c:1342:7: warning: variable 'ring' is uninitialized when used here [-Wuninitialized]
                   if (ring) {
                       ^~~~
   drivers/net/ethernet/intel/ice/ice_ethtool.c:1323:23: note: initialize the variable 'ring' to silence this warning
           struct ice_ring *ring;
                                ^
                                 = NULL
   1 warning generated.


vim +5649 drivers/net/ethernet/intel/ice/ice_main.c

  5630	
  5631	/**
  5632	 * ice_update_vsi_tx_ring_stats - Update VSI Tx ring stats counters
  5633	 * @vsi: the VSI to be updated
  5634	 * @rings: rings to work on
  5635	 * @count: number of rings
  5636	 */
  5637	static void
  5638	ice_update_vsi_tx_ring_stats(struct ice_vsi *vsi, struct ice_tx_ring **rings,
  5639				     u16 count)
  5640	{
  5641		struct rtnl_link_stats64 *vsi_stats = &vsi->net_stats;
  5642		u16 i;
  5643	
  5644		for (i = 0; i < count; i++) {
  5645			struct ice_tx_ring *ring;
  5646			u64 pkts, bytes;
  5647	
  5648			ring = READ_ONCE(rings[i]);
> 5649			if (ring)
  5650				ice_fetch_u64_stats_per_ring(&ring->syncp, ring->stats, &pkts, &bytes);
  5651			vsi_stats->tx_packets += pkts;
  5652			vsi_stats->tx_bytes += bytes;
  5653			vsi->tx_restart += ring->tx_stats.restart_q;
  5654			vsi->tx_busy += ring->tx_stats.tx_busy;
  5655			vsi->tx_linearize += ring->tx_stats.tx_linearize;
  5656		}
  5657	}
  5658	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 36478 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20210807/9fc798ca/attachment-0001.bin>
