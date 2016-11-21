From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 21 Nov 2016 17:54:08 +0000
Subject: [Intel-wired-lan] [next PATCH S54 10/15] i40e: no need to
	check	is_vsi_in_vlan before calling i40e_del_mac_all_vlan
In-Reply-To: <1478896779-13697-11-git-send-email-bimmy.pujari@intel.com>
References: <1478896779-13697-1-git-send-email-bimmy.pujari@intel.com>
 <1478896779-13697-11-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA383F1@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH S54 10/15] i40e: no need to check
> is_vsi_in_vlan before calling i40e_del_mac_all_vlan
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> This function won't be appreciably slower when in VLAN mode, so there is no
> real reason to not just call it directly. In either case, we still must search the
> full table for a MAC/VLAN pair. We do get to stop searching a tiny bit early in
> the case of knowing we are not in VLAN mode, but this is a minor savings and
> we can avoid the code complexity by not having to worry about the check.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Change-ID: I533412195b3a42f51cf629e3675dd5145aea8625
> ---
> Testing-hints:
>   Add and delete many MAC filters with and without VLANs.
> 
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


