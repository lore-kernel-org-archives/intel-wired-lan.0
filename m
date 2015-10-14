From: Allan, Bruce W <bruce.w.allan@intel.com>
Date: Wed, 14 Oct 2015 00:46:51 +0000
Subject: [Intel-wired-lan] [next-queue 06/17] fm10k: Correct typecast
	in	fm10k_update_xc_addr_pf
In-Reply-To: <1444779554-20464-6-git-send-email-jacob.e.keller@intel.com>
References: <1444779554-20464-1-git-send-email-jacob.e.keller@intel.com>
 <1444779554-20464-6-git-send-email-jacob.e.keller@intel.com>
Message-ID: <804857E1F29AAC47BF68C404FC60A1847EC51CDB@ORSMSX105.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Jacob Keller
> Sent: Tuesday, October 13, 2015 4:39 PM
> To: Intel Wired LAN
> Subject: [Intel-wired-lan] [next-queue 06/17] fm10k: Correct typecast in
> fm10k_update_xc_addr_pf
> 
> Since the resultant data type of the mac_update.mac_upper field is u16,
> it does not make sense to typecast u8 variables to u32 first.

Care to update the copyright date in this file while you're already updating it?

> 
> Reported-by: Matthew Vick <matthew.vick@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/fm10k/fm10k_pf.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
> b/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
> index 8c0bdc4e4edd..789ffd9d7fd9 100644
> --- a/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
> +++ b/drivers/net/ethernet/intel/fm10k/fm10k_pf.c
> @@ -334,8 +334,8 @@ static s32 fm10k_update_xc_addr_pf(struct
> fm10k_hw *hw, u16 glort,
>  						 ((u32)mac[3] << 16) |
>  						 ((u32)mac[4] << 8) |
>  						 ((u32)mac[5]));
> -	mac_update.mac_upper = cpu_to_le16(((u32)mac[0] << 8) |
> -						 ((u32)mac[1]));
> +	mac_update.mac_upper = cpu_to_le16(((u16)mac[0] << 8) |
> +					   ((u16)mac[1]));
>  	mac_update.vlan = cpu_to_le16(vid);
>  	mac_update.glort = cpu_to_le16(glort);
>  	mac_update.action = add ? 0 : 1;
> --
> 2.6.1.264.gbab76a9
> 
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at lists.osuosl.org
> http://lists.osuosl.org/mailman/listinfo/intel-wired-lan
