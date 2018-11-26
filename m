From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 26 Nov 2018 23:34:47 +0000
Subject: [Intel-wired-lan] [PATCH 1/1] drivers/net/i40e: define proper
 net_device::neigh_priv_len
In-Reply-To: <20181123161028.22633-2-khorenko@virtuozzo.com>
References: <20181123161028.22633-1-khorenko@virtuozzo.com>
 <20181123161028.22633-2-khorenko@virtuozzo.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D32ACE0@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Konstantin Khorenko
> Sent: Friday, November 23, 2018 8:10 AM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
> Cc: netdev at vger.kernel.org; intel-wired-lan at lists.osuosl.org; linux-
> kernel at vger.kernel.org; Konstantin Khorenko <khorenko@virtuozzo.com>;
> David S . Miller <davem@davemloft.net>
> Subject: [Intel-wired-lan] [PATCH 1/1] drivers/net/i40e: define proper
> net_device::neigh_priv_len
> 
> Out of bound read reported by KASan.
> 
> i40iw_net_event() reads unconditionally 16 bytes from
> neigh->primary_key while the memory allocated for
> "neighbour" struct is evaluated in neigh_alloc() as
> 
>   tbl->entry_size + dev->neigh_priv_len
> 
> where "dev" is a net_device.
> 
> But the driver does not setup dev->neigh_priv_len and we read beyond the
> neigh entry allocated memory, so the patch in the next mail fixes this.
> 
> Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 3 +++
>  1 file changed, 3 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


