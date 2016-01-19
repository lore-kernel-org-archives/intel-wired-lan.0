From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 19 Jan 2016 23:44:12 +0000
Subject: [Intel-wired-lan] [v2 next PATCH S27 07/15] i40evf: Change
	vf	driver string to reflect all products i40evf supports
In-Reply-To: <1452732712-12248-8-git-send-email-joshua.a.hay@intel.com>
References: <1452732712-12248-1-git-send-email-joshua.a.hay@intel.com>
 <1452732712-12248-8-git-send-email-joshua.a.hay@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F98098B@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [v2 next PATCH S27 07/15] i40evf: Change vf driver
> string to reflect all products i40evf supports
> 
> From: Catherine Sullivan <catherine.sullivan@intel.com>
> 
> Change the driver string to 40-10 Gigabit instead of XL710/X710 for X722 and
> all future products.
> 
> Also update copyright year in file header.
> 
> Signed-off-by: Catherine Sullivan <catherine.sullivan@intel.com>
> Change-ID: I57fae656b36dc4eb682b2b7a054f8f48f3589149
> ---
> Testing Hints: Make sure the new driver string is in dmesg upon driver load.
> 
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied, driver shows updated information on load
