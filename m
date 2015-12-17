From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 17 Dec 2015 16:43:41 +0000
Subject: [Intel-wired-lan] [next PATCH S23 06/13] i40e/i40evf: tunnels
 can	be generic
In-Reply-To: <1449705033-4968-7-git-send-email-joshua.a.hay@intel.com>
References: <1449705033-4968-1-git-send-email-joshua.a.hay@intel.com>
 <1449705033-4968-7-git-send-email-joshua.a.hay@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F96F0AF@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Joshua Hay
> Sent: Wednesday, December 09, 2015 3:50 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S23 06/13] i40e/i40evf: tunnels can be
> generic
> 
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> Since the i40e driver now supports VxLAN, GRE, and soon to be Geneve
> tunnels, the driver can just note that an skb contains a tunneled packet
> generically, instead of calling out VXLAN specifically.  The tunnel set up we do
> for hardware is almost always the same for all tunnel types.
> 
> This specifically enables ATR/Flow Director on GRE packets which increases
> performance/scaling.  Without this patch GRE RX packets end up on a
> random RSS assigned queue.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Change-ID: Ie8e205603654910d2f718592cbef8132ae0719e4
> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 7 ++++---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.h   | 2 +-
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 2 +-
> drivers/net/ethernet/intel/i40evf/i40e_txrx.h | 2 +-
>  4 files changed, 7 insertions(+), 6 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied
