From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 16 Dec 2016 22:40:55 +0000
Subject: [Intel-wired-lan] [next PATCH S57 09/11] i40e: properly
	convert	le16 value to CPU format
In-Reply-To: <1481586257-28872-10-git-send-email-bimmy.pujari@intel.com>
References: <1481586257-28872-1-git-send-email-bimmy.pujari@intel.com>
 <1481586257-28872-10-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA499FA@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Monday, December 12, 2016 3:44 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S57 09/11] i40e: properly convert le16
> value to CPU format
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> This ensures that the pvid which is stored in __le16 format is converted to
> the CPU format. This will fix comparison issues on Big Endian platforms.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Change-ID: I92c80d1315dc2a0f9f095d5a0c48d461beb052ed
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


