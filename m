From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 16 Dec 2016 22:48:40 +0000
Subject: [Intel-wired-lan] [next PATCH S57 11/11] i40e: mark the
	value	passed to csum_replace_by_diff as __wsum
In-Reply-To: <1481586257-28872-12-git-send-email-bimmy.pujari@intel.com>
References: <1481586257-28872-1-git-send-email-bimmy.pujari@intel.com>
 <1481586257-28872-12-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA49A1E@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH S57 11/11] i40e: mark the value
> passed to csum_replace_by_diff as __wsum
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> Fix, or rather, avoid a sparse warning caused by the fact that
> csum_replace_by_diff expects to receive a __wsum value. Since the
> calculation appears to work, simply typecast the passed paylen value to
> __wsum to avoid the warning.
> 
> This seems pretty fishy since __wsum was obviously annotated as a separate
> type on purpose, so this throws the entire calculation into question. Since it
> currently appears to behave as expected, the typecast is probably safe.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Change-ID: I4fdc5cddd589abc16098176e8a61127e761488f4
> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 5 +++--
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 5 +++--
>  2 files changed, 6 insertions(+), 4 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


