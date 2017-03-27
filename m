From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Mon, 27 Mar 2017 23:41:48 +0000
Subject: [Intel-wired-lan] [next PATCH S65 01/13] i40e: update error
 message when trying to add invalid filters
In-Reply-To: <20170327094759.58321-2-alice.michael@intel.com>
References: <20170327094759.58321-1-alice.michael@intel.com>
 <20170327094759.58321-2-alice.michael@intel.com>
Message-ID: <02874ECE860811409154E81DA85FBB5857DE7AB5@ORSMSX115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

ACK

> -----Original Message-----
> From: Michael, Alice
> Sent: Monday, March 27, 2017 2:48 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Keller, Jacob E <jacob.e.keller@intel.com>
> Subject: [next PATCH S65 01/13] i40e: update error message when trying to add
> invalid filters
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> Re-word the error message displayed when adding a filter with an
> invalid flow type. Additionally, report a distinct error message when
> the IPv4 protocol is at fault.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Change-ID: Iba3d85b87f8d383c97c8bdd180df34a6adf3ee67
> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> index ebffca0..d45f48c 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> @@ -533,14 +533,15 @@ int i40e_add_del_fdir(struct i40e_vsi *vsi,
>  			break;
>  		default:
>  			/* We cannot support masking based on protocol */
> -			goto unsupported_flow;
> +			dev_info(&pf->pdev->dev, "Unsupported IPv4 protocol
> 0x%02x\n",
> +				 input->ip4_proto);
> +			return -EINVAL;
>  		}
>  		break;
>  	default:
> -unsupported_flow:
> -		dev_info(&pf->pdev->dev, "Could not specify spec type %d\n",
> +		dev_info(&pf->pdev->dev, "Unsupported flow type 0x%02x\n",
>  			 input->flow_type);
> -		ret = -EINVAL;
> +		return -EINVAL;
>  	}
> 
>  	/* The buffer allocated here will be normally be freed by
> --
> 2.9.3

