From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 25 Aug 2016 14:47:49 +0000
Subject: [Intel-wired-lan] [next PATCH S44 2/6] i40e: fix "dump
	port"	command when NPAR enabled
In-Reply-To: <1472063631-9033-3-git-send-email-bimmy.pujari@intel.com>
References: <1472063631-9033-1-git-send-email-bimmy.pujari@intel.com>
 <1472063631-9033-3-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9FAB0A@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Wednesday, August 24, 2016 11:34 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Brady, Alan <alan.brady@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S44 2/6] i40e: fix "dump port"
> command when NPAR enabled
> 
> From: Alan Brady <alan.brady@intel.com>
> 
> When using the debugfs to issue the "dump port" command with NPAR
> enabled, the firmware reports back with invalid argument.
> 
> The issue occurs because the pf->mac_seid was used to perform the query.
> This is fine when NPAR is disabled because the switch ID == pf->mac_seid,
> however this is not the case when NPAR is enabled.  This fix instead goes
> through the VSI to determine the correct ID to use in either case.
> 
> HSD-number: 7661076
> 
> Signed-off-by: Alan Brady <alan.brady@intel.com>
> Change-ID: I0cd67913a7f2c4a2962e06d39e32e7447cc55b6a
> ---
>  drivers/net/ethernet/intel/i40e/i40e_debugfs.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


