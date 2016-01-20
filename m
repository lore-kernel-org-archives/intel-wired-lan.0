From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 20 Jan 2016 00:23:47 +0000
Subject: [Intel-wired-lan] [v2 next PATCH S27 11/15] i40e/i40evf:
	use	__GFP_NOWARN
In-Reply-To: <1452732712-12248-12-git-send-email-joshua.a.hay@intel.com>
References: <1452732712-12248-1-git-send-email-joshua.a.hay@intel.com>
 <1452732712-12248-12-git-send-email-joshua.a.hay@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9809C0@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Joshua Hay
> Sent: Wednesday, January 13, 2016 4:52 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [v2 next PATCH S27 11/15] i40e/i40evf: use
> __GFP_NOWARN
> 
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> The i40e and i40evf drivers now cleanly handle allocation failures and can
> avoid kernel log spew from the memory allocator when allocations fail, so set
> __GFP_NOWARN on rx buffer alloc.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Change-ID: Ic9e1b83c495e2a3ef6b069ba7fb6e52ce134cd23
> ---
> Testing Hints: compile everywhere
> 
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 12 ++++++++----
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 12 ++++++++----
>  2 files changed, 16 insertions(+), 8 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied, compiles cleanly
