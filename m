From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Fri, 10 Sep 2021 01:50:38 +0000
Subject: [Intel-wired-lan] [PATCH 1/2] e100: fix length calculation in
 e100_get_regs_len
In-Reply-To: <20210908175237.3058574-1-jacob.e.keller@intel.com>
References: <20210908175237.3058574-1-jacob.e.keller@intel.com>
Message-ID: <115098a3-89c5-f041-d15e-6fdd3665fabe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 9/8/2021 10:52 AM, Keller, Jacob E wrote:
> commit abf9b902059f ("e100: cleanup unneeded math") tried to simplify
> e100_get_regs_len and remove a double 'divide and then multiply'
> calculation that the e100_reg_regs_len function did.
> 
> This change broke the size calculation entirely as it failed to account
> for the fact that the numbered registers are actually 4 bytes wide and
> not 1 byte. This resulted in a significant under allocation of the
> register buffer used by e100_get_regs.
> 
> Fix this by properly multiplying the register count by u32 first before
> adding the size of the dump buffer.
> 
> Fixes: abf9b902059f ("e100: cleanup unneeded math")
> Reported-by: Felicitas Hetzelt <felicitashetzelt@gmail.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/e100.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/e100.c b/drivers/net/ethernet/intel/e100.c
> index 373eb027b925..588a59546d12 100644
> --- a/drivers/net/ethernet/intel/e100.c
> +++ b/drivers/net/ethernet/intel/e100.c
> @@ -2441,7 +2441,11 @@ static void e100_get_drvinfo(struct net_device *netdev,
>  static int e100_get_regs_len(struct net_device *netdev)
>  {
>  	struct nic *nic = netdev_priv(netdev);
> -	return 1 + E100_PHY_REGS + sizeof(nic->mem->dump_buf);
> +
> +	/* We know the number of registers, and the size of the dump buffer.
> +	 * Calculate the total size in bytes.
> +	 */
> +	return (1 + E100_PHY_REGS) * sizeof(u32) + sizeof(nic->mem->dump_buf);
>  }
>  
>  static void e100_get_regs(struct net_device *netdev,
> 

For what it's worth, without this applied, CONFIG_KASAN shows something
along these lines:

> [   65.615306] ==================================================================
> [   65.615564] BUG: KASAN: vmalloc-out-of-bounds in dev_ethtool+0x1c30/0x3280
> [   65.615806] Write of size 596 at addr ffffc900001f1078 by task ethtool/1044
> 
> [   65.616070] CPU: 9 PID: 1044 Comm: ethtool Not tainted 5.14.0 #1
> [   65.616246] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-4.fc34 04/01/2014
> [   65.616486] Call Trace:
> [   65.616581]  dump_stack_lvl+0x46/0x5a
> [   65.616752]  print_address_description.constprop.0+0x1f/0x140
> [   65.616959]  ? dev_ethtool+0x1c30/0x3280
> [   65.617079]  kasan_report.cold+0x7f/0x11b
> [   65.617228]  ? dev_ethtool+0x1c30/0x3280
> [   65.617349]  kasan_check_range+0xf5/0x1d0
> [   65.617478]  memcpy+0x39/0x60
> [   65.617580]  dev_ethtool+0x1c30/0x3280
> [   65.617716]  ? ethtool_get_module_info_call+0xf0/0xf0
> [   65.617868]  ? post_alloc_hook+0xd9/0x120
> [   65.617995]  ? stack_trace_save+0x81/0xa0
> [   65.618127]  ? inet_ioctl+0x132/0x2c0
> [   65.618259]  ? inet_compat_ioctl+0x80/0x80
> [   65.618385]  ? avc_ss_reset+0xb0/0xb0
> [   65.618514]  ? cgroup_rstat_updated+0x61/0x180
> [   65.618669]  ? __alloc_pages_slowpath.constprop.0+0x1210/0x1210
> [   65.618852]  ? mutex_lock+0x7e/0xb0
> [   65.618981]  ? __mutex_lock_slowpath+0x10/0x10
> [   65.619124]  dev_ioctl+0x1b0/0x5c0
> [   65.619242]  sock_do_ioctl+0x146/0x1f0
> [   65.619369]  ? sock_alloc_file+0xd0/0xd0
> [   65.619486]  ? __handle_mm_fault+0x1201/0x1c00
> [   65.619629]  ? vm_iomap_memory+0xe0/0xe0
> [   65.619763]  ? userfaultfd_unmap_complete+0x7d/0x1c0
> [   65.619927]  sock_ioctl+0x332/0x430
> [   65.620044]  ? vlan_ioctl_set+0x30/0x30
> [   65.620162]  ? rwsem_mark_wake+0x460/0x460
> [   65.620291]  ? handle_mm_fault+0x17f/0x370
> [   65.620427]  __x64_sys_ioctl+0xb9/0xf0
> [   65.620541]  do_syscall_64+0x3b/0x90
> [   65.620672]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [   65.620823] RIP: 0033:0x7f1504b1a0ab
> [   65.620933] Code: ff ff ff 85 c0 79 9b 49 c7 c4 ff ff ff ff 5b 5d 4c 89 e0 41 5c c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 9d bd 0c 00 f7 d8 64 89 01 48
> [   65.621422] RSP: 002b:00007fff451d5428 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> [   65.621650] RAX: ffffffffffffffda RBX: 00007fff451d56d0 RCX: 00007f1504b1a0ab
> [   65.621843] RDX: 00007fff451d56e0 RSI: 0000000000008946 RDI: 0000000000000003
> [   65.626946] RBP: 0000000000000271 R08: 0000562b6f8442a0 R09: 00007f1504be6a60
> [   65.631874] R10: fffffffffffff000 R11: 0000000000000246 R12: 00007fff451d5580
> [   65.635136] R13: 0000562b6d9538a0 R14: 00007fff451d56e0 R15: 0000000000000000
> 
> 
> [   65.643571] Memory state around the buggy address:
> [   65.645605]  ffffc900001f1100: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [   65.647666]  ffffc900001f1180: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [   65.649692] >ffffc900001f1200: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01 f8
> [   65.651548]                                                              ^
> [   65.652882]  ffffc900001f1280: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
> [   65.654243]  ffffc900001f1300: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
> [   65.655586] ==================================================================
With just this applied, the problem isn't fully resolved. However, I
really do think these are "separate" fixes. If desired, I'm happy to
merge them together.
