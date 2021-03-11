From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Thu, 11 Mar 2021 12:32:29 -0800
Subject: [Intel-wired-lan] [RFC PATCH 02/10] intel: Update drivers to
 use ethtool_gsprintf
In-Reply-To: <161542652605.13546.13143472024905128153.stgit@localhost.localdomain>
References: <161542634192.13546.4185974647834631704.stgit@localhost.localdomain>
 <161542652605.13546.13143472024905128153.stgit@localhost.localdomain>
Message-ID: <20210311123229.00007580@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Alexander Duyck wrote:

> From: Alexander Duyck <alexanderduyck@fb.com>
> 
> Update the Intel drivers to make use of ethtool_gsprintf. The general idea
> is to reduce code size and overhead by replacing the repeated pattern of
> string printf statements and ETH_STRING_LEN counter increments.
> 
> Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c   |   16 ++----
>  drivers/net/ethernet/intel/ice/ice_ethtool.c     |   55 +++++++---------------
>  drivers/net/ethernet/intel/igb/igb_ethtool.c     |   40 ++++++----------
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c |   40 ++++++----------
>  4 files changed, 50 insertions(+), 101 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> index c70dec65a572..932c6635cfd6 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
> @@ -2368,21 +2368,15 @@ static void i40e_get_priv_flag_strings(struct net_device *netdev, u8 *data)
>  	struct i40e_netdev_priv *np = netdev_priv(netdev);
>  	struct i40e_vsi *vsi = np->vsi;
>  	struct i40e_pf *pf = vsi->back;
> -	char *p = (char *)data;
> +	u8 *p = data;
>  	unsigned int i;

As Jakub said, RCT... :-)

no other comments on the rest of the patch, looks good and Thanks!
