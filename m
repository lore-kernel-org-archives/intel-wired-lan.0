From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 29 Jul 2016 17:26:07 +0000
Subject: [Intel-wired-lan] [next PATCH S40-V2 11/12] i40e: Allow RSS
 Hash	set with less than four parameters
In-Reply-To: <1469646161-30024-12-git-send-email-bimmy.pujari@intel.com>
References: <1469646161-30024-1-git-send-email-bimmy.pujari@intel.com>
 <1469646161-30024-12-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9EB979@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Wednesday, July 27, 2016 12:03 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S40-V2 11/12] i40e: Allow RSS Hash set
> with less than four parameters
> 
> From: Carolyn Wyborny <carolyn.wyborny@intel.com>
> 
> This patch implements a feature change which allows using ethtool to set rss
> hash opts using less than four parameters if desired.
> 
> Signed-off-by: Carolyn Wyborny <carolyn.wyborny@intel.com>
> Signed-off-by: Kiran Patil <kiran.patil@intel.com>
> Change-ID: I0fbb91255d81e997c456697c21ac39cc9754821b
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h         |   3 -
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 208 +++++++++++++++----
> ------
>  2 files changed, 130 insertions(+), 81 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Able to set with less than 4 parameters
