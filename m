From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 7 Nov 2019 18:49:44 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: Fix for ethtool -m issue on
 X722 NIC
In-Reply-To: <20191106142404.48814-1-alice.michael@intel.com>
References: <20191106142404.48814-1-alice.michael@intel.com>
Message-ID: <76d32c6b07d0430187645245dfa9c7c0@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Wednesday, November 6, 2019 6:24 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Kubalewski, Arkadiusz <arkadiusz.kubalewski@intel.com>
> Subject: [Intel-wired-lan] [PATCH] i40e: Fix for ethtool -m issue on X722 NIC
> 
> From: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> 
> This patch contains fix for a problem with command:
> 'ethtool -m <dev>'
> which breaks functionality of:
> 'ethtool <dev>'
> when called on X722 NIC
> 
> Disallowed update of link phy_types on X722 NIC Currently correct value
> cannot be obtained from FW Previously wrong value returned by FW was
> used and was a root cause for incorrect output of 'ethtool <dev>' command
> 
> Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_common.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


