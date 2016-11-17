From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 17 Nov 2016 18:06:47 +0000
Subject: [Intel-wired-lan] [next PATCH S52-V2 10/15] i40e: simplify txd
 use	count calculation
In-Reply-To: <1478639119-14656-11-git-send-email-bimmy.pujari@intel.com>
References: <1478639119-14656-1-git-send-email-bimmy.pujari@intel.com>
 <1478639119-14656-11-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA37F13@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Tuesday, November 08, 2016 1:05 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S52-V2 10/15] i40e: simplify txd use
> count calculation
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> The i40e_txd_use_count function was fast but confusing. In the comments,
> it even admits that it's ugly. So replace it with a new function that is
> (very) slightly faster and has extensive commenting to help the thicker
> among us (including the author, who will forget in a week) understand how it
> works.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> Change-ID: Ifb533f13786a0bf39cb29f77969a5be2c83d9a87
> ---
> Testing Hints : Lots and lots of TSO with various data sizes. This should
> operate exactly as before, with no noticeable performance change.
> 
>  drivers/net/ethernet/intel/i40e/i40e_txrx.h   | 45 +++++++++++++++++-----
> -----
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.h | 45 +++++++++++++++++----
> ------
>  2 files changed, 56 insertions(+), 34 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
No performance degradation with various packet sizes
