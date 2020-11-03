From: kernel test robot <lkp@intel.com>
Date: Wed, 4 Nov 2020 04:54:48 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 62/106]
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c:5552:29: sparse: sparse:
 invalid assignment: |=
Message-ID: <202011040444.CWrQWQLh-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   977a109bc3e30ee6303dd767090e04eb5170e986
commit: ed57e25f6e6dcca81fee3ab107be576238d6b4ec [62/106] i40e: Add EEE status getting & setting implementation
config: x86_64-randconfig-s021-20201103 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.3-76-gf680124b-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git/commit/?id=ed57e25f6e6dcca81fee3ab107be576238d6b4ec
        git remote add jkirsher-next-queue https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git
        git fetch --no-tags jkirsher-next-queue dev-queue
        git checkout ed57e25f6e6dcca81fee3ab107be576238d6b4ec
        # save the attached .config to linux build tree
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=x86_64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


"sparse warnings: (new ones prefixed by >>)"
>> drivers/net/ethernet/intel/i40e/i40e_ethtool.c:5552:29: sparse: sparse: invalid assignment: |=
>> drivers/net/ethernet/intel/i40e/i40e_ethtool.c:5552:29: sparse:    left side has type restricted __le32
>> drivers/net/ethernet/intel/i40e/i40e_ethtool.c:5552:29: sparse:    right side has type unsigned int
   drivers/net/ethernet/intel/i40e/i40e_ethtool.c:5555:29: sparse: sparse: invalid assignment: &=
   drivers/net/ethernet/intel/i40e/i40e_ethtool.c:5555:29: sparse:    left side has type restricted __le32
   drivers/net/ethernet/intel/i40e/i40e_ethtool.c:5555:29: sparse:    right side has type unsigned int

vim +5552 drivers/net/ethernet/intel/i40e/i40e_ethtool.c

  5501	
  5502	static int i40e_set_eee(struct net_device *netdev, struct ethtool_eee *edata)
  5503	{
  5504		struct i40e_netdev_priv *np = netdev_priv(netdev);
  5505		struct i40e_aq_get_phy_abilities_resp abilities;
  5506		enum i40e_status_code status = I40E_SUCCESS;
  5507		struct i40e_aq_set_phy_config config;
  5508		struct i40e_vsi *vsi = np->vsi;
  5509		struct i40e_pf *pf = vsi->back;
  5510		struct i40e_hw *hw = &pf->hw;
  5511		__le16 eee_capability;
  5512	
  5513		/* Deny parameters we don't support */
  5514		if (i40e_is_eee_param_supported(netdev, edata))
  5515			return -EOPNOTSUPP;
  5516	
  5517		/* Get initial PHY capabilities */
  5518		status = i40e_aq_get_phy_capabilities(hw, false, true, &abilities,
  5519						      NULL);
  5520		if (status)
  5521			return -EAGAIN;
  5522	
  5523		/* Check whether NIC configuration is compatible with Energy Efficient
  5524		 * Ethernet (EEE) mode.
  5525		 */
  5526		if (abilities.eee_capability == 0)
  5527			return -EOPNOTSUPP;
  5528	
  5529		/* Cache initial EEE capability */
  5530		eee_capability = abilities.eee_capability;
  5531	
  5532		/* Get current PHY configuration */
  5533		status = i40e_aq_get_phy_capabilities(hw, false, false, &abilities,
  5534						      NULL);
  5535		if (status)
  5536			return -EAGAIN;
  5537	
  5538		/* Cache current PHY configuration */
  5539		config.phy_type = abilities.phy_type;
  5540		config.phy_type_ext = abilities.phy_type_ext;
  5541		config.link_speed = abilities.link_speed;
  5542		config.abilities = abilities.abilities |
  5543				   I40E_AQ_PHY_ENABLE_ATOMIC_LINK;
  5544		config.eeer = abilities.eeer_val;
  5545		config.low_power_ctrl = abilities.d3_lpan;
  5546		config.fec_config = abilities.fec_cfg_curr_mod_ext_info &
  5547				    I40E_AQ_PHY_FEC_CONFIG_MASK;
  5548	
  5549		/* Set desired EEE state */
  5550		if (edata->eee_enabled) {
  5551			config.eee_capability = eee_capability;
> 5552			config.eeer |= I40E_PRTPM_EEER_TX_LPI_EN_MASK;
  5553		} else {
  5554			config.eee_capability = 0;
  5555			config.eeer &= ~I40E_PRTPM_EEER_TX_LPI_EN_MASK;
  5556		}
  5557	
  5558		/* Apply modified PHY configuration */
  5559		status = i40e_aq_set_phy_config(hw, &config, NULL);
  5560		if (status)
  5561			return -EAGAIN;
  5562	
  5563		return 0;
  5564	}
  5565	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 40263 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20201104/da1174de/attachment-0001.bin>
