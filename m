From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 26 Oct 2016 22:21:35 +0000
Subject: [Intel-wired-lan] [next PATCH S51-V2 6/8] i40e: Add
	Clause22	implementation
In-Reply-To: <1477436933-13679-7-git-send-email-bimmy.pujari@intel.com>
References: <1477436933-13679-1-git-send-email-bimmy.pujari@intel.com>
 <1477436933-13679-7-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA292C2@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Tuesday, October 25, 2016 4:09 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Jared, Matthew A <matthew.a.jared@intel.com>; Kosiarz, Michal
> <michal.kosiarz@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S51-V2 6/8] i40e: Add Clause22
> implementation
> 
> From: Michal Kosiarz <michal.kosiarz@intel.com>
> 
> Some external PHYs require Clause22 method for accessing registers.
> This patch also adds some defines to support blink led on devices using
> 10CBaseT PHY.
> 
> Signed-off-by: Michal Kosiarz <michal.kosiarz@intel.com>
> Signed-off-by: Matt Jared <matthew.a.jared@intel.com>
> Change-ID: I868a4326911900f6c89e7e522fda4968b0825f14
> ---
>  drivers/net/ethernet/intel/i40e/i40e_common.c    | 180
> +++++++++++++++++------
>  drivers/net/ethernet/intel/i40e/i40e_prototype.h |  12 +-
>  drivers/net/ethernet/intel/i40e/i40e_type.h      |  19 ++-
>  3 files changed, 159 insertions(+), 52 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


