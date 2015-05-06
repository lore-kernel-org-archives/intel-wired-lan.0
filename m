From: Schmitt, Phillip J <phillip.j.schmitt@intel.com>
Date: Wed, 6 May 2015 22:45:48 +0000
Subject: [Intel-wired-lan] [PATCH v2 2/3] ixgbevf: Set rx hash type
	for	ingress packets
In-Reply-To: <1430276261-29821-3-git-send-email-fan.du@intel.com>
References: <1430276261-29821-1-git-send-email-fan.du@intel.com>
 <1430276261-29821-3-git-send-email-fan.du@intel.com>
Message-ID: <305E19FFAC908240AB6DEBD1E2D8C1E17F8289C9@ORSMSX108.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Fan Du
> Sent: Tuesday, April 28, 2015 7:58 PM
> To: Kirsher, Jeffrey T
> Cc: netdev at vger.kernel.org; Du, Fan; intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v2 2/3] ixgbevf: Set rx hash type for ingress
> packets
> 
> Set hash type for ingress packets according to NIC advanced receive descriptors
> RSS type part.
> 
> Signed-off-by: Fan Du <fan.du@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbevf/defines.h      |   12 +++++++++
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |   27
> +++++++++++++++++++++
>  2 files changed, 39 insertions(+), 0 deletions(-)

Tested-by: Phil Schmitt <phillip.j.schmitt@intel.com>
