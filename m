From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 20 Jan 2016 18:40:22 +0000
Subject: [Intel-wired-lan] [v2 next PATCH S27 13/15] i40e/i40evf:
	use	logical operators, not bitwise
In-Reply-To: <1452732712-12248-14-git-send-email-joshua.a.hay@intel.com>
References: <1452732712-12248-1-git-send-email-joshua.a.hay@intel.com>
 <1452732712-12248-14-git-send-email-joshua.a.hay@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F988B57@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [v2 next PATCH S27 13/15] i40e/i40evf: use logical
> operators, not bitwise
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> Mr. Spock would certainly raise an eyebrow to see us using bitwise
> operaters, when we should clearly be relying on logic. Fascinating.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Change-ID: Ie338010c016f93e9faa2002c07c90b15134b7477
> ---
> Testing Hints: No functional change, but the code is more correct.
> Make sure it compiles and passes traffic properly.
> 
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 5 +++--
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 5 +++--
>  2 files changed, 6 insertions(+), 4 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied, code compiles and passes traffic properly
