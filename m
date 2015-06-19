From: Sullivan, Catherine <catherine.sullivan@intel.com>
Date: Fri, 19 Jun 2015 18:20:43 +0000
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 77/82]
 drivers/net/ethernet/intel/i40e/i40e_main.c:7531:18: error:
 'I40E_FLAG_RSS_AQ_CAPABLE' undeclared
In-Reply-To: <201506120821.2DPgoS7M%fengguang.wu@intel.com>
References: <201506120821.2DPgoS7M%fengguang.wu@intel.com>
Message-ID: <E8A77B2FB54C194393A5C2A8E3ED16782666BAB7@CRSMSX102.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

I cannot reproduce this error with the given config file. The tree has been rebased since the error was reported and I can no longer checkout the commit ID given but the version of the patch on the tree does not have this error.

> -----Original Message-----
> From: Wu, Fengguang
> Sent: Thursday, June 11, 2015 5:13 PM
> To: Singhai, Anjali
> Cc: kbuild-all at 01.org; Kirsher, Jeffrey T; Sullivan, Catherine; intel-wired-
> lan at lists.osuosl.org
> Subject: [jkirsher-next-queue:dev-queue 77/82]
> drivers/net/ethernet/intel/i40e/i40e_main.c:7531:18: error:
> 'I40E_FLAG_RSS_AQ_CAPABLE' undeclared
> 
> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git
> dev-queue
> head:   a77608e2c8d74ca16cf2738a9d2e9d90f9499c24
> commit: d717a16412b72ccddf5d0597cfe0fb6c492624c4 [77/82] i40e/i40evf:
> RSS changes for X722
> config: i386-randconfig-r0-201523 (attached as .config)
> reproduce:
>   git checkout d717a16412b72ccddf5d0597cfe0fb6c492624c4
>   # save the attached .config to linux build tree
>   make ARCH=i386
> 
> All error/warnings (new ones prefixed by >>):
> 
>    In file included from include/linux/list.h:8:0,
>                     from include/net/tcp.h:23,
>                     from drivers/net/ethernet/intel/i40e/i40e.h:30,
>                     from drivers/net/ethernet/intel/i40e/i40e_main.c:28:
>    drivers/net/ethernet/intel/i40e/i40e_main.c: In function
> 'i40e_vsi_setup_queue_map':
>    drivers/net/ethernet/intel/i40e/i40e.h:88:19: error:
> 'I40E_FLAG_128_QP_RSS_CAPABLE' undeclared (first use in this function)
>       (((pf)->flags & I40E_FLAG_128_QP_RSS_CAPABLE) ? 128 : 64)
>                       ^
>    include/linux/kernel.h:764:17: note: in definition of macro 'min_t'
>      type __min2 = (y);   \
>                     ^
>    drivers/net/ethernet/intel/i40e/i40e_main.c:1553:38: note: in expansion of
> macro 'i40e_pf_get_max_q_per_tc'
>      num_tc_qps = min_t(int, num_tc_qps, i40e_pf_get_max_q_per_tc(pf));
>                                          ^
>    drivers/net/ethernet/intel/i40e/i40e.h:88:19: note: each undeclared identifier
> is reported only once for each function it appears in
>       (((pf)->flags & I40E_FLAG_128_QP_RSS_CAPABLE) ? 128 : 64)
>                       ^
>    include/linux/kernel.h:764:17: note: in definition of macro 'min_t'
>      type __min2 = (y);   \
>                     ^
>    drivers/net/ethernet/intel/i40e/i40e_main.c:1553:38: note: in expansion of
> macro 'i40e_pf_get_max_q_per_tc'
>      num_tc_qps = min_t(int, num_tc_qps, i40e_pf_get_max_q_per_tc(pf));
>                                          ^
>    drivers/net/ethernet/intel/i40e/i40e_main.c: In function
> 'i40e_vsi_config_rss':
> >> drivers/net/ethernet/intel/i40e/i40e_main.c:7531:18: error:
> 'I40E_FLAG_RSS_AQ_CAPABLE' undeclared (first use in this function)
>      if (pf->flags & I40E_FLAG_RSS_AQ_CAPABLE)
>                      ^
>    In file included from drivers/net/ethernet/intel/i40e/i40e.h:64:0,
>                     from drivers/net/ethernet/intel/i40e/i40e_main.c:28:
>    drivers/net/ethernet/intel/i40e/i40e_main.c: In function 'i40e_config_rss':
>    drivers/net/ethernet/intel/i40e/i40e_txrx.h:90:18: error:
> 'I40E_FLAG_MULTIPLE_TCP_UDP_RSS_PCTYPE' undeclared (first use in this
> function)
>      (((pf)->flags & I40E_FLAG_MULTIPLE_TCP_UDP_RSS_PCTYPE) ? \
>                      ^
>    drivers/net/ethernet/intel/i40e/i40e_main.c:7587:10: note: in expansion of
> macro 'i40e_pf_get_default_rss_hena'
>      hena |= i40e_pf_get_default_rss_hena(pf);
>              ^
> >> drivers/net/ethernet/intel/i40e/i40e_main.c:7587:2: warning: left shift
> count >= width of type
>      hena |= i40e_pf_get_default_rss_hena(pf);
>      ^
> >> drivers/net/ethernet/intel/i40e/i40e_main.c:7587:2: warning: left shift
> count >= width of type
> >> drivers/net/ethernet/intel/i40e/i40e_main.c:7587:2: warning: left shift
> count >= width of type
> >> drivers/net/ethernet/intel/i40e/i40e_main.c:7587:2: warning: left shift
> count >= width of type
>    drivers/net/ethernet/intel/i40e/i40e_main.c:7601:18: error:
> 'I40E_FLAG_RSS_AQ_CAPABLE' undeclared (first use in this function)
>      if (pf->flags & I40E_FLAG_RSS_AQ_CAPABLE)
>                      ^
>    drivers/net/ethernet/intel/i40e/i40e_main.c: In function 'i40e_vsi_setup':
>    drivers/net/ethernet/intel/i40e/i40e_main.c:9019:19: error:
> 'I40E_FLAG_RSS_AQ_CAPABLE' undeclared (first use in this function)
>      if ((pf->flags & I40E_FLAG_RSS_AQ_CAPABLE) &&
>                       ^
>    drivers/net/ethernet/intel/i40e/i40e_main.c: In function 'i40e_config_rss':
>    drivers/net/ethernet/intel/i40e/i40e_main.c:7605:1: warning: control reaches
> end of non-void function [-Wreturn-type]
>     }
>     ^
> --
>    drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c: In function
> 'i40e_vc_get_vf_resources_msg':
> >> drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c:1181:18: error:
> 'I40E_FLAG_RSS_AQ_CAPABLE' undeclared (first use in this function)
>      if (pf->flags & I40E_FLAG_RSS_AQ_CAPABLE) {
>                      ^
>    drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c:1181:18: note: each
> undeclared identifier is reported only once for each function it appears in
> 
> vim +/I40E_FLAG_RSS_AQ_CAPABLE +7531
> drivers/net/ethernet/intel/i40e/i40e_main.c
> 
>   7525		u8 seed[I40E_HKEY_ARRAY_SIZE];
>   7526		struct i40e_pf *pf = vsi->back;
>   7527
>   7528		netdev_rss_key_fill((void *)seed, I40E_HKEY_ARRAY_SIZE);
>   7529		vsi->rss_size = min_t(int, pf->rss_size, vsi->num_queue_pairs);
>   7530
> > 7531		if (pf->flags & I40E_FLAG_RSS_AQ_CAPABLE)
>   7532			return i40e_config_rss_aq(vsi, seed);
>   7533
>   7534		return 0;
>   7535	}
>   7536
>   7537	/**
>   7538	 * i40e_config_rss_reg - Prepare for RSS if used
>   7539	 * @pf: board private structure
>   7540	 * @seed: RSS hash seed
>   7541	 **/
>   7542	static int i40e_config_rss_reg(struct i40e_pf *pf, const u8 *seed)
>   7543	{
>   7544		struct i40e_vsi *vsi = pf->vsi[pf->lan_vsi];
>   7545		struct i40e_hw *hw = &pf->hw;
>   7546		u32 *seed_dw = (u32 *)seed;
>   7547		u32 current_queue = 0;
>   7548		u32 lut = 0;
>   7549		int i, j;
>   7550
>   7551		/* Fill out hash function seed */
>   7552		for (i = 0; i <= I40E_PFQF_HKEY_MAX_INDEX; i++)
>   7553			wr32(hw, I40E_PFQF_HKEY(i), seed_dw[i]);
>   7554
>   7555		for (i = 0; i <= I40E_PFQF_HLUT_MAX_INDEX; i++) {
>   7556			lut = 0;
>   7557			for (j = 0; j < 4; j++) {
>   7558				if (current_queue == vsi->rss_size)
>   7559					current_queue = 0;
>   7560				lut |= ((current_queue) << (8 * j));
>   7561				current_queue++;
>   7562			}
>   7563			wr32(&pf->hw, I40E_PFQF_HLUT(i), lut);
>   7564		}
>   7565		i40e_flush(hw);
>   7566
>   7567		return 0;
>   7568	}
>   7569
>   7570	/**
>   7571	 * i40e_config_rss - Prepare for RSS if used
>   7572	 * @pf: board private structure
>   7573	 **/
>   7574	static int i40e_config_rss(struct i40e_pf *pf)
>   7575	{
>   7576		struct i40e_vsi *vsi = pf->vsi[pf->lan_vsi];
>   7577		u8 seed[I40E_HKEY_ARRAY_SIZE];
>   7578		struct i40e_hw *hw = &pf->hw;
>   7579		u32 reg_val;
>   7580		u64 hena;
>   7581
>   7582		netdev_rss_key_fill((void *)seed, I40E_HKEY_ARRAY_SIZE);
>   7583
>   7584		/* By default we enable TCP/UDP with IPv4/IPv6 ptypes */
>   7585		hena = (u64)rd32(hw, I40E_PFQF_HENA(0)) |
>   7586			((u64)rd32(hw, I40E_PFQF_HENA(1)) << 32);
> > 7587		hena |= i40e_pf_get_default_rss_hena(pf);
>   7588
>   7589		wr32(hw, I40E_PFQF_HENA(0), (u32)hena);
>   7590		wr32(hw, I40E_PFQF_HENA(1), (u32)(hena >> 32));
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> http://lists.01.org/mailman/listinfo/kbuild                 Intel Corporation
