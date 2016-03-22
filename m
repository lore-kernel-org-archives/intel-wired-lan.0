From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 22 Mar 2016 20:22:02 +0000
Subject: [Intel-wired-lan] [next PATCH S31 v4 10/12] i40e: Lower
	some	message levels
In-Reply-To: <1458328696-135941-11-git-send-email-avinash.dayanand@intel.com>
References: <1458328696-135941-1-git-send-email-avinash.dayanand@intel.com>
 <1458328696-135941-11-git-send-email-avinash.dayanand@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F99EE9E@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Avinash Dayanand
> Sent: Friday, March 18, 2016 12:18 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S31 v4 10/12] i40e: Lower some
> message levels
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> These conditions can happen any time VFs are enabled or disabled and are
> not really indicative of fatal problems unless they happen continuously.
> 
> Lower the log level so that people don't get scared.
> 
> Testing Hints: Enable and disable lots of VFs until you see the messages. Note
> the log level.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Change-ID: I1ceb4adbd10d03cbeed54d1f5b7f20d60328351d
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Error messages not logged to console with patch applied
