From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 19 Jun 2015 21:03:30 -0700
Subject: [Intel-wired-lan] [net-next 03/10] fm10k: don't store sw_vid at
 reset
In-Reply-To: <1434757059-3384-3-git-send-email-jacob.e.keller@intel.com>
References: <1434757059-3384-1-git-send-email-jacob.e.keller@intel.com>
 <1434757059-3384-3-git-send-email-jacob.e.keller@intel.com>
Message-ID: <5584E612.1030001@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 06/19/2015 04:37 PM, Jacob Keller wrote:
> If we store the sw_vid at reset of PF, then we accidentally prevent the
> VF from receiving the message to update its default VID. This only
> occurs if the VF is created before the PF has come up, which is the
> standard way of creating VFs when using the module parameter.

The upstream driver doesn't have a module parameter for VFs.  It uses 
sysfs.  It isn't clear but can this issue occur if you use the sysfs?

> This fixes an issue where we request the incorrect MAC/VLAN
> combinations, and prevents us from accidentally reporting some frames as
> vlan tagged.
>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>   drivers/net/ethernet/intel/fm10k/fm10k_iov.c | 3 ---
>   1 file changed, 3 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_iov.c b/drivers/net/ethernet/intel/fm10k/fm10k_iov.c
> index 94571e6e790c..0e25a80417b9 100644
> --- a/drivers/net/ethernet/intel/fm10k/fm10k_iov.c
> +++ b/drivers/net/ethernet/intel/fm10k/fm10k_iov.c
> @@ -228,9 +228,6 @@ int fm10k_iov_resume(struct pci_dev *pdev)
>   		hw->iov.ops.set_lport(hw, vf_info, i,
>   				      FM10K_VF_FLAG_MULTI_CAPABLE);
>   
> -		/* assign our default vid to the VF following reset */
> -		vf_info->sw_vid = hw->mac.default_vid;
> -
>   		/* mailbox is disconnected so we don't send a message */
>   		hw->iov.ops.assign_default_mac_vlan(hw, vf_info);
>   

The patch itself looks fine.  I assume the Switch API will send a 
message to force us onto the correct VID if there is one already 
reserved for this VF.

I probably shouldn't have used the PF VLAN ID for the VFs anyway. Just 
letting the Switch API bounce a message through is a much better way to go.
