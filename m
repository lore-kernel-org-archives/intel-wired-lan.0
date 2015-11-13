From: kbuild test robot <fengguang.wu@intel.com>
Date: Sat, 14 Nov 2015 06:13:30 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 159/160]
 drivers/net/ethernet/intel/i40e/i40e_main.c:8486:44: error:
 'UDP_TUNNEL_GENEVE' undeclared
Message-ID: <201511140618.wqkGfGOT%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   7c2cae61768b0da68519e4c45a86aafab84dda28
commit: 114cf62d6a97359dac112f2571a5ffe03ec32a56 [159/160] i40e:Add geneve tunnel offload support
config: x86_64-rhel (attached as .config)
reproduce:
        git checkout 114cf62d6a97359dac112f2571a5ffe03ec32a56
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   drivers/net/ethernet/intel/i40e/i40e_main.c: In function 'i40e_service_task':
   drivers/net/ethernet/intel/i40e/i40e_main.c:7069:2: error: implicit declaration of function 'i40e_sync_udp_filters_subtask' [-Werror=implicit-function-declaration]
     i40e_sync_udp_filters_subtask(pf);
     ^
   drivers/net/ethernet/intel/i40e/i40e_main.c: In function 'i40e_add_tunnel_port':
   drivers/net/ethernet/intel/i40e/i40e_main.c:8486:16: error: 'UDP_TUNNEL_VXLAN' undeclared (first use in this function)
     if (!(type == UDP_TUNNEL_VXLAN || type == UDP_TUNNEL_GENEVE))
                   ^
   drivers/net/ethernet/intel/i40e/i40e_main.c:8486:16: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/net/ethernet/intel/i40e/i40e_main.c:8486:44: error: 'UDP_TUNNEL_GENEVE' undeclared (first use in this function)
     if (!(type == UDP_TUNNEL_VXLAN || type == UDP_TUNNEL_GENEVE))
                                               ^
   drivers/net/ethernet/intel/i40e/i40e_main.c: In function 'i40e_del_tunnel_port':
   drivers/net/ethernet/intel/i40e/i40e_main.c:8553:16: error: 'UDP_TUNNEL_VXLAN' undeclared (first use in this function)
     if (!(type == UDP_TUNNEL_VXLAN || type == UDP_TUNNEL_GENEVE))
                   ^
   drivers/net/ethernet/intel/i40e/i40e_main.c:8553:44: error: 'UDP_TUNNEL_GENEVE' undeclared (first use in this function)
     if (!(type == UDP_TUNNEL_VXLAN || type == UDP_TUNNEL_GENEVE))
                                               ^
   drivers/net/ethernet/intel/i40e/i40e_main.c: At top level:
>> drivers/net/ethernet/intel/i40e/i40e_main.c:8579:2: error: #endif without #if
    #endif
     ^
   cc1: some warnings being treated as errors

vim +/UDP_TUNNEL_GENEVE +8486 drivers/net/ethernet/intel/i40e/i40e_main.c

  8480		struct i40e_netdev_priv *np = netdev_priv(netdev);
  8481		struct i40e_vsi *vsi = np->vsi;
  8482		struct i40e_pf *pf = vsi->back;
  8483		u8 next_idx;
  8484		u8 idx;
  8485	
