From: Lubetkin, YanirX <yanirx.lubetkin@intel.com>
Date: Fri, 12 Jun 2015 10:27:24 +0000
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 92/92]
 drivers/net/ethernet/intel/e1000e/netdev.c:6451:13: warning:
 'e1000e_disable_aspm_locked' defined but not used
In-Reply-To: <201506121606.TqatSeI8%fengguang.wu@intel.com>
References: <201506121606.TqatSeI8%fengguang.wu@intel.com>
Message-ID: <4D1FB504F643AC4BA12C9F34A1763FA419CB5C24@HASMSX106.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Thanks, I will look at that.

Yanir

> -----Original Message-----
> From: Wu, Fengguang
> Sent: Friday, June 12, 2015 11:55
> To: Lubetkin, YanirX
> Cc: kbuild-all at 01.org; Kirsher, Jeffrey T; intel-wired-lan at lists.osuosl.org
> Subject: [jkirsher-next-queue:dev-queue 92/92]
> drivers/net/ethernet/intel/e1000e/netdev.c:6451:13: warning:
> 'e1000e_disable_aspm_locked' defined but not used
> 
> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git
> dev-queue
> head:   2102dc330d023c8eee83b9716b619d752119e84d
> commit: 2102dc330d023c8eee83b9716b619d752119e84d [92/92] e1000e: fix
> locking issue with e1000e_disable_aspm
> config: tile-allyesconfig (attached as .config)
> reproduce:
>   wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-
> tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>   chmod +x ~/bin/make.cross
>   git checkout 2102dc330d023c8eee83b9716b619d752119e84d
>   # save the attached .config to linux build tree
>   make.cross ARCH=tile
> 
> All warnings (new ones prefixed by >>):
> 
> >> drivers/net/ethernet/intel/e1000e/netdev.c:6451:13: warning:
> 'e1000e_disable_aspm_locked' defined but not used [-Wunused-function]
> 
> vim +/e1000e_disable_aspm_locked +6451
> drivers/net/ethernet/intel/e1000e/netdev.c
> 
>   6435	 * This function acquires the pci_bus_sem!
>   6436	 * Some devices *must* have certain ASPM states disabled per
> hardware errata.
>   6437	 **/
>   6438	static void e1000e_disable_aspm(struct pci_dev *pdev, u16 state)
>   6439	{
>   6440		__e1000e_disable_aspm(pdev, state, 0);
>   6441	}
>   6442
>   6443	/**
>   6444	 * e1000e_disable_aspm_locked   Disable ASPM states.
>   6445	 * @pdev: pointer to PCI device struct
>   6446	 * @state: bit-mask of ASPM states to disable
>   6447	 *
>   6448	 * This function must be called with pci_bus_sem acquired!
>   6449	 * Some devices *must* have certain ASPM states disabled per
> hardware errata.
>   6450	 **/
> > 6451	static void e1000e_disable_aspm_locked(struct pci_dev *pdev, u16
> state)
>   6452	{
>   6453		__e1000e_disable_aspm(pdev, state, 1);
>   6454	}
>   6455
>   6456	#ifdef CONFIG_PM
>   6457	static int __e1000_resume(struct pci_dev *pdev)
>   6458	{
>   6459		struct net_device *netdev = pci_get_drvdata(pdev);
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> http://lists.01.org/mailman/listinfo/kbuild                 Intel Corporation
---------------------------------------------------------------------
Intel Israel (74) Limited

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

