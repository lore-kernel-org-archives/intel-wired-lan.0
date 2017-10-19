From: kbuild test robot <fengguang.wu@intel.com>
Date: Fri, 20 Oct 2017 00:02:20 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 18/24]
 drivers/net//ethernet/intel/i40e/i40e_main.c:9017:4: note: in expansion of
 macro 'dev_dbg'
Message-ID: <201710200015.3H6SaUMd%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   53d0c6455764b0a6f33eba85ca2c2e1298c0df3d
commit: a43ab02fb3cb1f791ae5acfaa789fef9f5c6470e [18/24] Subject: [v2] i40e: avoid 64-bit division where possible X-Patchwork-Submitter: Arnd Bergmann <arnd@arndb.de> Cc: Arnd Bergmann <arnd@arndb.de>, netdev at vger.kernel.org, Mitch Williams  <mitch.a.williams@intel.com>, linux-kernel at vger.kernel.org,  intel-wired-lan at lists.osuosl.org, =?utf-8?b?QmrDtnJuIFTDtnBlbA==?=  <bjorn.topel@intel.com>,  Filip Sadowski <filip.sadowski@intel.com>,  "David S. Miller" <davem@davemloft.net> List-Id: Intel Wired Ethernet Linux Kernel Driver Development  <intel-wired-lan.osuosl.org>
config: xtensa-allyesconfig (attached as .config)
compiler: xtensa-linux-gcc (GCC) 4.9.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout a43ab02fb3cb1f791ae5acfaa789fef9f5c6470e
        # save the attached .config to linux build tree
        make.cross ARCH=xtensa 

All warnings (new ones prefixed by >>):

   In file included from include/linux/printk.h:329:0,
                    from include/linux/kernel.h:13,
                    from include/linux/skbuff.h:17,
                    from include/linux/if_ether.h:23,
                    from include/linux/etherdevice.h:25,
                    from drivers/net//ethernet/intel/i40e/i40e_main.c:27:
   drivers/net//ethernet/intel/i40e/i40e_main.c: In function 'i40e_rebuild_channels':
   drivers/net//ethernet/intel/i40e/i40e_main.c:9020:5: error: 'credits' undeclared (first use in this function)
        credits,
        ^
   include/linux/dynamic_debug.h:135:9: note: in definition of macro 'dynamic_dev_dbg'
          ##__VA_ARGS__);  \
            ^
>> drivers/net//ethernet/intel/i40e/i40e_main.c:9017:4: note: in expansion of macro 'dev_dbg'
       dev_dbg(&vsi->back->pdev->dev,
       ^
   drivers/net//ethernet/intel/i40e/i40e_main.c:9020:5: note: each undeclared identifier is reported only once for each function it appears in
        credits,
        ^
   include/linux/dynamic_debug.h:135:9: note: in definition of macro 'dynamic_dev_dbg'
          ##__VA_ARGS__);  \
            ^
>> drivers/net//ethernet/intel/i40e/i40e_main.c:9017:4: note: in expansion of macro 'dev_dbg'
       dev_dbg(&vsi->back->pdev->dev,
       ^

vim +/dev_dbg +9017 drivers/net//ethernet/intel/i40e/i40e_main.c

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
2027d4de Amritha Nambiar 2017-09-07 @9017  			dev_dbg(&vsi->back->pdev->dev,
a43ab02f Arnd Bergmann   2017-10-18  9018  				"Set tx rate of %u Mbps (count of 50Mbps %u) for vsi->seid %u\n",
2027d4de Amritha Nambiar 2017-09-07  9019  				ch->max_tx_rate,
6c32e0d9 Alan Brady      2017-10-09  9020  				credits,
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

:::::: The code at line 9017 was first introduced by commit
:::::: 2027d4deacb129579f022746830ea05b72fe114a i40e: Add support setting TC max bandwidth rates

:::::: TO: Amritha Nambiar <amritha.nambiar@intel.com>
:::::: CC: Jeff Kirsher <jeffrey.t.kirsher@intel.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 51703 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20171020/3621ef77/attachment-0001.bin>
