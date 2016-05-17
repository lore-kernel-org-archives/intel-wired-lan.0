From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 17 May 2016 16:47:18 +0000
Subject: [Intel-wired-lan] [next PATCH S37 09/15] i40e: fix missing DA
 cable	check
In-Reply-To: <1463419605-30746-10-git-send-email-bimmy.pujari@intel.com>
References: <1463419605-30746-1-git-send-email-bimmy.pujari@intel.com>
 <1463419605-30746-10-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9D68C2@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Monday, May 16, 2016 10:27 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Kong, Serey <serey.kong@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S37 09/15] i40e: fix missing DA cable
> check
> 
> From: Serey Kong <serey.kong@intel.com>
> 
> When a Direct Attach (DA) cable is used, if the i40e_set_settings function is
> called it would return an error. Add the DA type so the function won't fail.
> 
> Signed-off-by: Serey Kong <serey.kong@intel.com>
> Change-ID: I2b802f27a5d91cfefa72fd1f852acb4d74647a8e
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 1 +
>  1 file changed, 1 insertion(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
DA cable correctly identified
