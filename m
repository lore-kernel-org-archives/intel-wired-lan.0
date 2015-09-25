From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 25 Sep 2015 22:37:10 +0000
Subject: [Intel-wired-lan] [next PATCH 1/2] i40e: Move i40e_get_head
 into	header file
In-Reply-To: <1443123783-86802-1-git-send-email-catherine.sullivan@intel.com>
References: <1443123783-86802-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060B1ADC@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Thursday, September 24, 2015 12:43 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH 1/2] i40e: Move i40e_get_head into
> header file
> 
> From: Kiran Patil <kiran.patil@intel.com>
> 
> i40e_get_head needs to be called in multiple files in a further patch, prepare
> by moving the function into a header file.
> 
> Signed-off-by: Kiran Patil <kiran.patil@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c | 13 -------------
> drivers/net/ethernet/intel/i40e/i40e_txrx.h | 14 ++++++++++++++
>  2 files changed, 14 insertions(+), 13 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code changes present in tree
