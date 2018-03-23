From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 23 Mar 2018 18:55:19 +0000
Subject: [Intel-wired-lan] [PATCH v3 1/2] i40e: tweak page counting for
 XDP_REDIRECT
In-Reply-To: <20180322151434.24338-1-bjorn.topel@gmail.com>
References: <20180322151434.24338-1-bjorn.topel@gmail.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A957978@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Bj?rn T?pel
> Sent: Thursday, March 22, 2018 8:15 AM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: netdev at vger.kernel.org; Topel, Bjorn <bjorn.topel@intel.com>;
> Karlsson, Magnus <magnus.karlsson@intel.com>
> Subject: [Intel-wired-lan] [PATCH v3 1/2] i40e: tweak page counting for
> XDP_REDIRECT
> 
> From: Bj?rn T?pel <bjorn.topel@intel.com>
> 
> This commit tweaks the page counting for XDP_REDIRECT to function
> properly. XDP_REDIRECT support will be added in a future commit.
> 
> The current page counting scheme assumes that the reference count cannot
> decrease until the received frame is sent to the upper layers of the
> networking stack. This assumption does not hold for the XDP_REDIRECT
> action, since a page (pointed out by xdp_buff) can have its reference count
> decreased via the xdp_do_redirect call.
> 
> To work around that, we now start off by a large page count and then don't
> allow a refcount less than two.
> 
> Signed-off-by: Bj?rn T?pel <bjorn.topel@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


