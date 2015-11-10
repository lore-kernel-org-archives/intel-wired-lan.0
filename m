From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 10 Nov 2015 21:14:03 +0000
Subject: [Intel-wired-lan] [next PATCH S21 13/14] i40e/i40evf: use
 logical	operator
In-Reply-To: <1446852372-25480-14-git-send-email-joshua.a.hay@intel.com>
References: <1446852372-25480-1-git-send-email-joshua.a.hay@intel.com>
 <1446852372-25480-14-git-send-email-joshua.a.hay@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060E1F77@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Joshua Hay
> Sent: Friday, November 06, 2015 3:26 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S21 13/14] i40e/i40evf: use logical
> operator
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> We shouldn't be using a bitwise operator here; it's not a bitwise operation.
> Use a logical operator instead. Why doesn't c have a logical-or-and-assign
> operator?
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Change-ID: Id84f3ca884910bed7073c84b1e16a102e958d0de
> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 2 +-
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied
