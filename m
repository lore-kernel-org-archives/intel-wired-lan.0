From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 22 Sep 2016 17:26:24 +0000
Subject: [Intel-wired-lan] [next PATCH S47 5/9] i40e: Drop code
	for	unsupported flow types
In-Reply-To: <1473895479-23035-6-git-send-email-bimmy.pujari@intel.com>
References: <1473895479-23035-1-git-send-email-bimmy.pujari@intel.com>
 <1473895479-23035-6-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA0E76A@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

------Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Wednesday, September 14, 2016 4:25 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S47 5/9] i40e: Drop code for
> unsupported flow types
> 
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> We cannot currently support SCTP in the hardware, and IPV4_FLOW is not
> used anywhere by the software so we can go through and drop the
> functionality related to these two flow types.
> 
> In addition we cannot support masking based on the protocol value so if the
> user is expecting a value other than TCP or UDP we should simply return an
> error rather then trying to allocate a filter for a rule that will only partially
> match what the user requested.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> Change-ID: I10d52bb97d8104d76255fe244551814ff9531a63
> ---
> Testing Hints:
>         This change should have no impact on actual functionality.  All it
>         should be doing is removing dead code.  As such we should see no
>         actual change in how ethtool Flow Director filters are handled.
> 
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c | 31 +++++------------------------
>  1 file changed, 5 insertions(+), 26 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


