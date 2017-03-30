From: kbuild test robot <fengguang.wu@intel.com>
Date: Thu, 30 Mar 2017 16:59:32 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 46/50]
 drivers/net//ethernet/intel/i40e/i40e_main.c:11098:3: warning: 'vf' may be
 used uninitialized in this function
Message-ID: <201703301627.jN8fIwun%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   e7ffaffd41256f8039a6cd78092492172b96dc1b
commit: 328f9ed45d8903aac029a756d6eb5daf553df71f [46/50] i40e: Sync link state between PF/VFs and Port representor netdevs
config: xtensa-allmodconfig (attached as .config)
compiler: xtensa-linux-gcc (GCC) 4.9.0
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 328f9ed45d8903aac029a756d6eb5daf553df71f
        # save the attached .config to linux build tree
        make.cross ARCH=xtensa 

Note: it may well be a FALSE warning. FWIW you are at least aware of it now.
http://gcc.gnu.org/wiki/Better_Uninitialized_Warnings

All warnings (new ones prefixed by >>):

   drivers/net//ethernet/intel/i40e/i40e_main.c: In function 'i40e_alloc_port_netdev':
>> drivers/net//ethernet/intel/i40e/i40e_main.c:11098:3: warning: 'vf' may be used uninitialized in this function [-Wmaybe-uninitialized]
      i40e_vc_notify_vf_link_state(vf);
      ^

vim +/vf +11098 drivers/net//ethernet/intel/i40e/i40e_main.c

 11082		switch (type) {
 11083		case I40E_PORT_NETDEV_PF:
 11084			/* Reset PF link as we are changing the mode to 'switchdev'.
 11085			 * Port netdev needs to be brought up to enable VF link.
 11086			 */
 11087			netif_carrier_off(vsi->netdev);
 11088			netif_tx_stop_all_queues(vsi->netdev);
 11089			if (pf->hw.phy.link_info.link_info & I40E_AQ_LINK_UP)
 11090				netif_carrier_on(port_netdev);
 11091			break;
 11092		case I40E_PORT_NETDEV_VF:
 11093			/* Reset VF link as we are changing the mode to 'switchdev'.
 11094			 * Port netdev needs to be brought up to enable VF link.
 11095			 */
 11096			vf->link_forced = true;
 11097			vf->link_up = false;
 11098			i40e_vc_notify_vf_link_state(vf);
 11099			break;
 11100		}
 11101	
 11102		return 0;
 11103	}
 11104	
 11105	/**
 11106	 * i40e_free_port_netdev

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 49104 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20170330/c58f6bc5/attachment-0001.bin>
