From: kbuild test robot <lkp@intel.com>
Date: Mon, 26 Feb 2018 08:12:32 +0800
Subject: [Intel-wired-lan] [next-queue PATCH 7/8] igb: Add support for
 adding offloaded clsflower filters
In-Reply-To: <20180224012036.5834-8-vinicius.gomes@intel.com>
References: <20180224012036.5834-8-vinicius.gomes@intel.com>
Message-ID: <201802260852.sZGOaY4C%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Vinicius,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on jkirsher-next-queue/dev-queue]
[also build test WARNING on v4.16-rc2 next-20180223]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Vinicius-Costa-Gomes/igb-Fix-not-adding-filter-elements-to-the-list/20180226-053124
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   drivers/net/ethernet/intel/igb/igb_main.c:474:25: sparse: cast to restricted __le64
   drivers/net/ethernet/intel/igb/igb_main.c:474:25: sparse: cast to restricted __le64
   drivers/net/ethernet/intel/igb/igb_main.c:554:33: sparse: cast to restricted __le64
   drivers/net/ethernet/intel/igb/igb_main.c:554:33: sparse: cast to restricted __le64
   drivers/net/ethernet/intel/igb/igb_main.c:560:33: sparse: cast to restricted __le64
   drivers/net/ethernet/intel/igb/igb_main.c:560:33: sparse: cast to restricted __le64
>> drivers/net/ethernet/intel/igb/igb_main.c:2573:48: sparse: incorrect type in assignment (different base types) @@ expected restricted __be16 vlan_tci @@ got unsignedrestricted __be16 vlan_tci @@
   drivers/net/ethernet/intel/igb/igb_main.c:2573:48: expected restricted __be16 vlan_tci
   drivers/net/ethernet/intel/igb/igb_main.c:2573:48: got unsigned short vlan_priority:3
   drivers/net/ethernet/intel/igb/igb_main.c:5616:46: sparse: incorrect type in argument 2 (different base types) @@ expected restricted __wsum diff @@ got restricted __wsum diff @@
   drivers/net/ethernet/intel/igb/igb_main.c:5616:46: expected restricted __wsum diff
   drivers/net/ethernet/intel/igb/igb_main.c:5616:46: got restricted __be32 <noident>
   drivers/net/ethernet/intel/igb/igb_main.c:8047:31: sparse: cast to restricted __be16
   drivers/net/ethernet/intel/igb/igb_main.c:8047:31: sparse: cast from restricted __le16
   drivers/net/ethernet/intel/igb/igb_main.c:8047:31: sparse: cast to restricted __be16
   drivers/net/ethernet/intel/igb/igb_main.c:8047:31: sparse: cast from restricted __le16
   drivers/net/ethernet/intel/igb/igb_main.c:8047:31: sparse: cast to restricted __be16
   drivers/net/ethernet/intel/igb/igb_main.c:8047:31: sparse: cast from restricted __le16
   drivers/net/ethernet/intel/igb/igb_main.c:8047:31: sparse: cast to restricted __be16
   drivers/net/ethernet/intel/igb/igb_main.c:8047:31: sparse: cast from restricted __le16

vim +2573 drivers/net/ethernet/intel/igb/igb_main.c

  2503	
  2504	static int igb_parse_cls_flower(struct igb_adapter *adapter,
  2505					struct tc_cls_flower_offload *f,
  2506					int traffic_class,
  2507					struct igb_nfc_filter *input)
  2508	{
  2509		if (f->dissector->used_keys &
  2510		    ~(BIT(FLOW_DISSECTOR_KEY_BASIC) |
  2511		      BIT(FLOW_DISSECTOR_KEY_CONTROL) |
  2512		      BIT(FLOW_DISSECTOR_KEY_ETH_ADDRS) |
  2513		      BIT(FLOW_DISSECTOR_KEY_VLAN))) {
  2514			dev_err(&adapter->pdev->dev, "Unsupported key used: 0x%x\n",
  2515				f->dissector->used_keys);
  2516			return -EOPNOTSUPP;
  2517		}
  2518	
  2519		if (dissector_uses_key(f->dissector, FLOW_DISSECTOR_KEY_ETH_ADDRS)) {
  2520			struct flow_dissector_key_eth_addrs *key =
  2521				skb_flow_dissector_target(f->dissector,
  2522							  FLOW_DISSECTOR_KEY_ETH_ADDRS,
  2523							  f->key);
  2524	
  2525			struct flow_dissector_key_eth_addrs *mask =
  2526				skb_flow_dissector_target(f->dissector,
  2527							  FLOW_DISSECTOR_KEY_ETH_ADDRS,
  2528							  f->mask);
  2529	
  2530			if (is_broadcast_ether_addr(mask->dst)) {
  2531				input->filter.match_flags |=
  2532					IGB_FILTER_FLAG_DST_MAC_ADDR;
  2533				ether_addr_copy(input->filter.dst_addr, key->dst);
  2534			}
  2535	
  2536			if (is_broadcast_ether_addr(mask->src)) {
  2537				input->filter.match_flags |=
  2538					IGB_FILTER_FLAG_SRC_MAC_ADDR;
  2539				ether_addr_copy(input->filter.src_addr, key->src);
  2540			}
  2541		}
  2542	
  2543		if (dissector_uses_key(f->dissector, FLOW_DISSECTOR_KEY_BASIC)) {
  2544			struct flow_dissector_key_basic *key =
  2545				skb_flow_dissector_target(f->dissector,
  2546							  FLOW_DISSECTOR_KEY_BASIC,
  2547							  f->key);
  2548	
  2549			struct flow_dissector_key_basic *mask =
  2550				skb_flow_dissector_target(f->dissector,
  2551							  FLOW_DISSECTOR_KEY_BASIC,
  2552							  f->mask);
  2553	
  2554			if (mask->n_proto == ETHER_TYPE_FULL_MASK) {
  2555				input->filter.match_flags |=
  2556					IGB_FILTER_FLAG_ETHER_TYPE;
  2557				input->filter.etype = key->n_proto;
  2558			}
  2559		}
  2560	
  2561		if (dissector_uses_key(f->dissector, FLOW_DISSECTOR_KEY_VLAN)) {
  2562			struct flow_dissector_key_vlan *key =
  2563				skb_flow_dissector_target(f->dissector,
  2564							  FLOW_DISSECTOR_KEY_VLAN,
  2565							  f->key);
  2566			struct flow_dissector_key_vlan *mask =
  2567				skb_flow_dissector_target(f->dissector,
  2568							  FLOW_DISSECTOR_KEY_VLAN,
  2569							  f->mask);
  2570	
  2571			if (mask->vlan_priority) {
  2572				input->filter.match_flags |= IGB_FILTER_FLAG_VLAN_TCI;
> 2573				input->filter.vlan_tci = key->vlan_priority;
  2574			}
  2575		}
  2576	
  2577		input->action = traffic_class;
  2578		input->cookie = f->cookie;
  2579	
  2580		return 0;
  2581	}
  2582	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
