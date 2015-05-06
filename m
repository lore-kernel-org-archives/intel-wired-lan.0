From: Schmitt, Phillip J <phillip.j.schmitt@intel.com>
Date: Wed, 6 May 2015 22:45:29 +0000
Subject: [Intel-wired-lan] [PATCH v2 1/3] ixgbe: Specify rx hash type
 wrt rx	desc RSS type
In-Reply-To: <1430276261-29821-2-git-send-email-fan.du@intel.com>
References: <1430276261-29821-1-git-send-email-fan.du@intel.com>
 <1430276261-29821-2-git-send-email-fan.du@intel.com>
Message-ID: <305E19FFAC908240AB6DEBD1E2D8C1E17F8289B0@ORSMSX108.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH v2 1/3] ixgbe: Specify rx hash type wrt rx desc
> RSS type
> 
> RSS could be leveraged by taking account L4 src/dst ports as ingredients, thus
> ingress skb rx hash type should honor such the real configuration.
> 
> Signed-off-by: Fan Du <fan.du@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   25 +++++++++++++++++++++-
> ---
>  1 files changed, 21 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> index d3f4b0c..5df896b 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c

Tested-by: Phil Schmitt <phillip.j.schmitt@intel.com>
