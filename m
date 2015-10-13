From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 13 Oct 2015 16:39:23 +0000
Subject: [Intel-wired-lan] [next-queue v2 3/6] i40e: clean up the
	entire	function exit path
In-Reply-To: <1444719992-301-3-git-send-email-sakiwit@gmail.com>
References: <1444719992-301-1-git-send-email-sakiwit@gmail.com>
 <1444719992-301-3-git-send-email-sakiwit@gmail.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060D118A@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Jean Sacren
> Sent: Tuesday, October 13, 2015 12:06 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next-queue v2 3/6] i40e: clean up the entire
> function exit path
> 
> From: Jean Sacren <sakiwit@gmail.com>
> 
> In i40e_tsyn(), by using a label of 'no_timestamp', we will be able to clearly
> denote a slew of circumstances that return with 0, which is much better as a
> default exit than the one that returns with 1.
> 
> With the above change, in the last check, we will be able to spare the 'else'
> branch. Further, the whole branch for returning 1 shall be put together for
> clarity.
> 
> Add a comment next to returning 1 in comparison to no_timestamp label.
> 
> Signed-off-by: Jean Sacren <sakiwit@gmail.com>
> ---
> v2: No changes except for the serial number.
> 
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied
