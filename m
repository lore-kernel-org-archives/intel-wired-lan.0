From: kbuild test robot <fengguang.wu@intel.com>
Date: Sat, 13 Jan 2018 06:44:09 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 108/109]
 drivers/net/ethernet/intel/i40evf/i40evf_main.c:2607:49: sparse: invalid
 assignment: |=
Message-ID: <201801130638.l7ZonX3c%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   5a2f5288e8033ca6995630146eb61790471d9542
commit: 2b7317305ce97510ce8f1b2017869de4f7c39e79 [108/109] i40evf: Add support to apply cloud filters
reproduce:
        # apt-get install sparse
        git checkout 2b7317305ce97510ce8f1b2017869de4f7c39e79
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/net/ethernet/intel/i40evf/i40evf_main.c:2607:49: sparse: invalid assignment: |=
   drivers/net/ethernet/intel/i40evf/i40evf_main.c:2607:49: left side has type restricted __be16
   drivers/net/ethernet/intel/i40evf/i40evf_main.c:2607:49: right side has type int
   drivers/net/ethernet/intel/i40evf/i40evf_main.c:2655:59: sparse: invalid assignment: |=
   drivers/net/ethernet/intel/i40evf/i40evf_main.c:2655:59: left side has type restricted __be32
   drivers/net/ethernet/intel/i40evf/i40evf_main.c:2655:59: right side has type unsigned int
   drivers/net/ethernet/intel/i40evf/i40evf_main.c:2659:59: sparse: invalid assignment: |=
   drivers/net/ethernet/intel/i40evf/i40evf_main.c:2659:59: left side has type restricted __be32
   drivers/net/ethernet/intel/i40evf/i40evf_main.c:2659:59: right side has type unsigned int
   drivers/net/ethernet/intel/i40evf/i40evf_main.c:2695:67: sparse: invalid assignment: |=
   drivers/net/ethernet/intel/i40evf/i40evf_main.c:2695:67: left side has type restricted __be32
   drivers/net/ethernet/intel/i40evf/i40evf_main.c:2695:67: right side has type unsigned int
   drivers/net/ethernet/intel/i40evf/i40evf_main.c:2702:67: sparse: invalid assignment: |=
   drivers/net/ethernet/intel/i40evf/i40evf_main.c:2702:67: left side has type restricted __be32
   drivers/net/ethernet/intel/i40evf/i40evf_main.c:2702:67: right side has type unsigned int
   drivers/net/ethernet/intel/i40evf/i40evf_main.c:2738:58: sparse: invalid assignment: |=
   drivers/net/ethernet/intel/i40evf/i40evf_main.c:2738:58: left side has type restricted __be16
   drivers/net/ethernet/intel/i40evf/i40evf_main.c:2738:58: right side has type int
   drivers/net/ethernet/intel/i40evf/i40evf_main.c:2743:58: sparse: invalid assignment: |=
   drivers/net/ethernet/intel/i40evf/i40evf_main.c:2743:58: left side has type restricted __be16
   drivers/net/ethernet/intel/i40evf/i40evf_main.c:2743:58: right side has type int
--
>> drivers/net/ethernet/intel/i40evf/i40evf_virtchnl.c:1050:6: sparse: symbol 'i40evf_print_cloud_filter' was not declared. Should it be

Please review and possibly fold the followup patch.

