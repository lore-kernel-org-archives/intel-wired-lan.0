From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 10 Sep 2015 18:53:02 +0000
Subject: [Intel-wired-lan] [next PATCH S14 06/15] i40e: Convert CEE App
 TLV	selector to IEEE selector
In-Reply-To: <1441065295-234333-7-git-send-email-catherine.sullivan@intel.com>
References: <1441065295-234333-1-git-send-email-catherine.sullivan@intel.com>
 <1441065295-234333-7-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060A61FC@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Monday, August 31, 2015 4:55 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Bowers, Gregory J
> Subject: [Intel-wired-lan] [next PATCH S14 06/15] i40e: Convert CEE App TLV
> selector to IEEE selector
> 
> From: Greg Bowers <gregory.j.bowers@intel.com>
> 
> Changes the parsing of CEE App TLVs to fill in the App selector in struct
> i40e_dcbx_config with the IEEE App selector so the caller doesn't have to
> consider whether the App came from a CEE or IEEE DCBX negotiation.
> 
> Signed-off-by: Greg Bowers <gregory.j.bowers@intel.com>
> Change-ID: Ia7d9d664cde04d2ebcc9822fd22e4929c6edab3a
> ---
>  drivers/net/ethernet/intel/i40e/i40e_dcb.c  | 16 ++++++++++++----
> drivers/net/ethernet/intel/i40e/i40e_type.h |  2 ++
>  2 files changed, 14 insertions(+), 4 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code changes present in tree
