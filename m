From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 17 May 2018 22:13:23 +0000
Subject: [Intel-wired-lan] [next PATCH S92 5/9] i40e: use WARN_ONCE to
 replace the commented BUG_ON size check
In-Reply-To: <20180517080840.30192-5-alice.michael@intel.com>
References: <20180517080840.30192-1-alice.michael@intel.com>
 <20180517080840.30192-5-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1B771870@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Thursday, May 17, 2018 1:09 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S92 5/9] i40e: use WARN_ONCE to
> replace the commented BUG_ON size check
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> We don't really want to use BUG_ON here since that would completely crash
> the kernel, thus the reason we commented it out. We *can't* use
> BUILD_BUG_ON because at least now (a) the sizes aren't constant (we are
> fixing this) and (b) not all compilers are smart enough to understand that "p -
> data" is a constant.
> 
> Instead, just use a WARN_ONCE so that the first time we end up with an
> incorrect size we will dump a stack trace and a message, hopefully
> highlighting the issues early in testing.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


