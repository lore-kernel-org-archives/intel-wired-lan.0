From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 4 Sep 2020 21:48:35 +0000
Subject: [Intel-wired-lan] [PATCH][next] i40e: switch kvzalloc to
 allocate rx/tx_bi buffer
In-Reply-To: <1598000514-5951-1-git-send-email-lirongqing@baidu.com>
References: <1598000514-5951-1-git-send-email-lirongqing@baidu.com>
Message-ID: <DM6PR11MB28901397ABF26EEE1918F17BBC2D0@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: netdev-owner at vger.kernel.org <netdev-owner@vger.kernel.org>
> On Behalf Of Li RongQing
> Sent: Friday, August 21, 2020 2:02 AM
> To: netdev at vger.kernel.org; intel-wired-lan at lists.osuosl.org
> Subject: [PATCH][next] i40e: switch kvzalloc to allocate rx/tx_bi buffer
> 
> when changes the rx/tx ring to 4096, rx/tx_bi needs an order
> 5 pages, and allocation maybe fail due to memory fragmentation
> so switch to kvzalloc
> 
>  i40e 0000:1a:00.0 xgbe0: Changing Rx descriptor count from 512 to 4096
>  ethtool: page allocation failure: order:5,
> mode:0x60c0c0(GFP_KERNEL|__GFP_COMP|__GFP_ZERO),
> nodemask=(null)
>  ethtool cpuset=/ mems_allowed=0
>  CPU: 34 PID: 47182 Comm: ethtool Kdump: loaded Tainted: G            E     4.19
> #1
>  Hardware name: Inspur BJINSPURV2G5Y72-32A/SN6115M5, BIOS 3.0.12
> 03/29/2018
>  Call Trace:
>   dump_stack+0x66/0x8b
>   warn_alloc+0xff/0x1a0
>   __alloc_pages_slowpath+0xcc9/0xd00
>   __alloc_pages_nodemask+0x25e/0x2a0
>   kmalloc_order+0x14/0x40
>   kmalloc_order_trace+0x1d/0xb0
>   i40e_setup_rx_descriptors+0x47/0x1e0 [i40e]
>   i40e_set_ringparam+0x25e/0x7c0 [i40e]
>   dev_ethtool+0x1fa3/0x2920
>   ? inet_ioctl+0xe0/0x250
>   ? __rtnl_unlock+0x25/0x40
>   ? netdev_run_todo+0x5e/0x2f0
>   ? dev_ioctl+0xb3/0x560
>   dev_ioctl+0xb3/0x560
>   sock_do_ioctl+0xae/0x150
>   ? sock_ioctl+0x1c6/0x310
>   sock_ioctl+0x1c6/0x310
>   ? do_vfs_ioctl+0xa4/0x630
>   ? dlci_ioctl_set+0x30/0x30
>   do_vfs_ioctl+0xa4/0x630
>   ? handle_mm_fault+0xe6/0x240
>   ? __do_page_fault+0x288/0x510
>   ksys_ioctl+0x70/0x80
>   __x64_sys_ioctl+0x16/0x20
>   do_syscall_64+0x5b/0x1b0
>   entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c |  2 +-
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c | 10 +++++-----
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
