From: Gangfeng Huang <gangfeng.huang@ni.com>
Date: Wed, 23 Dec 2015 09:16:32 +0000
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 41/41]
 drivers/net/ethernet/intel/igb/igb_ethtool.c:2886:13: error: invalid
 storage class for function 'igb_clear_etype_filter_regs'
In-Reply-To: <201512231419.cX6v8GuD%fengguang.wu@intel.com>
References: <201512231419.cX6v8GuD%fengguang.wu@intel.com>
Message-ID: <DM2PR0401MB0990A08A0ADD5988400C13B4ECE60@DM2PR0401MB0990.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

It seem I create the patches based a wrong tree (net-next), I will do the test on the tree next-queue.git dev-queue as soon as possible. 

-----Original Message-----
From: kbuild test robot [mailto:fengguang.wu at intel.com] 
Sent: 2015?12?23? 14:03
To: Gangfeng Huang <gangfeng.huang@ni.com>
Cc: kbuild-all at 01.org; intel-wired-lan at lists.osuosl.org; Jeff Kirsher <jeffrey.t.kirsher@intel.com>; Ruhao Gao <ruhao.gao@ni.com>
Subject: [jkirsher-next-queue:dev-queue 41/41] drivers/net/ethernet/intel/igb/igb_ethtool.c:2886:13: error: invalid storage class for function 'igb_clear_etype_filter_regs'

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   eeb92201d0b92914bc95b0cf033d9f112ff3219a
commit: eeb92201d0b92914bc95b0cf033d9f112ff3219a [41/41] igb: add support of ethertype RX filters
config: x86_64-randconfig-x015-201551 (attached as .config)
reproduce:
        git checkout eeb92201d0b92914bc95b0cf033d9f112ff3219a
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All error/warnings (new ones prefixed by >>):

   drivers/net/ethernet/intel/igb/igb_ethtool.c:2886:1: sparse: mixing declarations and code
   builtin:0:0: sparse: Expected } at end of function
   builtin:0:0: sparse: got end-of-input
   drivers/net/ethernet/intel/igb/igb_ethtool.c: In function 'igb_add_filter':
