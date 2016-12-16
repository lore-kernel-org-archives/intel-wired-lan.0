From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 16 Dec 2016 22:32:26 +0000
Subject: [Intel-wired-lan] [next PATCH S57 07/11] i40e: refactor AQ
	CMD	buffer debug printing
In-Reply-To: <1481586257-28872-8-git-send-email-bimmy.pujari@intel.com>
References: <1481586257-28872-1-git-send-email-bimmy.pujari@intel.com>
 <1481586257-28872-8-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA499D9@ORSMSX104.amr.corp.intel.com>
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
> Cc: Brady, Alan <alan.brady@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S57 07/11] i40e: refactor AQ CMD
> buffer debug printing
> 
> From: Alan Brady <alan.brady@intel.com>
> 
> This patch refactors the '%*ph' printk format specifier to instead use the
> print_hex_dump function, as recommended by the '%*ph' documentation.
> This produces better/more standardized output.
> 
> Signed-off-by: Alan Brady <alan.brady@intel.com>
> Change-ID: Id56700b4e8abc40ff8c04bc8379e7df04cb4d6fd
> ---
>  drivers/net/ethernet/intel/i40e/i40e_common.c   | 19 ++++++++++++-------
>  drivers/net/ethernet/intel/i40evf/i40e_common.c | 19 ++++++++++++------
> -
>  2 files changed, 24 insertions(+), 14 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


