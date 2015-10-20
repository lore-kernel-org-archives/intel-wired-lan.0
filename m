From: kbuild test robot <lkp@intel.com>
Date: Wed, 21 Oct 2015 04:14:00 +0800
Subject: [Intel-wired-lan] [net PATCH] ixgbe: Reset interface after
	enabling SR-IOV
In-Reply-To: <20151020195738.1495.80824.stgit@ahduyck-vm-fedora22>
Message-ID: <201510210405.uOjazBto%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Alexander,

[auto build test WARNING on net/master -- if it's inappropriate base, please suggest rules for selecting the more suitable base]

url:    https://github.com/0day-ci/linux/commits/Alexander-Duyck/ixgbe-Reset-interface-after-enabling-SR-IOV/20151021-040132
config: x86_64-randconfig-x011-201542 (attached as .config)
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c: In function 'ixgbe_setup_tc':
>> drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:7879:15: warning: passing argument 1 of 'ixgbe_reset' from incompatible pointer type [-Wincompatible-pointer-types]
      ixgbe_reset(dev);
                  ^
   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:4994:6: note: expected 'struct ixgbe_adapter *' but argument is of type 'struct net_device *'
    void ixgbe_reset(struct ixgbe_adapter *adapter)
         ^

vim +/ixgbe_reset +7879 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c

  7863			return -EINVAL;
  7864	
  7865		if (hw->mac.type == ixgbe_mac_82598EB && tc && tc < MAX_TRAFFIC_CLASS)
  7866			return -EINVAL;
  7867	
  7868		pools = (find_first_zero_bit(&adapter->fwd_bitmask, 32) > 1);
  7869		if (tc && pools && adapter->num_rx_pools > IXGBE_MAX_DCBMACVLANS)
  7870			return -EBUSY;
  7871	
  7872		/* Hardware has to reinitialize queues and interrupts to
  7873		 * match packet buffer alignment. Unfortunately, the
  7874		 * hardware is not flexible enough to do this dynamically.
  7875		 */
  7876		if (netif_running(dev))
  7877			ixgbe_close(dev);
  7878		else
> 7879			ixgbe_reset(dev);
  7880	
  7881		ixgbe_clear_interrupt_scheme(adapter);
  7882	
  7883	#ifdef CONFIG_IXGBE_DCB
  7884		if (tc) {
  7885			netdev_set_num_tc(dev, tc);
  7886			ixgbe_set_prio_tc_map(adapter);
  7887	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 28647 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20151021/ce851841/attachment-0001.obj>