>> drivers/net/ethernet/intel/igb/igb_ethtool.c:2886:13: error: invalid storage class for function 'igb_clear_etype_filter_regs'
    static void igb_clear_etype_filter_regs(struct igb_adapter *adapter,
                ^
>> drivers/net/ethernet/intel/igb/igb_ethtool.c:2886:1: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
    static void igb_clear_etype_filter_regs(struct igb_adapter *adapter,
    ^
>> drivers/net/ethernet/intel/igb/igb_ethtool.c:2909:12: error: invalid storage class for function 'igb_update_ethtool_nfc_entry'
    static int igb_update_ethtool_nfc_entry(struct igb_adapter *adapter,
               ^
>> drivers/net/ethernet/intel/igb/igb_ethtool.c:2957:12: error: invalid storage class for function 'igb_add_ethtool_nfc_entry'
    static int igb_add_ethtool_nfc_entry(struct igb_adapter *adapter,
               ^
>> drivers/net/ethernet/intel/igb/igb_ethtool.c:3026:12: error: invalid storage class for function 'igb_del_ethtool_nfc_entry'
    static int igb_del_ethtool_nfc_entry(struct igb_adapter *adapter,
               ^
>> drivers/net/ethernet/intel/igb/igb_ethtool.c:3040:12: error: invalid storage class for function 'igb_set_rxnfc'
    static int igb_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd)
               ^
>> drivers/net/ethernet/intel/igb/igb_ethtool.c:3061:12: error: invalid storage class for function 'igb_get_eee'
    static int igb_get_eee(struct net_device *netdev, struct ethtool_eee *edata)
               ^
>> drivers/net/ethernet/intel/igb/igb_ethtool.c:3139:12: error: invalid storage class for function 'igb_set_eee'
    static int igb_set_eee(struct net_device *netdev,
               ^
>> drivers/net/ethernet/intel/igb/igb_ethtool.c:3213:12: error: invalid storage class for function 'igb_get_module_info'
    static int igb_get_module_info(struct net_device *netdev,
               ^
>> drivers/net/ethernet/intel/igb/igb_ethtool.c:3255:12: error: invalid storage class for function 'igb_get_module_eeprom'
    static int igb_get_module_eeprom(struct net_device *netdev,
               ^
>> drivers/net/ethernet/intel/igb/igb_ethtool.c:3294:12: error: invalid storage class for function 'igb_ethtool_begin'
    static int igb_ethtool_begin(struct net_device *netdev)
               ^
>> drivers/net/ethernet/intel/igb/igb_ethtool.c:3301:13: error: invalid storage class for function 'igb_ethtool_complete'
    static void igb_ethtool_complete(struct net_device *netdev)
                ^
>> drivers/net/ethernet/intel/igb/igb_ethtool.c:3307:12: error: invalid storage class for function 'igb_get_rxfh_indir_size'
    static u32 igb_get_rxfh_indir_size(struct net_device *netdev)
               ^
>> drivers/net/ethernet/intel/igb/igb_ethtool.c:3312:12: error: invalid storage class for function 'igb_get_rxfh'
    static int igb_get_rxfh(struct net_device *netdev, u32 *indir, u8 *key,
               ^
>> drivers/net/ethernet/intel/igb/igb_ethtool.c:3363:12: error: invalid storage class for function 'igb_set_rxfh'
    static int igb_set_rxfh(struct net_device *netdev, const u32 *indir,
               ^
>> drivers/net/ethernet/intel/igb/igb_ethtool.c:3404:21: error: invalid storage class for function 'igb_max_channels'
    static unsigned int igb_max_channels(struct igb_adapter *adapter)
                        ^
>> drivers/net/ethernet/intel/igb/igb_ethtool.c:3439:13: error: invalid storage class for function 'igb_get_channels'
    static void igb_get_channels(struct net_device *netdev,
                ^
>> drivers/net/ethernet/intel/igb/igb_ethtool.c:3456:12: error: invalid storage class for function 'igb_set_channels'
    static int igb_set_channels(struct net_device *netdev,
               ^
>> drivers/net/ethernet/intel/igb/igb_ethtool.c:3517:16: error: initializer element is not constant
     .set_rxnfc  = igb_set_rxnfc,
                   ^
   drivers/net/ethernet/intel/igb/igb_ethtool.c:3517:16: note: (near initialization for 'igb_ethtool_ops.set_rxnfc')
   drivers/net/ethernet/intel/igb/igb_ethtool.c:3518:14: error: initializer element is not constant
     .get_eee  = igb_get_eee,
                 ^
   drivers/net/ethernet/intel/igb/igb_ethtool.c:3518:14: note: (near initialization for 'igb_ethtool_ops.get_eee')
   drivers/net/ethernet/intel/igb/igb_ethtool.c:3519:14: error: initializer element is not constant
     .set_eee  = igb_set_eee,
                 ^
   drivers/net/ethernet/intel/igb/igb_ethtool.c:3519:14: note: (near initialization for 'igb_ethtool_ops.set_eee')
   drivers/net/ethernet/intel/igb/igb_ethtool.c:3520:21: error: initializer element is not constant
     .get_module_info = igb_get_module_info,
                        ^
   drivers/net/ethernet/intel/igb/igb_ethtool.c:3520:21: note: (near initialization for 'igb_ethtool_ops.get_module_info')
   drivers/net/ethernet/intel/igb/igb_ethtool.c:3521:23: error: initializer element is not constant
     .get_module_eeprom = igb_get_module_eeprom,
                          ^
   drivers/net/ethernet/intel/igb/igb_ethtool.c:3521:23: note: (near initialization for 'igb_ethtool_ops.get_module_eeprom')
   drivers/net/ethernet/intel/igb/igb_ethtool.c:3522:25: error: initializer element is not constant
     .get_rxfh_indir_size = igb_get_rxfh_indir_size,
                            ^
   drivers/net/ethernet/intel/igb/igb_ethtool.c:3522:25: note: (near initialization for 'igb_ethtool_ops.get_rxfh_indir_size')
   drivers/net/ethernet/intel/igb/igb_ethtool.c:3523:15: error: initializer element is not constant
     .get_rxfh  = igb_get_rxfh,
                  ^
   drivers/net/ethernet/intel/igb/igb_ethtool.c:3523:15: note: (near initialization for 'igb_ethtool_ops.get_rxfh')
   drivers/net/ethernet/intel/igb/igb_ethtool.c:3524:15: error: initializer element is not constant
     .set_rxfh  = igb_set_rxfh,
                  ^
   drivers/net/ethernet/intel/igb/igb_ethtool.c:3524:15: note: (near initialization for 'igb_ethtool_ops.set_rxfh')
   drivers/net/ethernet/intel/igb/igb_ethtool.c:3525:19: error: initializer element is not constant
     .get_channels  = igb_get_channels,
                      ^
   drivers/net/ethernet/intel/igb/igb_ethtool.c:3525:19: note: (near initialization for 'igb_ethtool_ops.get_channels')
   drivers/net/ethernet/intel/igb/igb_ethtool.c:3526:19: error: initializer element is not constant
     .set_channels  = igb_set_channels,
                      ^
   drivers/net/ethernet/intel/igb/igb_ethtool.c:3526:19: note: (near initialization for 'igb_ethtool_ops.set_channels')
   drivers/net/ethernet/intel/igb/igb_ethtool.c:3527:13: error: initializer element is not constant
     .begin   = igb_ethtool_begin,
                ^
   drivers/net/ethernet/intel/igb/igb_ethtool.c:3527:13: note: (near initialization for 'igb_ethtool_ops.begin')
   drivers/net/ethernet/intel/igb/igb_ethtool.c:3528:15: error: initializer element is not constant
     .complete  = igb_ethtool_complete,
                  ^
   drivers/net/ethernet/intel/igb/igb_ethtool.c:3528:15: note: (near initialization for 'igb_ethtool_ops.complete')
>> drivers/net/ethernet/intel/igb/igb_ethtool.c:3534:1: error: expected declaration or statement at end of input
    }
    ^

vim +/igb_clear_etype_filter_regs +2886 drivers/net/ethernet/intel/igb/igb_ethtool.c

  2880		if (input->filter.match_flags & IGB_FILTER_FLAG_ETHER_TYPE) {
  2881			err = igb_rxnfc_write_etype_filter(adapter, input);
  2882	
  2883		return err;
  2884	}
  2885	
> 2886	static void igb_clear_etype_filter_regs(struct igb_adapter *adapter,
  2887						u16 reg_index)
  2888	{
  2889		struct e1000_hw *hw = &adapter->hw;
  2890		u32 etqf = rd32(E1000_ETQF(reg_index));
  2891	
  2892		etqf &= ~E1000_ETQF_QUEUE_ENABLE;
  2893		etqf &= ~E1000_ETQF_QUEUE_MASK;
  2894		etqf &= ~E1000_ETQF_FILTER_ENABLE;
  2895	
  2896		wr32(E1000_ETQF(reg_index), etqf);
  2897	
  2898		adapter->etype_bitmap[reg_index] = false;
  2899	}
  2900	
  2901	int igb_erase_filter(struct igb_adapter *adapter, struct igb_nfc_filter *input)
  2902	{
  2903		if (input->filter.match_flags & IGB_FILTER_FLAG_ETHER_TYPE)
  2904			igb_clear_etype_filter_regs(adapter,
  2905						    input->etype_reg_index);
  2906		return 0;
  2907	}
  2908	
> 2909	static int igb_update_ethtool_nfc_entry(struct igb_adapter *adapter,
  2910						struct igb_nfc_filter *input,
  2911						u16 sw_idx)
  2912	{
  2913		struct igb_nfc_filter *rule, *parent;
  2914		int err = -EINVAL;
  2915	
  2916		parent = NULL;
  2917		rule = NULL;
  2918	
  2919		hlist_for_each_entry(rule, &adapter->nfc_filter_list, nfc_node) {
  2920			/* hash found, or no matching entry */
  2921			if (rule->sw_idx >= sw_idx)
  2922				break;
  2923			parent = rule;
  2924		}
  2925	
  2926		/* if there is an old rule occupying our place remove it */
  2927		if (rule && (rule->sw_idx == sw_idx)) {
  2928			if (!input)
  2929				err = igb_erase_filter(adapter, rule);
  2930	
  2931			hlist_del(&rule->nfc_node);
  2932			kfree(rule);
  2933			adapter->nfc_filter_count--;
  2934		}
  2935	
  2936		/* If no input this was a delete, err should be 0 if a rule was
  2937		 * successfully found and removed from the list else -EINVAL
  2938		 */
  2939		if (!input)
  2940			return err;
  2941	
  2942		/* initialize node */
  2943		INIT_HLIST_NODE(&input->nfc_node);
  2944	
  2945		/* add filter to the list */
  2946		if (parent)
  2947			hlist_add_behind(&parent->nfc_node, &input->nfc_node);
  2948		else
  2949			hlist_add_head(&input->nfc_node, &adapter->nfc_filter_list);
  2950	
  2951		/* update counts */
  2952		adapter->nfc_filter_count++;
  2953	
  2954		return 0;
  2955	}
  2956	
> 2957	static int igb_add_ethtool_nfc_entry(struct igb_adapter *adapter,
  2958					     struct ethtool_rxnfc *cmd)
  2959	{
  2960		struct net_device *netdev = adapter->netdev;
  2961		struct ethtool_rx_flow_spec *fsp =
  2962			(struct ethtool_rx_flow_spec *)&cmd->fs;
  2963		struct igb_nfc_filter *input, *rule;
  2964		int err = 0;
  2965	
  2966		if (!(netdev->hw_features & NETIF_F_NTUPLE))
  2967			return -ENOTSUPP;
  2968	
  2969		/* Don't allow programming if the action is a queue greater than
  2970		 * the number of online Rx queues.
  2971		 */
  2972		if ((fsp->ring_cookie == RX_CLS_FLOW_DISC) ||
  2973		    (fsp->ring_cookie >= adapter->num_rx_queues)) {
  2974			dev_err(&adapter->pdev->dev, "ethtool -N: The specified action is invalid\n");
  2975			return -EINVAL;
  2976		}
  2977	
  2978		/* Don't allow indexes to exist outside of available space */
  2979		if (fsp->location >= IGB_MAX_RXNFC_FILTERS) {
  2980			dev_err(&adapter->pdev->dev, "Location out of range\n");
  2981			return -EINVAL;
  2982		}
  2983	
  2984		if ((fsp->flow_type & ~FLOW_EXT) != ETHER_FLOW)
  2985			return -EINVAL;
  2986	
  2987		if (fsp->m_u.ether_spec.h_proto != ETHER_TYPE_FULL_MASK)
  2988			return -EINVAL;
  2989	
  2990		input = kzalloc(sizeof(*input), GFP_KERNEL);
  2991		if (!input)
  2992			return -ENOMEM;
  2993	
  2994		input->filter.etype = fsp->h_u.ether_spec.h_proto;
  2995		input->filter.match_flags = IGB_FILTER_FLAG_ETHER_TYPE;
  2996		input->action = fsp->ring_cookie;
  2997		input->sw_idx = fsp->location;
  2998	
  2999		spin_lock(&adapter->nfc_lock);
  3000	
  3001		hlist_for_each_entry(rule, &adapter->nfc_filter_list, nfc_node) {
  3002			if (!memcmp(&input->filter, &rule->filter,
  3003				    sizeof(input->filter))) {
  3004				err = -EEXIST;
  3005				dev_err(&adapter->pdev->dev,
  3006					"ethtool: this filter is already set\n");
  3007				goto err_out_w_lock;
  3008			}
  3009		}
  3010	
  3011		err = igb_add_filter(adapter, input);
  3012		if (err)
  3013			goto err_out_w_lock;
  3014	
  3015		igb_update_ethtool_nfc_entry(adapter, input, input->sw_idx);
  3016	
  3017		spin_unlock(&adapter->nfc_lock);
  3018		return 0;
  3019	
  3020	err_out_w_lock:
  3021		spin_unlock(&adapter->nfc_lock);
  3022		kfree(input);
  3023		return err;
  3024	}
  3025	
> 3026	static int igb_del_ethtool_nfc_entry(struct igb_adapter *adapter,
  3027					     struct ethtool_rxnfc *cmd)
  3028	{
  3029		struct ethtool_rx_flow_spec *fsp =
  3030			(struct ethtool_rx_flow_spec *)&cmd->fs;
  3031		int err;
  3032	
  3033		spin_lock(&adapter->nfc_lock);
  3034		err = igb_update_ethtool_nfc_entry(adapter, NULL, fsp->location);
  3035		spin_unlock(&adapter->nfc_lock);
  3036	
  3037		return err;
  3038	}
  3039	
> 3040	static int igb_set_rxnfc(struct net_device *dev, struct ethtool_rxnfc *cmd)
  3041	{
  3042		struct igb_adapter *adapter = netdev_priv(dev);
  3043		int ret = -EOPNOTSUPP;
  3044	
  3045		switch (cmd->cmd) {
  3046		case ETHTOOL_SRXFH:
  3047			ret = igb_set_rss_hash_opt(adapter, cmd);
  3048			break;
  3049		case ETHTOOL_SRXCLSRLINS:
  3050			ret = igb_add_ethtool_nfc_entry(adapter, cmd);
  3051			break;
  3052		case ETHTOOL_SRXCLSRLDEL:
  3053			ret = igb_del_ethtool_nfc_entry(adapter, cmd);
  3054		default:
  3055			break;
  3056		}
  3057	
  3058		return ret;
  3059	}
  3060	
> 3061	static int igb_get_eee(struct net_device *netdev, struct ethtool_eee *edata)
  3062	{
  3063		struct igb_adapter *adapter = netdev_priv(netdev);
  3064		struct e1000_hw *hw = &adapter->hw;

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
