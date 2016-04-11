From: kbuild test robot <fengguang.wu@intel.com>
Date: Tue, 12 Apr 2016 05:42:58 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 34/34]
 drivers/net/ethernet/intel/e1000e/netdev.c:7250:2: error: 'ret_val'
 undeclared
Message-ID: <201604120557.6RgRlq12%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   179719a0dde51627fdb6a73ddcd43dfb7e3547ee
commit: 179719a0dde51627fdb6a73ddcd43dfb7e3547ee [34/34] e1000e: Fix ptp time reset on network interruption
config: xtensa-allmodconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 179719a0dde51627fdb6a73ddcd43dfb7e3547ee
        # save the attached .config to linux build tree
        make.cross ARCH=xtensa 

All errors (new ones prefixed by >>):

   drivers/net/ethernet/intel/e1000e/netdev.c: In function 'e1000_probe':
>> drivers/net/ethernet/intel/e1000e/netdev.c:7250:2: error: 'ret_val' undeclared (first use in this function)
     ret_val = e1000e_get_base_timinca(adapter, &regval);
     ^
   drivers/net/ethernet/intel/e1000e/netdev.c:7250:2: note: each undeclared identifier is reported only once for each function it appears in

vim +/ret_val +7250 drivers/net/ethernet/intel/e1000e/netdev.c

  7244			goto err_register;
  7245	
  7246		/* carrier off reporting is important to ethtool even BEFORE open */
  7247		netif_carrier_off(netdev);
  7248	
  7249		/* Get and set the System Time Register SYSTIM base frequency */
> 7250		ret_val = e1000e_get_base_timinca(adapter, &regval);
  7251		if (rval)
  7252			goto err_register;
  7253		ew32(TIMINCA, regval);

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 44821 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160412/1c812f44/attachment-0001.obj>
