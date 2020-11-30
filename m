From: Gong, Sishuai <sishuai@purdue.edu>
Date: Mon, 30 Nov 2020 17:43:09 +0000
Subject: [Intel-wired-lan] Race: data race between packet_getname() and
 e1000_set_mac()
Message-ID: <397ACEA3-ABA1-4F59-A3D3-BE54F273B247@purdue.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,

We found a data race in linux kernel 5.3.11 that we are able to reproduce in x86 under specific interleavings. Currently, we are not sure about the consequence of this race so we would like to confirm with the community if this can be a harmful bug.

 ------------------------------------------
Writer site

/tmp/tmp.B7zb7od2zE-5.3.11/extract/linux-5.3.11/drivers/net/ethernet/intel/e1000/e1000_main.c:2206
       2186   * e1000_set_mac - Change the Ethernet Address of the NIC
       2187   * @netdev: network interface device structure
       2188   * @p: pointer to an address structure
       2189   *
       2190   * Returns 0 on success, negative on failure
       2191   **/
       2192  static int e1000_set_mac(struct net_device *netdev, void *p)
       2193  {
       2194      struct e1000_adapter *adapter = netdev_priv(netdev);
       2195      struct e1000_hw *hw = &adapter->hw;
       2196      struct sockaddr *addr = p;
       2197
       2198      if (!is_valid_ether_addr(addr->sa_data))
       2199          return -EADDRNOTAVAIL;
       2200
       2201      /* 82542 2.0 needs to be in reset to write receive address registers */
       2202
       2203      if (hw->mac_type == e1000_82542_rev2_0)
       2204          e1000_enter_82542_rst(adapter);
       2205
 ==>   2206      memcpy(netdev->dev_addr, addr->sa_data, netdev->addr_len);
       2207      memcpy(hw->mac_addr, addr->sa_data, netdev->addr_len);
       2208
       2209      e1000_rar_set(hw, hw->mac_addr, 0);
       2210
       2211      if (hw->mac_type == e1000_82542_rev2_0)
       2212          e1000_leave_82542_rst(adapter);
       2213
       2214      return 0;
       2215  }

------------------------------------------
Reader site

 /tmp/tmp.B7zb7od2zE-5.3.11/extract/linux-5.3.11/net/packet/af_packet.c:3477
       3457  static int packet_getname(struct socket *sock, struct sockaddr *uaddr,
       3458                int peer)
       3459  {
       3460      struct net_device *dev;
       3461      struct sock *sk = sock->sk;
       3462      struct packet_sock *po = pkt_sk(sk);
       3463      DECLARE_SOCKADDR(struct sockaddr_ll *, sll, uaddr);
       3464
       3465      if (peer)
       3466          return -EOPNOTSUPP;
       3467
       3468      sll->sll_family = AF_PACKET;
       3469      sll->sll_ifindex = po->ifindex;
       3470      sll->sll_protocol = po->num;
       3471      sll->sll_pkttype = 0;
       3472      rcu_read_lock();
       3473      dev = dev_get_by_index_rcu(sock_net(sk), po->ifindex);
       3474      if (dev) {
       3475          sll->sll_hatype = dev->type;
       3476          sll->sll_halen = dev->addr_len;
 ==>   3477          memcpy(sll->sll_addr, dev->dev_addr, dev->addr_len);
       3478      } else {
       3479          sll->sll_hatype = 0;    /* Bad: we have no ARPHRD_UNSPEC */
       3480          sll->sll_halen = 0;
       3481      }
       3482      rcu_read_unlock();
       3483
       3484      return offsetof(struct sockaddr_ll, sll_addr) + sll->sll_halen;
       3485  }



------------------------------------------
Writer calling trace
- __sys_sendmsg
-- ___sys_sendmsg
--- sock_sendmsg
---- netlink_unicast
----- netlink_rcv_skb 
------ __rtnl_newlink
------- do_setlink
-------- dev_set_mac_address

------------------------------------------
Reader calling trace
- __sys_getsockname



Thanks,
Sishuai

