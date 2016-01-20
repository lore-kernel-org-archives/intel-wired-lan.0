From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 20 Jan 2016 00:22:35 +0000
Subject: [Intel-wired-lan] [next PATCH S27 10/15] i40e: dump
	descriptor	indexes in hex
In-Reply-To: <1452554307-20937-11-git-send-email-joshua.a.hay@intel.com>
References: <1452554307-20937-1-git-send-email-joshua.a.hay@intel.com>
 <1452554307-20937-11-git-send-email-joshua.a.hay@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9809AF@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Joshua Hay
> Sent: Monday, January 11, 2016 3:18 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S27 10/15] i40e: dump descriptor
> indexes in hex
> 
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> The debugging helpers for showing descriptor rings were dumping the
> indexes in decimal and the offsets in hex.
> 
> Put everything in hex and at least be consistent.
> 
> Also update copyright year in file header.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Change-ID: Ia35a21411a2ddb713772dffb4e8718889fcfc895
> ---
> Testing Hints: echo dump desc rx <vsi> 0 > command
> 
>  drivers/net/ethernet/intel/i40e/i40e_debugfs.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied, dump is entirely in hexadecimal
