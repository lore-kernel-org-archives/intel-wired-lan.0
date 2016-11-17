From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 17 Nov 2016 20:41:39 +0000
Subject: [Intel-wired-lan] [next PATCH S53-V2 1/5] i40e: use unsigned
 printf	format specifier for active_filters count
In-Reply-To: <1479157609-30812-1-git-send-email-bimmy.pujari@intel.com>
References: <1479157609-30812-1-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA38044@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Monday, November 14, 2016 1:07 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S53-V2 1/5] i40e: use unsigned printf
> format specifier for active_filters count
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> Replace the %d specifier used for printing vsi->active_filters and
> vsi->promisc_threshold with an unsigned %u format specifier. While it is
> unlikely in practice that these values will ever reach such a large number they
> are unsigned values and thus should not be interpreted as negative
> numbers.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Change-ID: Iff050fad5a1c8537c4c57fcd527441cd95cfc0d4
> ---
> Testing-hints:
>   This should go upstream, even though it is in debugfs code. We're not
>   adding features but simply correcting output of existing features.
> 
>  drivers/net/ethernet/intel/i40e/i40e_debugfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