vim +2607 drivers/net/ethernet/intel/i40evf/i40evf_main.c

  2461	
  2462	/**
  2463	 * i40evf_parse_cls_flower - Parse tc flower filters provided by kernel
  2464	 * @adapter: board private structure
  2465	 * @cls_flower: pointer to struct tc_cls_flower_offload
  2466	 * @filter: pointer to cloud filter structure
  2467	 */
  2468	static int i40evf_parse_cls_flower(struct i40evf_adapter *adapter,
  2469					   struct tc_cls_flower_offload *f,
  2470					   struct i40evf_cloud_filter *filter)
  2471	{
  2472		u16 n_proto_mask = 0;
  2473		u16 n_proto_key = 0;
  2474		u8 field_flags = 0;
  2475		u16 addr_type = 0;
  2476		u16 n_proto = 0;
  2477		int i = 0;
  2478	
  2479		if (f->dissector->used_keys &
  2480		    ~(BIT(FLOW_DISSECTOR_KEY_CONTROL) |
  2481		      BIT(FLOW_DISSECTOR_KEY_BASIC) |
  2482		      BIT(FLOW_DISSECTOR_KEY_ETH_ADDRS) |
  2483		      BIT(FLOW_DISSECTOR_KEY_VLAN) |
  2484		      BIT(FLOW_DISSECTOR_KEY_IPV4_ADDRS) |
  2485		      BIT(FLOW_DISSECTOR_KEY_IPV6_ADDRS) |
  2486		      BIT(FLOW_DISSECTOR_KEY_PORTS) |
  2487		      BIT(FLOW_DISSECTOR_KEY_ENC_KEYID))) {
  2488			dev_err(&adapter->pdev->dev, "Unsupported key used: 0x%x\n",
  2489				f->dissector->used_keys);
  2490			return -EOPNOTSUPP;
  2491		}
  2492	
  2493		if (dissector_uses_key(f->dissector, FLOW_DISSECTOR_KEY_ENC_KEYID)) {
  2494			struct flow_dissector_key_keyid *mask =
  2495				skb_flow_dissector_target(f->dissector,
  2496							  FLOW_DISSECTOR_KEY_ENC_KEYID,
  2497							  f->mask);
  2498	
  2499			if (mask->keyid != 0)
  2500				field_flags |= I40EVF_CLOUD_FIELD_TEN_ID;
  2501		}
  2502	
  2503		if (dissector_uses_key(f->dissector, FLOW_DISSECTOR_KEY_BASIC)) {
  2504			struct flow_dissector_key_basic *key =
  2505				skb_flow_dissector_target(f->dissector,
  2506							  FLOW_DISSECTOR_KEY_BASIC,
  2507							  f->key);
  2508	
  2509			struct flow_dissector_key_basic *mask =
  2510				skb_flow_dissector_target(f->dissector,
  2511							  FLOW_DISSECTOR_KEY_BASIC,
  2512							  f->mask);
  2513			n_proto_key = ntohs(key->n_proto);
  2514			n_proto_mask = ntohs(mask->n_proto);
  2515	
  2516			if (n_proto_key == ETH_P_ALL) {
  2517				n_proto_key = 0;
  2518				n_proto_mask = 0;
  2519			}
  2520			n_proto = n_proto_key & n_proto_mask;
  2521			if (n_proto != ETH_P_IP && n_proto != ETH_P_IPV6)
  2522				return -EINVAL;
  2523			if (n_proto == ETH_P_IPV6) {
  2524				/* specify flow type as TCP IPv6 */
  2525				filter->f.flow_type = VIRTCHNL_TCP_V6_FLOW;
  2526			}
  2527	
  2528			if (key->ip_proto != IPPROTO_TCP) {
  2529				dev_info(&adapter->pdev->dev, "Only TCP transport is supported\n");
  2530				return -EINVAL;
  2531			}
  2532		}
  2533	
  2534		if (dissector_uses_key(f->dissector, FLOW_DISSECTOR_KEY_ETH_ADDRS)) {
  2535			struct flow_dissector_key_eth_addrs *key =
  2536				skb_flow_dissector_target(f->dissector,
  2537							  FLOW_DISSECTOR_KEY_ETH_ADDRS,
  2538							  f->key);
  2539	
  2540			struct flow_dissector_key_eth_addrs *mask =
  2541				skb_flow_dissector_target(f->dissector,
  2542							  FLOW_DISSECTOR_KEY_ETH_ADDRS,
  2543							  f->mask);
  2544			/* use is_broadcast and is_zero to check for all 0xf or 0 */
  2545			if (!is_zero_ether_addr(mask->dst)) {
  2546				if (is_broadcast_ether_addr(mask->dst)) {
  2547					field_flags |= I40EVF_CLOUD_FIELD_OMAC;
  2548				} else {
  2549					dev_err(&adapter->pdev->dev, "Bad ether dest mask %pM\n",
  2550						mask->dst);
  2551					return I40E_ERR_CONFIG;
  2552				}
  2553			}
  2554	
  2555			if (!is_zero_ether_addr(mask->src)) {
  2556				if (is_broadcast_ether_addr(mask->src)) {
  2557					field_flags |= I40EVF_CLOUD_FIELD_IMAC;
  2558				} else {
  2559					dev_err(&adapter->pdev->dev, "Bad ether src mask %pM\n",
  2560						mask->src);
  2561					return I40E_ERR_CONFIG;
  2562				}
  2563			}
  2564	
  2565			if (!is_zero_ether_addr(key->dst))
  2566				if (is_valid_ether_addr(key->dst) ||
  2567				    is_multicast_ether_addr(key->dst)) {
  2568					/* set the mask if a valid dst_mac address */
  2569					for (i = 0; i < ETH_ALEN; i++)
  2570						filter->f.mask.tcp_spec.dst_mac[i] |=
  2571										0xff;
  2572					ether_addr_copy(filter->f.data.tcp_spec.dst_mac,
  2573							key->dst);
  2574				}
  2575	
  2576			if (!is_zero_ether_addr(key->src))
  2577				if (is_valid_ether_addr(key->src) ||
  2578				    is_multicast_ether_addr(key->src)) {
  2579					/* set the mask if a valid dst_mac address */
  2580					for (i = 0; i < ETH_ALEN; i++)
  2581						filter->f.mask.tcp_spec.src_mac[i] |=
  2582										0xff;
  2583					ether_addr_copy(filter->f.data.tcp_spec.src_mac,
  2584							key->src);
  2585			}
  2586		}
  2587	
  2588		if (dissector_uses_key(f->dissector, FLOW_DISSECTOR_KEY_VLAN)) {
  2589			struct flow_dissector_key_vlan *key =
  2590				skb_flow_dissector_target(f->dissector,
  2591							  FLOW_DISSECTOR_KEY_VLAN,
  2592							  f->key);
  2593			struct flow_dissector_key_vlan *mask =
  2594				skb_flow_dissector_target(f->dissector,
  2595							  FLOW_DISSECTOR_KEY_VLAN,
  2596							  f->mask);
  2597	
  2598			if (mask->vlan_id) {
  2599				if (mask->vlan_id == VLAN_VID_MASK) {
  2600					field_flags |= I40EVF_CLOUD_FIELD_IVLAN;
  2601				} else {
  2602					dev_err(&adapter->pdev->dev, "Bad vlan mask %u\n",
  2603						mask->vlan_id);
  2604					return I40E_ERR_CONFIG;
  2605				}
  2606			}
> 2607			filter->f.mask.tcp_spec.vlan_id |= 0xffff;
  2608			filter->f.data.tcp_spec.vlan_id = cpu_to_be16(key->vlan_id);
  2609		}
  2610	
  2611		if (dissector_uses_key(f->dissector, FLOW_DISSECTOR_KEY_CONTROL)) {
  2612			struct flow_dissector_key_control *key =
  2613				skb_flow_dissector_target(f->dissector,
  2614							  FLOW_DISSECTOR_KEY_CONTROL,
  2615							  f->key);
  2616	
  2617			addr_type = key->addr_type;
  2618		}
  2619	
  2620		if (addr_type == FLOW_DISSECTOR_KEY_IPV4_ADDRS) {
  2621			struct flow_dissector_key_ipv4_addrs *key =
  2622				skb_flow_dissector_target(f->dissector,
  2623							  FLOW_DISSECTOR_KEY_IPV4_ADDRS,
  2624							  f->key);
  2625			struct flow_dissector_key_ipv4_addrs *mask =
  2626				skb_flow_dissector_target(f->dissector,
  2627							  FLOW_DISSECTOR_KEY_IPV4_ADDRS,
  2628							  f->mask);
  2629	
  2630			if (mask->dst) {
  2631				if (mask->dst == cpu_to_be32(0xffffffff)) {
  2632					field_flags |= I40EVF_CLOUD_FIELD_IIP;
  2633				} else {
  2634					dev_err(&adapter->pdev->dev, "Bad ip dst mask 0x%08x\n",
  2635						be32_to_cpu(mask->dst));
  2636					return I40E_ERR_CONFIG;
  2637				}
  2638			}
  2639	
  2640			if (mask->src) {
  2641				if (mask->src == cpu_to_be32(0xffffffff)) {
  2642					field_flags |= I40EVF_CLOUD_FIELD_IIP;
  2643				} else {
  2644					dev_err(&adapter->pdev->dev, "Bad ip src mask 0x%08x\n",
  2645						be32_to_cpu(mask->dst));
  2646					return I40E_ERR_CONFIG;
  2647				}
  2648			}
  2649	
  2650			if (field_flags & I40EVF_CLOUD_FIELD_TEN_ID) {
  2651				dev_info(&adapter->pdev->dev, "Tenant id not allowed for ip filter\n");
  2652				return I40E_ERR_CONFIG;
  2653			}
  2654			if (key->dst) {
  2655				filter->f.mask.tcp_spec.dst_ip[0] |= 0xffffffff;
  2656				filter->f.data.tcp_spec.dst_ip[0] = key->dst;
  2657			}
  2658			if (key->src) {
  2659				filter->f.mask.tcp_spec.src_ip[0] |= 0xffffffff;
  2660				filter->f.data.tcp_spec.src_ip[0] = key->src;
  2661			}
  2662		}
  2663	
  2664		if (addr_type == FLOW_DISSECTOR_KEY_IPV6_ADDRS) {
  2665			struct flow_dissector_key_ipv6_addrs *key =
  2666				skb_flow_dissector_target(f->dissector,
  2667							  FLOW_DISSECTOR_KEY_IPV6_ADDRS,
  2668							  f->key);
  2669			struct flow_dissector_key_ipv6_addrs *mask =
  2670				skb_flow_dissector_target(f->dissector,
  2671							  FLOW_DISSECTOR_KEY_IPV6_ADDRS,
  2672							  f->mask);
  2673	
  2674			/* validate mask, make sure it is not IPV6_ADDR_ANY */
  2675			if (ipv6_addr_any(&mask->dst)) {
  2676				dev_err(&adapter->pdev->dev, "Bad ipv6 dst mask 0x%02x\n",
  2677					IPV6_ADDR_ANY);
  2678				return I40E_ERR_CONFIG;
  2679			}
  2680	
  2681			/* src and dest IPv6 address should not be LOOPBACK
  2682			 * (0:0:0:0:0:0:0:1) which can be represented as ::1
  2683			 */
  2684			if (ipv6_addr_loopback(&key->dst) ||
  2685			    ipv6_addr_loopback(&key->src)) {
  2686				dev_err(&adapter->pdev->dev,
  2687					"ipv6 addr should not be loopback\n");
  2688				return I40E_ERR_CONFIG;
  2689			}
  2690			if (!ipv6_addr_any(&mask->dst) || !ipv6_addr_any(&mask->src))
  2691				field_flags |= I40EVF_CLOUD_FIELD_IIP;
  2692	
  2693			if (key->dst.s6_addr) {
  2694				for (i = 0; i < 4; i++)
  2695					filter->f.mask.tcp_spec.dst_ip[i] |= 0xffffffff;
  2696				memcpy(&filter->f.data.tcp_spec.dst_ip,
  2697				       &key->dst.s6_addr32,
  2698				       sizeof(filter->f.data.tcp_spec.dst_ip));
  2699			}
  2700			if (key->src.s6_addr) {
  2701				for (i = 0; i < 4; i++)
  2702					filter->f.mask.tcp_spec.src_ip[i] |= 0xffffffff;
  2703				memcpy(&filter->f.data.tcp_spec.src_ip,
  2704				       &key->src.s6_addr32,
  2705				       sizeof(filter->f.data.tcp_spec.src_ip));
  2706			}
  2707		}
  2708		if (dissector_uses_key(f->dissector, FLOW_DISSECTOR_KEY_PORTS)) {
  2709			struct flow_dissector_key_ports *key =
  2710				skb_flow_dissector_target(f->dissector,
  2711							  FLOW_DISSECTOR_KEY_PORTS,
  2712							  f->key);
  2713			struct flow_dissector_key_ports *mask =
  2714				skb_flow_dissector_target(f->dissector,
  2715							  FLOW_DISSECTOR_KEY_PORTS,
  2716							  f->mask);
  2717	
  2718			if (mask->src) {
  2719				if (mask->src == cpu_to_be16(0xffff)) {
  2720					field_flags |= I40EVF_CLOUD_FIELD_IIP;
  2721				} else {
  2722					dev_err(&adapter->pdev->dev, "Bad src port mask %u\n",
  2723						be16_to_cpu(mask->src));
  2724					return I40E_ERR_CONFIG;
  2725				}
  2726			}
  2727	
  2728			if (mask->dst) {
  2729				if (mask->dst == cpu_to_be16(0xffff)) {
  2730					field_flags |= I40EVF_CLOUD_FIELD_IIP;
  2731				} else {
  2732					dev_err(&adapter->pdev->dev, "Bad dst port mask %u\n",
  2733						be16_to_cpu(mask->dst));
  2734					return I40E_ERR_CONFIG;
  2735				}
  2736			}
  2737			if (key->dst) {
  2738				filter->f.mask.tcp_spec.dst_port |= 0xffff;
  2739				filter->f.data.tcp_spec.dst_port = key->dst;
  2740			}
  2741	
  2742			if (key->src) {
  2743				filter->f.mask.tcp_spec.src_port |= 0xffff;
  2744				filter->f.data.tcp_spec.src_port = key->dst;
  2745			}
  2746		}
  2747		filter->f.field_flags = field_flags;
  2748	
  2749		return 0;
  2750	}
  2751	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
