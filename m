From: Bhandare, KiranX <kiranx.bhandare@intel.com>
Date: Wed, 5 Jan 2022 06:14:00 +0000
Subject: [Intel-wired-lan] [PATCH net v1] i40e: Fix queues reservation
 for XDP
In-Reply-To: <20211126101122.25085-1-mateusz.palczewski@intel.com>
References: <20211126101122.25085-1-mateusz.palczewski@intel.com>
Message-ID: <DM6PR11MB3292FA6E32C045F47489A062F14B9@DM6PR11MB3292.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Mateusz Palczewski
> Sent: Friday, November 26, 2021 3:41 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Dziedziuch, SylwesterX <sylwesterx.dziedziuch@intel.com>; Palczewski,
> Mateusz <mateusz.palczewski@intel.com>
> Subject: [Intel-wired-lan] [PATCH net v1] i40e: Fix queues reservation for XDP
> 
> From: Sylwester Dziedziuch <sylwesterx.dziedziuch@intel.com>
> 
> When XDP was configured on a system with large number of CPUs and X722
> NIC there was a call trace with NULL pointer dereference.
> 
> i40e 0000:87:00.0: failed to get tracking for 256 queues for VSI 0 err -12 i40e
> 0000:87:00.0: setup of MAIN VSI failed
> 
> BUG: kernel NULL pointer dereference, address: 0000000000000000
> RIP: 0010:i40e_xdp+0xea/0x1b0 [i40e]
> Call Trace:
> ? i40e_reconfig_rss_queues+0x130/0x130 [i40e]
> dev_xdp_install+0x61/0xe0
> dev_xdp_attach+0x18a/0x4c0
> dev_change_xdp_fd+0x1e6/0x220
> do_setlink+0x616/0x1030
> ? ahci_port_stop+0x80/0x80
> ? ata_qc_issue+0x107/0x1e0
> ? lock_timer_base+0x61/0x80
> ? __mod_timer+0x202/0x380
> rtnl_setlink+0xe5/0x170
> ? bpf_lsm_binder_transaction+0x10/0x10
> ? security_capable+0x36/0x50
> rtnetlink_rcv_msg+0x121/0x350
> ? rtnl_calcit.isra.0+0x100/0x100
> netlink_rcv_skb+0x50/0xf0
> netlink_unicast+0x1d3/0x2a0
> netlink_sendmsg+0x22a/0x440
> sock_sendmsg+0x5e/0x60
> __sys_sendto+0xf0/0x160
> ? __sys_getsockname+0x7e/0xc0
> ? _copy_from_user+0x3c/0x80
> ? __sys_setsockopt+0xc8/0x1a0
> __x64_sys_sendto+0x20/0x30
> do_syscall_64+0x33/0x40
> entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x7f83fa7a39e0
> 
> This was caused by PF queue pile fragmentation due to flow director VSI
> queue being placed right after main VSI.
> Because of this main VSI was not able to resize its queue allocation for XDP
> resulting in no queues allocated for main VSI when XDP was turned on.
> 
> Fix this by always allocating last queue in PF queue pile for a flow director
> VSI.
> 
> Fixes: 41c445ff0f48 ("i40e: main driver core")
> Signed-off-by: Sylwester Dziedziuch <sylwesterx.dziedziuch@intel.com>
> Signed-off-by: Mateusz Palczewski <mateusz.palczewski@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 

Tested-by: Kiran Bhandare <kiranx.bhandare@intel.com>  A Contingent Worker at Intel
