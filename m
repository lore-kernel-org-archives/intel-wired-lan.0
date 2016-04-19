From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 19 Apr 2016 22:11:14 +0000
Subject: [Intel-wired-lan] [PATCH next S35 v3 6/9] i40evf: refactor
 receive	routine
In-Reply-To: <1461004429-34316-7-git-send-email-jesse.brandeburg@intel.com>
References: <1461004429-34316-1-git-send-email-jesse.brandeburg@intel.com>
 <1461004429-34316-2-git-send-email-jesse.brandeburg@intel.com>
 <1461004429-34316-3-git-send-email-jesse.brandeburg@intel.com>
 <1461004429-34316-4-git-send-email-jesse.brandeburg@intel.com>
 <1461004429-34316-5-git-send-email-jesse.brandeburg@intel.com>
 <1461004429-34316-6-git-send-email-jesse.brandeburg@intel.com>
 <1461004429-34316-7-git-send-email-jesse.brandeburg@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9D2396@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Jesse Brandeburg
> Sent: Monday, April 18, 2016 11:34 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH next S35 v3 6/9] i40evf: refactor receive
> routine
> 
> This is part 2 of the rx refactor series, just including changes to i40evf.
> 
> This refactor aligns the receive routine with the one in ixgbe which was highly
> optimized.  This reduces the code we have to maintain and allows for
> (hopefully) more readable and maintainable RX hot path.
> 
> In order to do this:
> - consolidate the receive path into a single function that doesn't
>   use packet split but *does* use pages for rx buffers.
> - remove the old _1buf routine
> - consolidate several routines into helper functions
> - remove VF ethtool control over packet split
> - remove priv_flags interface since it is unused
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
> v3: move dma sync into always used path
>     move setting of rx queue into process skb fields
> 
> v2: code was split into more reviewable chunks
>     priv_flags interface was removed
> ---
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c      | 898 +++++++++++---------
> -
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.h      |  37 +-
>  drivers/net/ethernet/intel/i40evf/i40evf.h         |   5 -
>  drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c |  51 --
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c    |   3 +-
>  5 files changed, 481 insertions(+), 513 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Changes present in code, traffic passes normally
