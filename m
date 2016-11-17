From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 17 Nov 2016 18:55:53 +0000
Subject: [Intel-wired-lan] [next PATCH S54 01/15] i40e: defeature
 support	for PTP L4 frame detection on XL710
In-Reply-To: <1478896779-13697-2-git-send-email-bimmy.pujari@intel.com>
References: <1478896779-13697-1-git-send-email-bimmy.pujari@intel.com>
 <1478896779-13697-2-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA37FB9@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Friday, November 11, 2016 12:39 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S54 01/15] i40e: defeature support for
> PTP L4 frame detection on XL710
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> A product decision has been made to defeature detection of PTP frames
> over L4 (UDP) on the XL710 MAC. Do not advertise support for L4
> timestamping.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Change-ID: I41fbb0f84ebb27c43e23098c08156f2625c6ee06
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h         |  1 +
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 15 +++++++++++++--
>  drivers/net/ethernet/intel/i40e/i40e_main.c    |  3 ++-
>  drivers/net/ethernet/intel/i40e/i40e_ptp.c     | 21 +++++++++++++++------
>  4 files changed, 31 insertions(+), 9 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
PTP detection no longer shown


