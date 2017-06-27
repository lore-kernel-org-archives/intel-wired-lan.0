From: kbuild test robot <fengguang.wu@intel.com>
Date: Tue, 27 Jun 2017 17:59:08 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 52/57]
 drivers/net//ethernet/intel/i40e/i40e_debugfs.c:160:2: warning: format
 '%lx' expects argument of type 'long unsigned int',
 but argument 3 has type 'u64'
Message-ID: <201706271705.zWRrW0sp%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   ea3e0e4ac54c250449123f82d5d35f5fb53cec9e
commit: d15813888dabcb98b5226a70d4ebcb61de76d05a [52/57] i40e/i40evf: organize and re-number feature flags
config: xtensa-allmodconfig (attached as .config)
compiler: xtensa-linux-gcc (GCC) 4.9.0
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout d15813888dabcb98b5226a70d4ebcb61de76d05a
        # save the attached .config to linux build tree
        make.cross ARCH=xtensa 

All warnings (new ones prefixed by >>):

   drivers/net//ethernet/intel/i40e/i40e_debugfs.c: In function 'i40e_dbg_dump_vsi_seid':
>> drivers/net//ethernet/intel/i40e/i40e_debugfs.c:160:2: warning: format '%lx' expects argument of type 'long unsigned int', but argument 3 has type 'u64' [-Wformat=]
     dev_info(&pf->pdev->dev,
     ^

vim +160 drivers/net//ethernet/intel/i40e/i40e_debugfs.c

02e9c290 Jesse Brandeburg 2013-09-11  144  	}
02e9c290 Jesse Brandeburg 2013-09-11  145  	dev_info(&pf->pdev->dev, "vsi seid %d\n", seid);
de1017f7 Shannon Nelson   2015-12-23  146  	if (vsi->netdev) {
de1017f7 Shannon Nelson   2015-12-23  147  		struct net_device *nd = vsi->netdev;
de1017f7 Shannon Nelson   2015-12-23  148  
de1017f7 Shannon Nelson   2015-12-23  149  		dev_info(&pf->pdev->dev, "    netdev: name = %s, state = %lu, flags = 0x%08x\n",
de1017f7 Shannon Nelson   2015-12-23  150  			 nd->name, nd->state, nd->flags);
de1017f7 Shannon Nelson   2015-12-23  151  		dev_info(&pf->pdev->dev, "        features      = 0x%08lx\n",
de1017f7 Shannon Nelson   2015-12-23  152  			 (unsigned long int)nd->features);
de1017f7 Shannon Nelson   2015-12-23  153  		dev_info(&pf->pdev->dev, "        hw_features   = 0x%08lx\n",
de1017f7 Shannon Nelson   2015-12-23  154  			 (unsigned long int)nd->hw_features);
de1017f7 Shannon Nelson   2015-12-23  155  		dev_info(&pf->pdev->dev, "        vlan_features = 0x%08lx\n",
de1017f7 Shannon Nelson   2015-12-23  156  			 (unsigned long int)nd->vlan_features);
de1017f7 Shannon Nelson   2015-12-23  157  	}
02e9c290 Jesse Brandeburg 2013-09-11  158  	dev_info(&pf->pdev->dev,
02e9c290 Jesse Brandeburg 2013-09-11  159  		 "    vlgrp: & = %p\n", vsi->active_vlans);
02e9c290 Jesse Brandeburg 2013-09-11 @160  	dev_info(&pf->pdev->dev,
0da36b97 Jacob Keller     2017-04-19  161  		 "    flags = 0x%08lx, netdev_registered = %i, current_netdev_flags = 0x%04x\n",
0da36b97 Jacob Keller     2017-04-19  162  		 vsi->flags, vsi->netdev_registered, vsi->current_netdev_flags);
0da36b97 Jacob Keller     2017-04-19  163  	for (i = 0; i < BITS_TO_LONGS(__I40E_VSI_STATE_SIZE__); i++)
0da36b97 Jacob Keller     2017-04-19  164  		dev_info(&pf->pdev->dev,
0da36b97 Jacob Keller     2017-04-19  165  			 "    state[%d] = %08lx\n",
0da36b97 Jacob Keller     2017-04-19  166  			 i, vsi->state[i]);
2ddb80c9 Shannon Nelson   2015-02-27  167  	if (vsi == pf->vsi[pf->lan_vsi])
2ddb80c9 Shannon Nelson   2015-02-27  168  		dev_info(&pf->pdev->dev, "    MAC address: %pM SAN MAC: %pM Port MAC: %pM\n",

:::::: The code at line 160 was first introduced by commit
:::::: 02e9c290814cc143ceccecb14eac3e7a05da745e i40e: debugfs interface

:::::: TO: Jesse Brandeburg <jesse.brandeburg@intel.com>
:::::: CC: Jeff Kirsher <jeffrey.t.kirsher@intel.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 50222 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20170627/8f8fbedd/attachment-0001.bin>
