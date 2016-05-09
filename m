From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 9 May 2016 17:43:48 +0000
Subject: [Intel-wired-lan] [patch] i40e: fix an uninitialized variable
 bug
In-Reply-To: <20160505131802.GA3038@mwanda>
References: <20160505131802.GA3038@mwanda>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9D5ECF@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Dan Carpenter
> Sent: Thursday, May 05, 2016 6:18 AM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; Brandeburg, Jesse
> <jesse.brandeburg@intel.com>
> Cc: kernel-janitors at vger.kernel.org; linux-kernel at vger.kernel.org; intel-
> wired-lan at lists.osuosl.org; netdev at vger.kernel.org
> Subject: [Intel-wired-lan] [patch] i40e: fix an uninitialized variable bug
> 
> We removed this initialization but it is required.  Let's put it back.
> 
> Fixes: 895106a577c4 ('i40e: trivial fixes')
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
No uninitialized variable warning at compile

