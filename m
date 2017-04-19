From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Wed, 19 Apr 2017 20:47:58 +0000
Subject: [Intel-wired-lan] [PATCH net-next] i40evf: hide unused variable
In-Reply-To: <20170419173008.3648215-1-arnd@arndb.de>
References: <20170419173008.3648215-1-arnd@arndb.de>
Message-ID: <02874ECE860811409154E81DA85FBB5857E088EB@ORSMSX115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd at arndb.de]
> Sent: Wednesday, April 19, 2017 10:30 AM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
> Cc: Arnd Bergmann <arnd@arndb.de>; Pujari, Bimmy
> <bimmy.pujari@intel.com>; Duyck, Alexander H
> <alexander.h.duyck@intel.com>; Williams, Mitch A
> <mitch.a.williams@intel.com>; Keller, Jacob E <jacob.e.keller@intel.com>; Brady,
> Alan <alan.brady@intel.com>; Joe Perches <joe@perches.com>; Singhai, Anjali
> <anjali.singhai@intel.com>; Brandeburg, Jesse <jesse.brandeburg@intel.com>;
> Banala, Preethi <preethi.banala@intel.com>; intel-wired-lan at lists.osuosl.org;
> netdev at vger.kernel.org; linux-kernel at vger.kernel.org
> Subject: [PATCH net-next] i40evf: hide unused variable
> 
> On architectures with larger pages, we get a warning about an unused variable:
> 
> drivers/net/ethernet/intel/i40evf/i40evf_main.c: In function
> 'i40evf_configure_rx':
> drivers/net/ethernet/intel/i40evf/i40evf_main.c:690:21: error: unused variable
> 'netdev' [-Werror=unused-variable]
> 
> This moves the declaration into the #ifdef to avoid the warning.
> 

Makes sense.

Acked-by: Jacob Keller <jacob.e.keller@intel.com>

> Fixes: dab86afdbbd1 ("i40e/i40evf: Change the way we limit the maximum frame
> size for Rx")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
> b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
> index 12a930e879af..1bb13c864edd 100644
> --- a/drivers/net/ethernet/intel/i40evf/i40evf_main.c
> +++ b/drivers/net/ethernet/intel/i40evf/i40evf_main.c
> @@ -687,13 +687,14 @@ static void i40evf_configure_tx(struct i40evf_adapter
> *adapter)
>  static void i40evf_configure_rx(struct i40evf_adapter *adapter)
>  {
>  	unsigned int rx_buf_len = I40E_RXBUFFER_2048;
> -	struct net_device *netdev = adapter->netdev;
>  	struct i40e_hw *hw = &adapter->hw;
>  	int i;
> 
>  	/* Legacy Rx will always default to a 2048 buffer size. */
>  #if (PAGE_SIZE < 8192)
>  	if (!(adapter->flags & I40EVF_FLAG_LEGACY_RX)) {
> +		struct net_device *netdev = adapter->netdev;
> +
>  		/* For jumbo frames on systems with 4K pages we have to use
>  		 * an order 1 page, so we might as well increase the size
>  		 * of our Rx buffer to make better use of the available space
> --
> 2.9.0

