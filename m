From: kbuild test robot <fengguang.wu@intel.com>
Date: Tue, 8 Dec 2015 17:07:50 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 35/88]
 drivers/net/ethernet/intel/fm10k/fm10k_netdev.c:1182:2: error: 'err'
 undeclared
Message-ID: <201512081749.3vqh0Mib%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   0d8cf8f0fb3baeb46c9019e8d3ff0057e1516fb2
commit: 89e14e905885490b878299e441b261eaa2afd789 [35/88] fm10k: Cleanup exception handling for changing queues
config: x86_64-randconfig-x009-12070929 (attached as .config)
reproduce:
        git checkout 89e14e905885490b878299e441b261eaa2afd789
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All error/warnings (new ones prefixed by >>):

   drivers/net/ethernet/intel/fm10k/fm10k_netdev.c: In function 'fm10k_setup_tc':
>> drivers/net/ethernet/intel/fm10k/fm10k_netdev.c:1182:2: error: 'err' undeclared (first use in this function)
     err = netif_running(dev) ? fm10k_open(dev) : 0;
     ^
   drivers/net/ethernet/intel/fm10k/fm10k_netdev.c:1182:2: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/net/ethernet/intel/fm10k/fm10k_netdev.c:1194:1: warning: label 'err_queueing_scheme' defined but not used [-Wunused-label]
    err_queueing_scheme:
    ^
>> drivers/net/ethernet/intel/fm10k/fm10k_netdev.c:1192:1: warning: label 'err_mbx_irq' defined but not used [-Wunused-label]
    err_mbx_irq:
    ^

vim +/err +1182 drivers/net/ethernet/intel/fm10k/fm10k_netdev.c

  1176		netdev_set_num_tc(dev, tc);
  1177	
  1178		fm10k_init_queueing_scheme(interface);
  1179	
  1180		fm10k_mbx_request_irq(interface);
  1181	
> 1182		err = netif_running(dev) ? fm10k_open(dev) : 0;
  1183		if (err)
  1184			goto err_open;
  1185	
  1186		/* flag to indicate SWPRI has yet to be updated */
  1187		interface->flags |= FM10K_FLAG_SWPRI_CONFIG;
  1188	
  1189		return 0;
  1190	err_open:
  1191		fm10k_mbx_free_irq(interface);
> 1192	err_mbx_irq:
  1193		fm10k_clear_queueing_scheme(interface);
> 1194	err_queueing_scheme:
  1195		netif_device_detach(dev);
  1196	
  1197		return err;

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 25406 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20151208/35075e30/attachment-0001.obj>
