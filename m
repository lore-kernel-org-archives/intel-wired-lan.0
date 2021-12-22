From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Wed, 22 Dec 2021 04:24:36 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: fix use-after-free in
 i40e_sync_filters_subtask()
In-Reply-To: <20211129135201.4097648-1-zhangrui182@huawei.com>
References: <20211129135201.4097648-1-zhangrui182@huawei.com>
Message-ID: <BYAPR11MB336701DFBF02224E7EDA2095FC7D9@BYAPR11MB3367.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Rui Zhang <zhangrui182@huawei.com>
> Sent: Monday, November 29, 2021 7:22 PM
> To: Brandeburg, Jesse <jesse.brandeburg@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; intel-wired-lan at lists.osuosl.org
> Cc: rose.chen at huawei.com; yanan at huawei.com; zhudi2 at huawei.com;
> zhangrui182 at huawei.com
> Subject: [PATCH] i40e: fix use-after-free in i40e_sync_filters_subtask()
> 
> From: Di Zhu <zhudi2@huawei.com>
> 
> Using ifconfig command to delete the ipv6 address will cause the i40e network
> card driver to delete its internal mac_filter and i40e_service_task kernel
> thread will concurrently access the mac_filter.
> These two processes are not protected by lock so causing the following use-
> after-free problems.
> 
>  print_address_description+0x70/0x360
>  ? vprintk_func+0x5e/0xf0
>  kasan_report+0x1b2/0x330
>  i40e_sync_vsi_filters+0x4f0/0x1850 [i40e]
>  i40e_sync_filters_subtask+0xe3/0x130 [i40e]
>  i40e_service_task+0x195/0x24c0 [i40e]
>  process_one_work+0x3f5/0x7d0
>  worker_thread+0x61/0x6c0
>  ? process_one_work+0x7d0/0x7d0
>  kthread+0x1c3/0x1f0
>  ? kthread_park+0xc0/0xc0
>  ret_from_fork+0x35/0x40
> 
> Allocated by task 2279810:
>  kasan_kmalloc+0xa0/0xd0
>  kmem_cache_alloc_trace+0xf3/0x1e0
>  i40e_add_filter+0x127/0x2b0 [i40e]
>  i40e_add_mac_filter+0x156/0x190 [i40e]
>  i40e_addr_sync+0x2d/0x40 [i40e]
>  __hw_addr_sync_dev+0x154/0x210
>  i40e_set_rx_mode+0x6d/0xf0 [i40e]
>  __dev_set_rx_mode+0xfb/0x1f0
>  __dev_mc_add+0x6c/0x90
>  igmp6_group_added+0x214/0x230
>  __ipv6_dev_mc_inc+0x338/0x4f0
>  addrconf_join_solict.part.7+0xa2/0xd0
>  addrconf_dad_work+0x500/0x980
>  process_one_work+0x3f5/0x7d0
>  worker_thread+0x61/0x6c0
>  kthread+0x1c3/0x1f0
>  ret_from_fork+0x35/0x40
> 
> Freed by task 2547073:
>  __kasan_slab_free+0x130/0x180
>  kfree+0x90/0x1b0
>  __i40e_del_filter+0xa3/0xf0 [i40e]
>  i40e_del_mac_filter+0xf3/0x130 [i40e]
>  i40e_addr_unsync+0x85/0xa0 [i40e]
>  __hw_addr_sync_dev+0x9d/0x210
>  i40e_set_rx_mode+0x6d/0xf0 [i40e]
>  __dev_set_rx_mode+0xfb/0x1f0
>  __dev_mc_del+0x69/0x80
>  igmp6_group_dropped+0x279/0x510
>  __ipv6_dev_mc_dec+0x174/0x220
>  addrconf_leave_solict.part.8+0xa2/0xd0
>  __ipv6_ifa_notify+0x4cd/0x570
>  ipv6_ifa_notify+0x58/0x80
>  ipv6_del_addr+0x259/0x4a0
>  inet6_addr_del+0x188/0x260
>  addrconf_del_ifaddr+0xcc/0x130
>  inet6_ioctl+0x152/0x190
>  sock_do_ioctl+0xd8/0x2b0
>  sock_ioctl+0x2e5/0x4c0
>  do_vfs_ioctl+0x14e/0xa80
>  ksys_ioctl+0x7c/0xa0
>  __x64_sys_ioctl+0x42/0x50
>  do_syscall_64+0x98/0x2c0
>  entry_SYSCALL_64_after_hwframe+0x65/0xca
> 
> Signed-off-by: Di Zhu <zhudi2@huawei.com>
> Signed-off-by: Rui Zhang <zhangrui182@huawei.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 24 +++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 

Tested-by: Gurucharan G <gurucharanx.g@intel.com> (A Contingent worker at Intel)
