From: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
Date: Tue, 5 May 2020 02:44:17 +0000
Subject: [Intel-wired-lan] [PATCH net-next] ixgbe: fix
 signed-integer-overflow warning
In-Reply-To: <20200505024521.24635-1-xiexiuqi@huawei.com>
References: <20200505024521.24635-1-xiexiuqi@huawei.com>
Message-ID: <61CC2BC414934749BD9F5BF3D5D94044986886BA@ORSMSX112.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Xie XiuQi <xiexiuqi@huawei.com>
> Sent: Monday, May 4, 2020 19:45
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; davem at davemloft.net
> Cc: intel-wired-lan at lists.osuosl.org; netdev at vger.kernel.org; linux-
> kernel at vger.kernel.org
> Subject: [PATCH net-next] ixgbe: fix signed-integer-overflow warning
> 
> ubsan report this warning, fix it by adding a unsigned suffix.
> 
> UBSAN: signed-integer-overflow in
> drivers/net/ethernet/intel/ixgbe/ixgbe_common.c:2246:26
> 65535 * 65537 cannot be represented in type 'int'
> CPU: 21 PID: 7 Comm: kworker/u256:0 Not tainted 5.7.0-rc3-debug+ #39
> Hardware name: Huawei TaiShan 2280 V2/BC82AMDC, BIOS 2280-V2
> 03/27/2020
> Workqueue: ixgbe ixgbe_service_task [ixgbe] Call trace:
>  dump_backtrace+0x0/0x3f0
>  show_stack+0x28/0x38
>  dump_stack+0x154/0x1e4
>  ubsan_epilogue+0x18/0x60
>  handle_overflow+0xf8/0x148
>  __ubsan_handle_mul_overflow+0x34/0x48
>  ixgbe_fc_enable_generic+0x4d0/0x590 [ixgbe]
>  ixgbe_service_task+0xc20/0x1f78 [ixgbe]
>  process_one_work+0x8f0/0xf18
>  worker_thread+0x430/0x6d0
>  kthread+0x218/0x238
>  ret_from_fork+0x10/0x18
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Xie XiuQi <xiexiuqi@huawei.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Dave, I am picking this up.
