From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Mon, 25 Nov 2019 12:19:29 +0100
Subject: [Intel-wired-lan] [PATCH] ixgbevf: Removing limit of 10 entries
 for unicast filter list
In-Reply-To: <20191125095533.40157-1-radoslawx.tyl@intel.com>
References: <20191125095533.40157-1-radoslawx.tyl@intel.com>
Message-ID: <85ab58a0-09f0-9efa-0f9f-5fa3641afbae@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Radoslaw,


Thank you for your patch.

Some small nit-picks.

Use imperative mood in the subject line:

> Remove limit of 10 entries for unicast filter list

On 2019-11-25 10:55, Radoslaw Tyl wrote:
> Currently, though the FDB entry is added to VF, it does not appear in
> RAR filters. VF driver allows add only 10 entries. Attempting to add

VF driver only allows to add 10 entries.
VF driver only allows 10 entries.

> another causes an error. This patch removed limitation and allow use of

s/removed/removes the/
allow*s*

> all free RAR entries for the FDB if needed.

So, the check is added in commit 46ec20ff7d (ixgbevf: Add macvlan support
in the set rx mode op). Greg, could you please enlighten us for the
reasoning for the ten entries limit? Radoslaw, why do you think the limit
can be safely removed?

Radoslaw, please add

> Fixes: 46ec20ff7d ("ixgbevf: Add macvlan support in the set rx mode op")

to the commit message.

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


Kind regards,

Paul

-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/pkcs7-signature
Size: 5174 bytes
Desc: S/MIME Cryptographic Signature
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20191125/4c41f2bb/attachment.p7s>
