From: Wyborny, Carolyn <carolyn.wyborny@intel.com>
Date: Tue, 6 Sep 2016 20:10:04 +0000
Subject: [Intel-wired-lan] [next PATCH S45 04/10] i40e: Remove 100
	Mbps	SGMII support for X722
In-Reply-To: <1473190807-26377-5-git-send-email-bimmy.pujari@intel.com>
References: <1473190807-26377-1-git-send-email-bimmy.pujari@intel.com>
 <1473190807-26377-5-git-send-email-bimmy.pujari@intel.com>
Message-ID: <9BBC4E0CF881AA4299206E2E1412B6265026F29D@ORSMSX102.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Harshitha,

Can you provide a better commit message that better follows the usual format.  8-)

Thanks,

Carolyn

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Tuesday, September 06, 2016 12:40 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S45 04/10] i40e: Remove 100 Mbps
> SGMII support for X722
> 
> From: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
> 
> X722 devices do not support 100 Mbps on SGMII. Hence, don't set
> that flag.
> 
> Signed-off-by: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
> Change-ID: I8c3d7c4251a9402d98994ed29749b7b895a0f205
> ---
> Testing Hints: Test on Copperpeak that 100 Mbps is not listed as
> supported or advertised on ethtool. Also ensure we are not able
> to configure the speed to 100 Mbps.
> 
> HSD-number: 10021180
> 
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c
> b/drivers/net/ethernet/intel/i40e/i40e_main.c
> index 68c1253..e83b317 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_main.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
> @@ -8591,7 +8591,6 @@ static int i40e_sw_init(struct i40e_pf *pf)
>  			     I40E_FLAG_WB_ON_ITR_CAPABLE |
>  			     I40E_FLAG_MULTIPLE_TCP_UDP_RSS_PCTYPE |
>  			     I40E_FLAG_NO_PCI_LINK_CHECK |
> -			     I40E_FLAG_100M_SGMII_CAPABLE |
>  			     I40E_FLAG_USE_SET_LLDP_MIB |
>  			     I40E_FLAG_GENEVE_OFFLOAD_CAPABLE;
>  	} else if ((pf->hw.aq.api_maj_ver > 1) ||
> --
> 2.4.11
> 
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at lists.osuosl.org
> http://lists.osuosl.org/mailman/listinfo/intel-wired-lan
