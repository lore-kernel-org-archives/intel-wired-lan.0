From: kbuild test robot <fengguang.wu@intel.com>
Date: Wed, 8 Jun 2016 09:09:11 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 42/43]
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c:1879:8: error: implicit
 declaration of function 'pci_request_mem_regions'
Message-ID: <201606080909.iABMZoHw%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   a078f654f7c05b787fc25f065db5fcb4ba25ea98
commit: f415332b9f716889afccde9c88dedfc9680eae1c [42/43] ethernet/intel: Use pci_(request|release)_mem_regions
config: i386-randconfig-r0-06061713 (attached as .config)
compiler: gcc-6 (Debian 6.1.1-1) 6.1.1 20160430
reproduce:
        git checkout f415332b9f716889afccde9c88dedfc9680eae1c
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   drivers/net/ethernet/intel/fm10k/fm10k_pci.c: In function 'fm10k_probe':
>> drivers/net/ethernet/intel/fm10k/fm10k_pci.c:1879:8: error: implicit declaration of function 'pci_request_mem_regions' [-Werror=implicit-function-declaration]
     err = pci_request_mem_regions(pdev, fm10k_driver_name);
           ^~~~~~~~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/intel/fm10k/fm10k_pci.c:1983:2: error: implicit declaration of function 'pci_release_mem_regions' [-Werror=implicit-function-declaration]
     pci_release_mem_regions(pdev);
     ^~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +/pci_request_mem_regions +1879 drivers/net/ethernet/intel/fm10k/fm10k_pci.c

  1873		if (err) {
  1874			dev_err(&pdev->dev,
  1875				"DMA configuration failed: %d\n", err);
  1876			goto err_dma;
  1877		}
  1878	
> 1879		err = pci_request_mem_regions(pdev, fm10k_driver_name);
  1880		if (err) {
  1881			dev_err(&pdev->dev,
  1882				"pci_request_selected_regions failed: %d\n", err);
  1883			goto err_pci_reg;
  1884		}
  1885	
  1886		pci_enable_pcie_error_reporting(pdev);
  1887	
  1888		pci_set_master(pdev);
  1889		pci_save_state(pdev);
  1890	
  1891		netdev = fm10k_alloc_netdev(fm10k_info_tbl[ent->driver_data]);
  1892		if (!netdev) {
  1893			err = -ENOMEM;
  1894			goto err_alloc_netdev;
  1895		}
  1896	
  1897		SET_NETDEV_DEV(netdev, &pdev->dev);
  1898	
  1899		interface = netdev_priv(netdev);
  1900		pci_set_drvdata(pdev, interface);
  1901	
  1902		interface->netdev = netdev;
  1903		interface->pdev = pdev;
  1904	
  1905		interface->uc_addr = ioremap(pci_resource_start(pdev, 0),
  1906					     FM10K_UC_ADDR_SIZE);
  1907		if (!interface->uc_addr) {
  1908			err = -EIO;
  1909			goto err_ioremap;
  1910		}
  1911	
  1912		err = fm10k_sw_init(interface, ent);
  1913		if (err)
  1914			goto err_sw_init;
  1915	
  1916		/* enable debugfs support */
  1917		fm10k_dbg_intfc_init(interface);
  1918	
  1919		err = fm10k_init_queueing_scheme(interface);
  1920		if (err)
  1921			goto err_sw_init;
  1922	
  1923		/* the mbx interrupt might attempt to schedule the service task, so we
  1924		 * must ensure it is disabled since we haven't yet requested the timer
  1925		 * or work item.
  1926		 */
  1927		set_bit(__FM10K_SERVICE_DISABLE, &interface->state);
  1928	
  1929		err = fm10k_mbx_request_irq(interface);
  1930		if (err)
  1931			goto err_mbx_interrupt;
  1932	
  1933		/* final check of hardware state before registering the interface */
  1934		err = fm10k_hw_ready(interface);
  1935		if (err)
  1936			goto err_register;
  1937	
  1938		err = register_netdev(netdev);
  1939		if (err)
  1940			goto err_register;
  1941	
  1942		/* carrier off reporting is important to ethtool even BEFORE open */
  1943		netif_carrier_off(netdev);
  1944	
  1945		/* stop all the transmit queues from transmitting until link is up */
  1946		netif_tx_stop_all_queues(netdev);
  1947	
  1948		/* Initialize service timer and service task late in order to avoid
  1949		 * cleanup issues.
  1950		 */
  1951		setup_timer(&interface->service_timer, &fm10k_service_timer,
  1952			    (unsigned long)interface);
  1953		INIT_WORK(&interface->service_task, fm10k_service_task);
  1954	
  1955		/* kick off service timer now, even when interface is down */
  1956		mod_timer(&interface->service_timer, (HZ * 2) + jiffies);
  1957	
  1958		/* print warning for non-optimal configurations */
  1959		fm10k_slot_warn(interface);
  1960	
  1961		/* report MAC address for logging */
  1962		dev_info(&pdev->dev, "%pM\n", netdev->dev_addr);
  1963	
  1964		/* enable SR-IOV after registering netdev to enforce PF/VF ordering */
  1965		fm10k_iov_configure(pdev, 0);
  1966	
  1967		/* clear the service task disable bit to allow service task to start */
  1968		clear_bit(__FM10K_SERVICE_DISABLE, &interface->state);
  1969	
  1970		return 0;
  1971	
  1972	err_register:
  1973		fm10k_mbx_free_irq(interface);
  1974	err_mbx_interrupt:
  1975		fm10k_clear_queueing_scheme(interface);
  1976	err_sw_init:
  1977		if (interface->sw_addr)
  1978			iounmap(interface->sw_addr);
  1979		iounmap(interface->uc_addr);
  1980	err_ioremap:
  1981		free_netdev(netdev);
  1982	err_alloc_netdev:
> 1983		pci_release_mem_regions(pdev);
  1984	err_pci_reg:
  1985	err_dma:
  1986		pci_disable_device(pdev);

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 26354 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160608/8b092419/attachment-0001.obj>
