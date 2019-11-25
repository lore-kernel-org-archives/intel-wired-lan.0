From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Mon, 25 Nov 2019 14:32:23 +0100
Subject: [Intel-wired-lan] [PATCH v2] ixgbevf: Remove limit of 10
 entries for unicast filter list
In-Reply-To: <20191125142452.21819-1-radoslawx.tyl@intel.com>
References: <20191125142452.21819-1-radoslawx.tyl@intel.com>
Message-ID: <7e9bbd9b-ee05-b207-a472-77d03c3ee6ac@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Radoslaw,


On 2019-11-25 15:24, Radoslaw Tyl wrote:
> Currently, though the FDB entry is added to VF, it does not appear in
> RAR filters. VF driver only allows to add 10 entries. Attempting to add
> another causes an error. This patch removes limitation and allows use of
> all free RAR entries for the FDB if needed.

I still wonder, why the limit was introduced in the first place.
gregory.v.rose at intel.com bounces, so we can?t ask.

> Fixes: 46ec20ff7d ("ixgbevf: Add macvlan support in the set rx mode op")
> 
> Signed-off-by: Radoslaw Tyl <radoslawx.tyl@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> index 076f2da36f27..64ec0e7c64b4 100644
> --- a/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> +++ b/drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c
> @@ -2081,11 +2081,6 @@ static int ixgbevf_write_uc_addr_list(struct net_device *netdev)
>  	struct ixgbe_hw *hw = &adapter->hw;
>  	int count = 0;
>  
> -	if ((netdev_uc_count(netdev)) > 10) {
> -		pr_err("Too many unicast filters - No Space\n");
> -		return -ENOSPC;
> -	}
> -
>  	if (!netdev_uc_empty(netdev)) {
>  		struct netdev_hw_addr *ha;

Acked-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/pkcs7-signature
Size: 5174 bytes
Desc: S/MIME Cryptographic Signature
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20191125/27e30d36/attachment.p7s>
