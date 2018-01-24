From: Ramamurthy, Harshitha <harshitha.ramamurthy@intel.com>
Date: Wed, 24 Jan 2018 20:22:25 +0000
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 71/89]
 drivers/net/ethernet/intel/i40evf/i40evf_main.c:1050:2-3: ERROR: invalid
 reference to the index variable of the iterator on line 1045 (fwd)
In-Reply-To: <alpine.DEB.2.20.1801242116010.3143@hadrien>
References: <alpine.DEB.2.20.1801242116010.3143@hadrien>
Message-ID: <056F69014252804A8B8B74A3BC329E82EC6468@ORSMSX109.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Yes, thanks for pointing that out. Will send a patch to fix it.

-Harshitha

-----Original Message-----
From: Julia Lawall [mailto:julia.lawall at lip6.fr] 
Sent: Wednesday, January 24, 2018 12:17 PM
To: Ramamurthy, Harshitha <harshitha.ramamurthy@intel.com>
Cc: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; intel-wired-lan at lists.osuosl.org; kbuild-all at 01.org
Subject: [jkirsher-next-queue:dev-queue 71/89] drivers/net/ethernet/intel/i40evf/i40evf_main.c:1050:2-3: ERROR: invalid reference to the index variable of the iterator on line 1045 (fwd)

Line 1050 should be referring to vlf, not f.

julia

---------- Forwarded message ----------
Date: Thu, 25 Jan 2018 02:47:32 +0800
From: kbuild test robot <fengguang.wu@intel.com>
To: kbuild@01.org
Cc: Julia Lawall <julia.lawall@lip6.fr>
Subject: [jkirsher-next-queue:dev-queue 71/89]
    drivers/net/ethernet/intel/i40evf/i40evf_main.c:1050:2-3: ERROR: invalid
    reference to the index variable of the iterator on line 1045


tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   6cf71fc56874cb7823f678ebeadfc0ede9acc497
commit: 84850cd3f0fc142348783d012ee2e34ffa6b5d0e [71/89] i40evf: Use an iterator of the same type as the list
:::::: branch date: 3 hours ago
:::::: commit date: 3 hours ago

>> drivers/net/ethernet/intel/i40evf/i40evf_main.c:1050:2-3: ERROR: invalid reference to the index variable of the iterator on line 1045

# https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git/commit/?id=84850cd3f0fc142348783d012ee2e34ffa6b5d0e
git remote add jkirsher-next-queue https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git
git remote update jkirsher-next-queue
git checkout 84850cd3f0fc142348783d012ee2e34ffa6b5d0e
vim +1050 drivers/net/ethernet/intel/i40evf/i40evf_main.c

