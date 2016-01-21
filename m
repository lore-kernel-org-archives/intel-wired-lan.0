From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 21 Jan 2016 00:24:38 +0000
Subject: [Intel-wired-lan] [next PATCH S28 12/15] i40evf: set adapter
 state	on reset failure
In-Reply-To: <1452897202-15204-13-git-send-email-joshua.a.hay@intel.com>
References: <1452897202-15204-1-git-send-email-joshua.a.hay@intel.com>
 <1452897202-15204-13-git-send-email-joshua.a.hay@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F98AD99@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Joshua Hay
> Sent: Friday, January 15, 2016 2:33 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S28 12/15] i40evf: set adapter state on
> reset failure
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> If a reset fails to complete, the driver gets its affairs in order and awaits the
> cold solace of rmmod. Unfortunately, it was not properly setting the adapter
> state, which would cause a panic on rmmod, instead of the desired surcease.
> 
> Set the adapter state to DOWN in this case, and avoid a panic.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Change-ID: I6fdd9906da52e023f8dc744f7da44b5d95278ca9
> ---
> Testing Hints: Execute CORER on the PF and see if you can get into the state
> where the VF reset never completed. Then rmmod i40evf.
> 
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c | 1 +
>  1 file changed, 1 insertion(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied, no errors/panics detected after multiple resets
