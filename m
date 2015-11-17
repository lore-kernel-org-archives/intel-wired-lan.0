From: Schmitt, Phillip J <phillip.j.schmitt@intel.com>
Date: Tue, 17 Nov 2015 20:16:09 +0000
Subject: [Intel-wired-lan] [PATCH V2] ixgbe: Add KR mode support for
 CS4227	chip
In-Reply-To: <20150928213747.85443.26775.stgit@mdrustad-wks.jf.intel.com>
References: <20150928213747.85443.26775.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <305E19FFAC908240AB6DEBD1E2D8C1E180C1AD78@ORSMSX108.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Mark D Rustad
> Sent: Monday, September 28, 2015 2:38 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH V2] ixgbe: Add KR mode support for CS4227
> chip
> 
> KR auto-neg mode is what we will be using going forward. The SW interface for
> this mode is different that what was used for iXFI.
> 
> Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
> ---
> Changes in V2:
> - Don't delete setting of link speed capabilities
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c |   85 ++++++++++++++++++------
> -
>  1 file changed, 62 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
> b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
> index d0e8a6a41721..d371df8ca746 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c

Tested-by: Phil Schmitt <phillip.j.schmitt@intel.com>
