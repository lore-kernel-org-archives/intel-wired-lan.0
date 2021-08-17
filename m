From: Penigalapati, Sandeep <sandeep.penigalapati@intel.com>
Date: Tue, 17 Aug 2021 10:39:26 +0000
Subject: [Intel-wired-lan] [PATCH net] ixgbe,
 xsk: clean up the resources in ixgbe_xsk_pool_enable error path
In-Reply-To: <20210607122644.59021-1-wanghai38@huawei.com>
References: <20210607122644.59021-1-wanghai38@huawei.com>
Message-ID: <MW3PR11MB45541B749D1F9773C19E7B749CFE9@MW3PR11MB4554.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

>-----Original Message-----
>From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
>Wang Hai
>Sent: Monday, June 7, 2021 5:57 PM
>To: Brandeburg, Jesse <jesse.brandeburg@intel.com>; Nguyen, Anthony L
><anthony.l.nguyen@intel.com>; davem at davemloft.net; ast at kernel.org;
>kuba at kernel.org; daniel at iogearbox.net; hawk at kernel.org;
>john.fastabend at gmail.com; jeffrey.t.kirsher at intel.com; Sokolowski, Jan
><jan.sokolowski@intel.com>; Karlsson, Magnus
><magnus.karlsson@intel.com>
>Cc: netdev at vger.kernel.org; bpf at vger.kernel.org; intel-wired-
>lan at lists.osuosl.org; linux-kernel at vger.kernel.org
>Subject: [Intel-wired-lan] [PATCH net] ixgbe, xsk: clean up the resources in
>ixgbe_xsk_pool_enable error path
>
>In ixgbe_xsk_pool_enable(), if ixgbe_xsk_wakeup() fails, We should restore
>the previous state and clean up the resources. Add the missing clear
>af_xdp_zc_qps and unmap dma to fix this bug.
>
>Fixes: d49e286d354e ("ixgbe: add tracking of AF_XDP zero-copy state for each
>queue pair")
>Fixes: 4a9b32f30f80 ("ixgbe: fix potential RX buffer starvation for AF_XDP")
>Signed-off-by: Wang Hai <wanghai38@huawei.com>
>---
> drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c | 5 ++++-
> 1 file changed, 4 insertions(+), 1 deletion(-)
>
Tested-by: Sandeep Penigalapati <sandeep.penigalapati@intel.com>
