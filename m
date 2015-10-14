From: Allan, Bruce W <bruce.w.allan@intel.com>
Date: Wed, 14 Oct 2015 00:47:05 +0000
Subject: [Intel-wired-lan] [next-queue 10/17] fm10k: add TEB check
	to	fm10k_gre_is_nvgre
In-Reply-To: <1444779554-20464-10-git-send-email-jacob.e.keller@intel.com>
References: <1444779554-20464-1-git-send-email-jacob.e.keller@intel.com>
 <1444779554-20464-10-git-send-email-jacob.e.keller@intel.com>
Message-ID: <804857E1F29AAC47BF68C404FC60A1847EC51CF5@ORSMSX105.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next-queue 10/17] fm10k: add TEB check to
> fm10k_gre_is_nvgre
> 
> The NVGRE protocol should be run over transparent ethernet bridge
> protocol, so we should verify this in our check whether the GRE tunnel
> is NVGRE.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/fm10k/fm10k_main.c | 4 ++++

Care to update the copyright date in this file while you're already updating it?

>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_main.c
> b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
> index 746a1986690b..5dfcba72825d 100644
> --- a/drivers/net/ethernet/intel/fm10k/fm10k_main.c
> +++ b/drivers/net/ethernet/intel/fm10k/fm10k_main.c
> @@ -708,6 +708,10 @@ static struct ethhdr *fm10k_gre_is_nvgre(struct
> sk_buff *skb)
>  	if (nvgre_hdr->flags & FM10K_NVGRE_RESERVED0_FLAGS)
>  		return NULL;
> 
> +	/* verify protocol is transparent Ethernet bridging */
> +	if (nvgre_hdr->proto != htons(ETH_P_TEB))
> +		return NULL;
> +
>  	/* report start of ethernet header */
>  	if (nvgre_hdr->flags & NVGRE_TNI)
>  		return (struct ethhdr *)(nvgre_hdr + 1);
> --
> 2.6.1.264.gbab76a9
> 
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at lists.osuosl.org
> http://lists.osuosl.org/mailman/listinfo/intel-wired-lan
