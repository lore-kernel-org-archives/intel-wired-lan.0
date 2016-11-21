From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 21 Nov 2016 17:53:11 +0000
Subject: [Intel-wired-lan] [next PATCH S54 09/15] i40e: fold
	the	i40e_is_vsi_in_vlan check into i40e_put_mac_in_vlan
In-Reply-To: <1478896779-13697-10-git-send-email-bimmy.pujari@intel.com>
References: <1478896779-13697-1-git-send-email-bimmy.pujari@intel.com>
 <1478896779-13697-10-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA383E5@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Friday, November 11, 2016 12:40 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S54 09/15] i40e: fold the
> i40e_is_vsi_in_vlan check into i40e_put_mac_in_vlan
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> Fold the check for determining when to call i40e_put_mac_in_vlan directly
> into the function so that we don't need to decide which function to use
> ahead of time. This allows us to just call i40e_put_mac_in_vlan directly
> without having to check ahead of time.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Change-ID: Ifff526940748ac14b8418be5df5a149502eed137
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c        | 11 ++++-------
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  8 ++------
>  2 files changed, 6 insertions(+), 13 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


