From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 21 Sep 2016 17:24:42 +0000
Subject: [Intel-wired-lan] [next PATCH S47 7/9] i40e: group base mode
	VF	offload flags
In-Reply-To: <1473895479-23035-8-git-send-email-bimmy.pujari@intel.com>
References: <1473895479-23035-1-git-send-email-bimmy.pujari@intel.com>
 <1473895479-23035-8-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA0E50D@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Wednesday, September 14, 2016 4:25 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S47 7/9] i40e: group base mode VF
> offload flags
> 
> From: Preethi Banala <preethi.banala@intel.com>
> 
> Group together the minimum set of offload capabilities that are always
> supported by VF in base mode. This define would be used by PF to make
> sure VF in base mode gets minimum of base capabilities .
> 
> Signed-off-by: Preethi Banala <preethi.banala@intel.com>
> Change-ID: Id5e8f22ba169c8f0a38d22fc36b2cb531c02582c
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl.h   | 4 ++++
>  drivers/net/ethernet/intel/i40evf/i40e_virtchnl.h | 4 ++++
>  2 files changed, 8 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


