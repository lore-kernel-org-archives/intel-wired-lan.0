From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 17 May 2018 22:13:52 +0000
Subject: [Intel-wired-lan] [next PATCH S92 6/9] i40e: fold prefix
 strings directly into stat names
In-Reply-To: <20180517080840.30192-6-alice.michael@intel.com>
References: <20180517080840.30192-1-alice.michael@intel.com>
 <20180517080840.30192-6-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1B771880@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH S92 6/9] i40e: fold prefix strings
> directly into stat names
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> We always prefix these stats with a fixed string, so just fold this prefix into
> the stat string definition. This preparatory work will make it easier to
> implement a helper function to copy stats and strings into the supplied
> buffers in a future patch.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 137 +++++++++++++-------
> -----
>  1 file changed, 69 insertions(+), 68 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