> 8486		if (!(type == UDP_TUNNEL_VXLAN || type == UDP_TUNNEL_GENEVE))
  8487			goto out;
  8488	
  8489		if ((type == UDP_TUNNEL_GENEVE) &&
  8490		    (!(pf->flags & I40E_FLAG_GENEVE_OFFLOAD_CAPABLE)))
  8491			goto out;
  8492	
  8493		if (sa_family == AF_INET6)
  8494			goto out;
  8495	
  8496		spin_lock(&pf->udp_tunnel_lock);
  8497		idx = i40e_get_udp_port_idx(pf, port);
  8498	
  8499		/* Check if port already exists */
  8500		if (idx < I40E_MAX_PF_UDP_OFFLOAD_PORTS) {
  8501			netdev_info(netdev, "UDP port %d already offloaded\n",
  8502				    ntohs(port));
  8503			goto err;
  8504		}
  8505	
  8506		/* Now check if there is space to add the new port */
  8507		next_idx = i40e_get_udp_port_idx(pf, 0);
  8508	
  8509		if (next_idx == I40E_MAX_PF_UDP_OFFLOAD_PORTS) {
  8510			netdev_info(netdev, "maximum number of UDP ports reached, not adding port %d\n",
  8511				    ntohs(port));
  8512			goto err;
  8513		}
  8514	
  8515		/* New port: add it and mark its index in the bitmap */
  8516		pf->udp_ports[next_idx].index = port;
  8517		if (type == UDP_TUNNEL_VXLAN)
  8518			pf->udp_ports[next_idx].type = I40E_AQC_TUNNEL_TYPE_VXLAN;
  8519		else if (type == UDP_TUNNEL_GENEVE)
  8520			pf->udp_ports[next_idx].type = I40E_AQC_TUNNEL_TYPE_NGE;
  8521	
  8522		pf->pending_udp_bitmap |= BIT_ULL(next_idx);
  8523		pf->flags |= I40E_FLAG_UDP_FILTER_SYNC;
  8524	
  8525	err:
  8526		spin_unlock(&pf->udp_tunnel_lock);
  8527	out:
  8528		return;
  8529	
  8530	#endif
  8531	}
  8532	
  8533	/**
  8534	 * i40e_del_tunnel_port - Get notifications about UDP tunnel ports that go away
  8535	 * @netdev: This physical port's netdev
  8536	 * @sa_family: Socket Family that tunnel netdev is associated with
  8537	 * @port: UDP port number that tunnel stopped listening to
  8538	 * @type: Tunnel Type
  8539	 *
  8540	 * This function modifies a common data structure for all udp_tunnels
  8541	 * hence it is expected that it is called under common lock.
  8542	 **/
  8543	static void i40e_del_tunnel_port(struct net_device *netdev,
  8544					 sa_family_t sa_family, __be16 port,
  8545					 u32 type)
  8546	{
  8547	#if IS_ENABLED(CONFIG_VXLAN) || IS_ENABLED(CONFIG_GENEVE)
  8548		struct i40e_netdev_priv *np = netdev_priv(netdev);
  8549		struct i40e_vsi *vsi = np->vsi;
  8550		struct i40e_pf *pf = vsi->back;
  8551		u8 idx;
  8552	
> 8553		if (!(type == UDP_TUNNEL_VXLAN || type == UDP_TUNNEL_GENEVE))
  8554			return;
  8555	
  8556		if (sa_family == AF_INET6)
  8557			return;
  8558	
  8559		spin_lock(&pf->udp_tunnel_lock);
  8560	
  8561		idx = i40e_get_udp_port_idx(pf, port);
  8562	
  8563		/* Check if port already exists */
  8564		if (idx < I40E_MAX_PF_UDP_OFFLOAD_PORTS) {
  8565			/* if port exists, set it to 0 (mark for deletion)
  8566			 * and make it pending
  8567			 */
  8568			pf->udp_ports[idx].index = 0;
  8569			pf->pending_udp_bitmap |= BIT_ULL(idx);
  8570			pf->flags |= I40E_FLAG_UDP_FILTER_SYNC;
  8571		} else {
  8572			netdev_warn(netdev, "udp tunnel port %d was not found, not deleting\n",
  8573				    ntohs(port));
  8574		}
  8575		spin_unlock(&pf->udp_tunnel_lock);
  8576	#endif
  8577	}
  8578	
> 8579	#endif
  8580	static int i40e_get_phys_port_id(struct net_device *netdev,
  8581					 struct netdev_phys_item_id *ppid)
  8582	{

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 35613 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20151114/fb137c19/attachment-0001.obj>
