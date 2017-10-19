From: kbuild test robot <fengguang.wu@intel.com>
Date: Thu, 19 Oct 2017 23:35:09 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 18/24]
 drivers/net/ethernet/intel/i40e/i40e_main.c:9020:5: error: 'credits'
 undeclared
Message-ID: <201710192307.IZ5rOmrX%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   53d0c6455764b0a6f33eba85ca2c2e1298c0df3d
commit: a43ab02fb3cb1f791ae5acfaa789fef9f5c6470e [18/24] Subject: [v2] i40e: avoid 64-bit division where possible X-Patchwork-Submitter: Arnd Bergmann <arnd@arndb.de> Cc: Arnd Bergmann <arnd@arndb.de>, netdev at vger.kernel.org, Mitch Williams  <mitch.a.williams@intel.com>, linux-kernel at vger.kernel.org,  intel-wired-lan at lists.osuosl.org, =?utf-8?b?QmrDtnJuIFTDtnBlbA==?=  <bjorn.topel@intel.com>,  Filip Sadowski <filip.sadowski@intel.com>,  "David S. Miller" <davem@davemloft.net> List-Id: Intel Wired Ethernet Linux Kernel Driver Development  <intel-wired-lan.osuosl.org>
config: i386-randconfig-x006-201742 (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        git checkout a43ab02fb3cb1f791ae5acfaa789fef9f5c6470e
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   In file included from include/linux/dma-mapping.h:6:0,
                    from include/linux/skbuff.h:35,
                    from include/linux/if_ether.h:23,
                    from include/linux/etherdevice.h:25,
                    from drivers/net/ethernet/intel/i40e/i40e_main.c:27:
   drivers/net/ethernet/intel/i40e/i40e_main.c: In function 'i40e_rebuild_channels':
>> drivers/net/ethernet/intel/i40e/i40e_main.c:9020:5: error: 'credits' undeclared (first use in this function)
        credits,
        ^
   include/linux/device.h:1360:41: note: in definition of macro 'dev_dbg'
      dev_printk(KERN_DEBUG, dev, format, ##arg); \
                                            ^~~
   drivers/net/ethernet/intel/i40e/i40e_main.c:9020:5: note: each undeclared identifier is reported only once for each function it appears in
        credits,
        ^
   include/linux/device.h:1360:41: note: in definition of macro 'dev_dbg'
      dev_printk(KERN_DEBUG, dev, format, ##arg); \
                                            ^~~

vim +/credits +9020 drivers/net/ethernet/intel/i40e/i40e_main.c

2590901c Amritha Nambiar 2017-10-18  8986  
2590901c Amritha Nambiar 2017-10-18  8987  /**
8f88b303 Amritha Nambiar 2017-09-07  8988   * i40e_rebuild_channels - Rebuilds channel VSIs if they existed before reset
8f88b303 Amritha Nambiar 2017-09-07  8989   * @vsi: PF main vsi
8f88b303 Amritha Nambiar 2017-09-07  8990   *
8f88b303 Amritha Nambiar 2017-09-07  8991   * Rebuilds channel VSIs if they existed before reset
8f88b303 Amritha Nambiar 2017-09-07  8992   **/
8f88b303 Amritha Nambiar 2017-09-07  8993  static int i40e_rebuild_channels(struct i40e_vsi *vsi)
8f88b303 Amritha Nambiar 2017-09-07  8994  {
8f88b303 Amritha Nambiar 2017-09-07  8995  	struct i40e_channel *ch, *ch_tmp;
8f88b303 Amritha Nambiar 2017-09-07  8996  	i40e_status ret;
8f88b303 Amritha Nambiar 2017-09-07  8997  
8f88b303 Amritha Nambiar 2017-09-07  8998  	if (list_empty(&vsi->ch_list))
8f88b303 Amritha Nambiar 2017-09-07  8999  		return 0;
8f88b303 Amritha Nambiar 2017-09-07  9000  
8f88b303 Amritha Nambiar 2017-09-07  9001  	list_for_each_entry_safe(ch, ch_tmp, &vsi->ch_list, list) {
8f88b303 Amritha Nambiar 2017-09-07  9002  		if (!ch->initialized)
8f88b303 Amritha Nambiar 2017-09-07  9003  			break;
8f88b303 Amritha Nambiar 2017-09-07  9004  		/* Proceed with creation of channel (VMDq2) VSI */
8f88b303 Amritha Nambiar 2017-09-07  9005  		ret = i40e_add_channel(vsi->back, vsi->uplink_seid, ch);
8f88b303 Amritha Nambiar 2017-09-07  9006  		if (ret) {
8f88b303 Amritha Nambiar 2017-09-07  9007  			dev_info(&vsi->back->pdev->dev,
8f88b303 Amritha Nambiar 2017-09-07  9008  				 "failed to rebuild channels using uplink_seid %u\n",
8f88b303 Amritha Nambiar 2017-09-07  9009  				 vsi->uplink_seid);
8f88b303 Amritha Nambiar 2017-09-07  9010  			return ret;
8f88b303 Amritha Nambiar 2017-09-07  9011  		}
2027d4de Amritha Nambiar 2017-09-07  9012  		if (ch->max_tx_rate) {
2027d4de Amritha Nambiar 2017-09-07  9013  			if (i40e_set_bw_limit(vsi, ch->seid,
2027d4de Amritha Nambiar 2017-09-07  9014  					      ch->max_tx_rate))
2027d4de Amritha Nambiar 2017-09-07  9015  				return -EINVAL;
2027d4de Amritha Nambiar 2017-09-07  9016  
2027d4de Amritha Nambiar 2017-09-07  9017  			dev_dbg(&vsi->back->pdev->dev,
a43ab02f Arnd Bergmann   2017-10-18  9018  				"Set tx rate of %u Mbps (count of 50Mbps %u) for vsi->seid %u\n",
2027d4de Amritha Nambiar 2017-09-07  9019  				ch->max_tx_rate,
6c32e0d9 Alan Brady      2017-10-09 @9020  				credits,
2027d4de Amritha Nambiar 2017-09-07  9021  				ch->seid);
2027d4de Amritha Nambiar 2017-09-07  9022  		}
2590901c Amritha Nambiar 2017-10-18  9023  		ret = i40e_rebuild_cloud_filters(vsi, ch->seid);
2590901c Amritha Nambiar 2017-10-18  9024  		if (ret) {
2590901c Amritha Nambiar 2017-10-18  9025  			dev_dbg(&vsi->back->pdev->dev,
2590901c Amritha Nambiar 2017-10-18  9026  				"Failed to rebuild cloud filters for channel VSI %u\n",
2590901c Amritha Nambiar 2017-10-18  9027  				ch->seid);
2590901c Amritha Nambiar 2017-10-18  9028  			return ret;
2590901c Amritha Nambiar 2017-10-18  9029  		}
8f88b303 Amritha Nambiar 2017-09-07  9030  	}
8f88b303 Amritha Nambiar 2017-09-07  9031  	return 0;
8f88b303 Amritha Nambiar 2017-09-07  9032  }
8f88b303 Amritha Nambiar 2017-09-07  9033  

:::::: The code at line 9020 was first introduced by commit
:::::: 6c32e0d9fdd56a7af54512aff700e20d85563499 i40e: fix u64 division usage

:::::: TO: Alan Brady <alan.brady@intel.com>
:::::: CC: Jeff Kirsher <jeffrey.t.kirsher@intel.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 30498 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20171019/563a53fa/attachment-0001.bin>
