From: Sullivan, Catherine <catherine.sullivan@intel.com>
Date: Fri, 19 Jun 2015 18:20:23 +0000
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 78/82]
 drivers/net/ethernet/intel/i40e/i40e_main.c:7074:26: error:
 'I40E_FLAG_WB_ON_ITR_CAPABLE' undeclared
In-Reply-To: <201506120821.ueX7VOkY%fengguang.wu@intel.com>
References: <201506120821.ueX7VOkY%fengguang.wu@intel.com>
Message-ID: <E8A77B2FB54C194393A5C2A8E3ED16782666BAA5@CRSMSX102.amr.corp.intel.com>
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
> Subject: [jkirsher-next-queue:dev-queue 78/82]
> drivers/net/ethernet/intel/i40e/i40e_main.c:7074:26: error:
> 'I40E_FLAG_WB_ON_ITR_CAPABLE' undeclared
> 
> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git
> dev-queue
> head:   a77608e2c8d74ca16cf2738a9d2e9d90f9499c24
> commit: 13bd4df5d990e9f87e6ea96a61331c92fb8a6b0f [78/82] i40e/i40evf:
> Add support for writeback on ITR feature for X722
> config: i386-randconfig-r0-201523 (attached as .config)
> reproduce:
>   git checkout 13bd4df5d990e9f87e6ea96a61331c92fb8a6b0f
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
>    drivers/net/ethernet/intel/i40e/i40e_main.c: In function 'i40e_alloc_rings':
> >> drivers/net/ethernet/intel/i40e/i40e_main.c:7074:26: error:
> 'I40E_FLAG_WB_ON_ITR_CAPABLE' undeclared (first use in this function)
>       if (vsi->back->flags & I40E_FLAG_WB_ON_ITR_CAPABLE)
>                              ^
>    drivers/net/ethernet/intel/i40e/i40e_main.c: In function
> 'i40e_vsi_config_rss':
>    drivers/net/ethernet/intel/i40e/i40e_main.c:7533:18: error:
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
>    drivers/net/ethernet/intel/i40e/i40e_main.c:7589:10: note: in expansion of
> macro 'i40e_pf_get_default_rss_hena'
>      hena |= i40e_pf_get_default_rss_hena(pf);
>              ^
>    drivers/net/ethernet/intel/i40e/i40e_main.c:7589:2: warning: left shift count
> >= width of type
>      hena |= i40e_pf_get_default_rss_hena(pf);
>      ^
>    drivers/net/ethernet/intel/i40e/i40e_main.c:7589:2: warning: left shift count
> >= width of type
>    drivers/net/ethernet/intel/i40e/i40e_main.c:7589:2: warning: left shift count
> >= width of type
>    drivers/net/ethernet/intel/i40e/i40e_main.c:7589:2: warning: left shift count
> >= width of type
>    drivers/net/ethernet/intel/i40e/i40e_main.c:7603:18: error:
> 'I40E_FLAG_RSS_AQ_CAPABLE' undeclared (first use in this function)
>      if (pf->flags & I40E_FLAG_RSS_AQ_CAPABLE)
>                      ^
>    drivers/net/ethernet/intel/i40e/i40e_main.c: In function 'i40e_vsi_setup':
>    drivers/net/ethernet/intel/i40e/i40e_main.c:9021:19: error:
> 'I40E_FLAG_RSS_AQ_CAPABLE' undeclared (first use in this function)
>      if ((pf->flags & I40E_FLAG_RSS_AQ_CAPABLE) &&
>                       ^
>    drivers/net/ethernet/intel/i40e/i40e_main.c: In function 'i40e_config_rss':
>    drivers/net/ethernet/intel/i40e/i40e_main.c:7607:1: warning: control reaches
> end of non-void function [-Wreturn-type]
>     }
>     ^
> 
> vim +/I40E_FLAG_WB_ON_ITR_CAPABLE +7074
> drivers/net/ethernet/intel/i40e/i40e_main.c
> 
>   7068			tx_ring->vsi = vsi;
>   7069			tx_ring->netdev = vsi->netdev;
>   7070			tx_ring->dev = &pf->pdev->dev;
>   7071			tx_ring->count = vsi->num_desc;
>   7072			tx_ring->size = 0;
>   7073			tx_ring->dcb_tc = 0;
> > 7074			if (vsi->back->flags &
> I40E_FLAG_WB_ON_ITR_CAPABLE)
>   7075				tx_ring->flags =
> I40E_TXR_FLAGS_WB_ON_ITR;
>   7076			vsi->tx_rings[i] = tx_ring;
>   7077
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> http://lists.01.org/mailman/listinfo/kbuild                 Intel Corporation
