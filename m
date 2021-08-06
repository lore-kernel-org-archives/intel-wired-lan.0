From: kernel test robot <lkp@intel.com>
Date: Fri, 6 Aug 2021 09:08:06 +0800
Subject: [Intel-wired-lan] [PATCH v3 intel-next 1/6] ice: split ice_ring
 onto Tx/Rx separate structs
In-Reply-To: <20210805230046.28715-2-maciej.fijalkowski@intel.com>
References: <20210805230046.28715-2-maciej.fijalkowski@intel.com>
Message-ID: <202108060815.1uY7RFpz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Maciej,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on ipvs/master]
[also build test ERROR on v5.14-rc4 next-20210805]
[cannot apply to tnguy-next-queue/dev-queue sparc-next/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Maciej-Fijalkowski/XDP_TX-improvements-for-ice/20210806-071546
base:   https://git.kernel.org/pub/scm/linux/kernel/git/horms/ipvs.git master
config: powerpc64-randconfig-s032-20210804 (attached as .config)
compiler: powerpc-linux-gcc (GCC) 10.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.3-348-gf0e6938b-dirty
        # https://github.com/0day-ci/linux/commit/349763b451b9e0cd2d65208bb0664e581b8afffb
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Maciej-Fijalkowski/XDP_TX-improvements-for-ice/20210806-071546
        git checkout 349763b451b9e0cd2d65208bb0664e581b8afffb
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-10.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=powerpc64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   drivers/net/ethernet/intel/ice/ice_base.c: In function 'ice_setup_tx_ctx':
>> drivers/net/ethernet/intel/ice/ice_base.c:262:32: warning: passing argument 2 of 'ice_set_cgd_num' makes pointer from integer without a cast [-Wint-conversion]
     262 |  ice_set_cgd_num(tlan_ctx, ring->dcb_tc);
         |                            ~~~~^~~~~~~~
         |                                |
         |                                u8 {aka unsigned char}
   In file included from drivers/net/ethernet/intel/ice/ice_base.c:7:
   drivers/net/ethernet/intel/ice/ice_dcb_lib.h:122:84: note: expected 'struct ice_ring *' but argument is of type 'u8' {aka 'unsigned char'}
     122 | static inline void ice_set_cgd_num(struct ice_tlan_ctx *tlan_ctx, struct ice_ring *ring) { }
         |                                                                   ~~~~~~~~~~~~~~~~~^~~~
--
   drivers/net/ethernet/intel/ice/ice_txrx.c: In function 'ice_tx_prepare_vlan_flags':
>> drivers/net/ethernet/intel/ice/ice_txrx.c:1876:32: error: passing argument 1 of 'ice_tx_prepare_vlan_flags_dcb' from incompatible pointer type [-Werror=incompatible-pointer-types]
    1876 |  ice_tx_prepare_vlan_flags_dcb(tx_ring, first);
         |                                ^~~~~~~
         |                                |
         |                                struct ice_tx_ring *
   In file included from drivers/net/ethernet/intel/ice/ice_txrx.c:14:
   drivers/net/ethernet/intel/ice/ice_dcb_lib.h:98:64: note: expected 'struct ice_ring *' but argument is of type 'struct ice_tx_ring *'
      98 | ice_tx_prepare_vlan_flags_dcb(struct ice_ring __always_unused *tx_ring,
         |                               ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
   cc1: some warnings being treated as errors


sparse warnings: (new ones prefixed by >>)
>> drivers/net/ethernet/intel/ice/ice_base.c:262:39: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected struct ice_ring *ring @@     got unsigned char [usertype] dcb_tc @@
   drivers/net/ethernet/intel/ice/ice_base.c:262:39: sparse:     expected struct ice_ring *ring
   drivers/net/ethernet/intel/ice/ice_base.c:262:39: sparse:     got unsigned char [usertype] dcb_tc
>> drivers/net/ethernet/intel/ice/ice_base.c:262:35: sparse: sparse: non size-preserving integer to pointer cast

vim +/ice_tx_prepare_vlan_flags_dcb +1876 drivers/net/ethernet/intel/ice/ice_txrx.c

d76a60ba7afb89 Anirudh Venkataramanan 2018-03-20  1850  
d76a60ba7afb89 Anirudh Venkataramanan 2018-03-20  1851  /**
f9867df6d96593 Anirudh Venkataramanan 2019-02-19  1852   * ice_tx_prepare_vlan_flags - prepare generic Tx VLAN tagging flags for HW
d76a60ba7afb89 Anirudh Venkataramanan 2018-03-20  1853   * @tx_ring: ring to send buffer on
d76a60ba7afb89 Anirudh Venkataramanan 2018-03-20  1854   * @first: pointer to struct ice_tx_buf
d76a60ba7afb89 Anirudh Venkataramanan 2018-03-20  1855   *
d76a60ba7afb89 Anirudh Venkataramanan 2018-03-20  1856   * Checks the skb and set up correspondingly several generic transmit flags
d76a60ba7afb89 Anirudh Venkataramanan 2018-03-20  1857   * related to VLAN tagging for the HW, such as VLAN, DCB, etc.
d76a60ba7afb89 Anirudh Venkataramanan 2018-03-20  1858   */
2bb19d6e077190 Brett Creeley          2020-05-15  1859  static void
349763b451b9e0 Maciej Fijalkowski     2021-08-06  1860  ice_tx_prepare_vlan_flags(struct ice_tx_ring *tx_ring, struct ice_tx_buf *first)
d76a60ba7afb89 Anirudh Venkataramanan 2018-03-20  1861  {
d76a60ba7afb89 Anirudh Venkataramanan 2018-03-20  1862  	struct sk_buff *skb = first->skb;
d76a60ba7afb89 Anirudh Venkataramanan 2018-03-20  1863  
2bb19d6e077190 Brett Creeley          2020-05-15  1864  	/* nothing left to do, software offloaded VLAN */
2bb19d6e077190 Brett Creeley          2020-05-15  1865  	if (!skb_vlan_tag_present(skb) && eth_type_vlan(skb->protocol))
2bb19d6e077190 Brett Creeley          2020-05-15  1866  		return;
2bb19d6e077190 Brett Creeley          2020-05-15  1867  
2bb19d6e077190 Brett Creeley          2020-05-15  1868  	/* currently, we always assume 802.1Q for VLAN insertion as VLAN
2bb19d6e077190 Brett Creeley          2020-05-15  1869  	 * insertion for 802.1AD is not supported
2bb19d6e077190 Brett Creeley          2020-05-15  1870  	 */
d76a60ba7afb89 Anirudh Venkataramanan 2018-03-20  1871  	if (skb_vlan_tag_present(skb)) {
d76a60ba7afb89 Anirudh Venkataramanan 2018-03-20  1872  		first->tx_flags |= skb_vlan_tag_get(skb) << ICE_TX_FLAGS_VLAN_S;
d76a60ba7afb89 Anirudh Venkataramanan 2018-03-20  1873  		first->tx_flags |= ICE_TX_FLAGS_HW_VLAN;
d76a60ba7afb89 Anirudh Venkataramanan 2018-03-20  1874  	}
d76a60ba7afb89 Anirudh Venkataramanan 2018-03-20  1875  
2bb19d6e077190 Brett Creeley          2020-05-15 @1876  	ice_tx_prepare_vlan_flags_dcb(tx_ring, first);
d76a60ba7afb89 Anirudh Venkataramanan 2018-03-20  1877  }
d76a60ba7afb89 Anirudh Venkataramanan 2018-03-20  1878  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 41149 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20210806/097c7cd6/attachment-0001.bin>
