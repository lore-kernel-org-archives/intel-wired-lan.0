From: kbuild test robot <lkp@intel.com>
Date: Thu, 7 Jun 2018 09:14:55 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 12/19]
 drivers/net//ethernet/intel/ixgbe/ixgbe_ipsec.c:534:12: error: redefinition
 of 'ixgbe_ipsec_check_mgmt_ip'
Message-ID: <201806070942.RFKKFfcG%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   a009a81ed3ae2334db24462b6d37286b8810049f
commit: 52a921180e5c07be0f4788137e9d97e1efb098b2 [12/19] ixgbe: check ipsec ip addr against mgmt filters
config: i386-randconfig-x009-201822 (attached as .config)
compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
reproduce:
        git checkout 52a921180e5c07be0f4788137e9d97e1efb098b2
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

>> drivers/net//ethernet/intel/ixgbe/ixgbe_ipsec.c:534:12: error: redefinition of 'ixgbe_ipsec_check_mgmt_ip'
    static int ixgbe_ipsec_check_mgmt_ip(struct xfrm_state *xs)
               ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net//ethernet/intel/ixgbe/ixgbe_ipsec.c:451:12: note: previous definition of 'ixgbe_ipsec_check_mgmt_ip' was here
    static int ixgbe_ipsec_check_mgmt_ip(struct xfrm_state *xs)
               ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net//ethernet/intel/ixgbe/ixgbe_ipsec.c:451:12: warning: 'ixgbe_ipsec_check_mgmt_ip' defined but not used [-Wunused-function]

vim +/ixgbe_ipsec_check_mgmt_ip +534 drivers/net//ethernet/intel/ixgbe/ixgbe_ipsec.c

   529	
   530	/**
   531	 * ixgbe_ipsec_check_mgmt_ip - make sure there is no clash with mgmt IP filters
   532	 * @xs: pointer to transformer state struct
   533	 **/
 > 534	static int ixgbe_ipsec_check_mgmt_ip(struct xfrm_state *xs)
   535	{
   536		struct net_device *dev = xs->xso.dev;
   537		struct ixgbe_adapter *adapter = netdev_priv(dev);
   538		struct ixgbe_hw *hw = &adapter->hw;
   539		u32 mfval, manc, reg;
   540		int num_filters = 4;
   541		bool manc_ipv4;
   542		u32 bmcipval;
   543		int i, j;
   544	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 27391 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20180607/21557f5b/attachment-0001.bin>
