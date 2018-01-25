From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Thu, 25 Jan 2018 16:32:15 +0000
Subject: [Intel-wired-lan] [PATCH 2/2] fm10k: fix incorrect warning for
 function prototype
In-Reply-To: <20180116192052.7451-2-jacob.e.keller@intel.com>
References: <20180116192052.7451-1-jacob.e.keller@intel.com>
 <20180116192052.7451-2-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E64BC3C09@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On Behalf
> Of Jacob Keller
> Sent: Tuesday, January 16, 2018 11:21 AM
> To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
> Subject: [Intel-wired-lan] [PATCH 2/2] fm10k: fix incorrect warning for function
> prototype
> 
> Recent kernels now complain about incorrect function prototype comments,
> in order to ensure comments are accurate to the function. However, it
> incorrectly associates the comment above the fm10k_pci_tbl[] as
> a function header comment. Fix this by removing the extra "*" in the
> comment. This normally indicates that the function is a doxygen style
> function header comment.
> 
> Once removed, the logic no longer kicks in and the following warning is
> fixed:
> 
>   warning: cannot understand function prototype: 'const struct pci_device_id
> fm10k_pci_tbl[] = '
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/fm10k/fm10k_pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
> b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
> index d7aad4cb73a7..50f53e403ef5 100644
> --- a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
> +++ b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
> @@ -29,7 +29,7 @@ static const struct fm10k_info *fm10k_info_tbl[] = {
>  	[fm10k_device_vf] = &fm10k_vf_info,
>  };
> 
> -/**
> +/*
>   * fm10k_pci_tbl - PCI Device ID Table
>   *
>   * Wildcard entries (PCI_ANY_ID) should come last
> --
> 2.15.1.478.ga1e07cd25f8b
> 
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan

Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>