5eae00c5 Greg Rose             2013-12-21  1020
5eae00c5 Greg Rose             2013-12-21  1021  /**
5eae00c5 Greg Rose             2013-12-21  1022   * i40e_down - Shutdown the connection processing
5eae00c5 Greg Rose             2013-12-21  1023   * @adapter: board private structure
9b2aef12 Jacob Keller          2017-10-27  1024   *
9b2aef12 Jacob Keller          2017-10-27  1025   * Expects to be called while holding the __I40EVF_IN_CRITICAL_TASK bit lock.
5eae00c5 Greg Rose             2013-12-21  1026   **/
5eae00c5 Greg Rose             2013-12-21  1027  void i40evf_down(struct i40evf_adapter *adapter)
5eae00c5 Greg Rose             2013-12-21  1028  {
5eae00c5 Greg Rose             2013-12-21  1029  	struct net_device *netdev = adapter->netdev;
84850cd3 Harshitha Ramamurthy  2018-01-24  1030  	struct i40evf_vlan_filter *vlf;
5eae00c5 Greg Rose             2013-12-21  1031  	struct i40evf_mac_filter *f;
5eae00c5 Greg Rose             2013-12-21  1032
209dc4da Mitch Williams        2015-12-09  1033  	if (adapter->state <= __I40EVF_DOWN_PENDING)
ddf0b3a6 Mitch Williams        2014-05-22  1034  		return;
ddf0b3a6 Mitch Williams        2014-05-22  1035
63e18c25 Mitch Williams        2015-03-27  1036  	netif_carrier_off(netdev);
63e18c25 Mitch Williams        2015-03-27  1037  	netif_tx_disable(netdev);
3f341acc Sridhar Samudrala     2016-09-01  1038  	adapter->link_up = false;
748c434b Mitch Williams        2015-01-29  1039  	i40evf_napi_disable_all(adapter);
63e18c25 Mitch Williams        2015-03-27  1040  	i40evf_irq_disable(adapter);
53d0b3ae Mitch A Williams      2014-12-09  1041
504398f0 Jacob Keller          2017-10-27  1042  	spin_lock_bh(&adapter->mac_vlan_list_lock);
504398f0 Jacob Keller          2017-10-27  1043
ef8693eb Mitch Williams        2014-02-13  1044  	/* remove all MAC filters */
5eae00c5 Greg Rose             2013-12-21 @1045  	list_for_each_entry(f, &adapter->mac_filter_list, list) {
5eae00c5 Greg Rose             2013-12-21  1046  		f->remove = true;
5eae00c5 Greg Rose             2013-12-21  1047  	}
ed1f5b58 Mitch Williams        2014-02-20  1048  	/* remove all VLAN filters */
84850cd3 Harshitha Ramamurthy  2018-01-24  1049  	list_for_each_entry(vlf, &adapter->vlan_filter_list, list) {
ed1f5b58 Mitch Williams        2014-02-20 @1050  		f->remove = true;
ed1f5b58 Mitch Williams        2014-02-20  1051  	}
504398f0 Jacob Keller          2017-10-27  1052
504398f0 Jacob Keller          2017-10-27  1053  	spin_unlock_bh(&adapter->mac_vlan_list_lock);
504398f0 Jacob Keller          2017-10-27  1054
ef8693eb Mitch Williams        2014-02-13  1055  	if (!(adapter->flags & I40EVF_FLAG_PF_COMMS_FAILED) &&
ef8693eb Mitch Williams        2014-02-13  1056  	    adapter->state != __I40EVF_RESETTING) {
53d0b3ae Mitch A Williams      2014-12-09  1057  		/* cancel any current operation */
310a2ad9 Jesse Brandeburg      2017-05-11  1058  		adapter->current_op = VIRTCHNL_OP_UNKNOWN;
53d0b3ae Mitch A Williams      2014-12-09  1059  		/* Schedule operations to close down the HW. Don't wait
53d0b3ae Mitch A Williams      2014-12-09  1060  		 * here for this to complete. The watchdog is still running
53d0b3ae Mitch A Williams      2014-12-09  1061  		 * and it will take care of this.
53d0b3ae Mitch A Williams      2014-12-09  1062  		 */
53d0b3ae Mitch A Williams      2014-12-09  1063  		adapter->aq_required = I40EVF_FLAG_AQ_DEL_MAC_FILTER;
ed1f5b58 Mitch Williams        2014-02-20  1064  		adapter->aq_required |= I40EVF_FLAG_AQ_DEL_VLAN_FILTER;
5eae00c5 Greg Rose             2013-12-21  1065  		adapter->aq_required |= I40EVF_FLAG_AQ_DISABLE_QUEUES;
ef8693eb Mitch Williams        2014-02-13  1066  	}
5eae00c5 Greg Rose             2013-12-21  1067
fe2647ab Sudheer Mogilappagari 2017-06-23  1068  	mod_timer_pending(&adapter->watchdog_timer, jiffies + 1);
5eae00c5 Greg Rose             2013-12-21  1069  }
5eae00c5 Greg Rose             2013-12-21  1070

:::::: The code at line 1050 was first introduced by commit
:::::: ed1f5b58ea01757c5878ecff762e884767da9bab i40evf: remove VLAN filters on close

:::::: TO: Mitch Williams <mitch.a.williams@intel.com>
:::::: CC: David S. Miller <davem@davemloft.net>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
