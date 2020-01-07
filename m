From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 7 Jan 2020 23:28:52 +0000
Subject: [Intel-wired-lan] [net] i40e: Fix receive buffer starvation for
 AF_XDP
In-Reply-To: <20200105084600.4025394-1-jeffrey.t.kirsher@intel.com>
References: <20200105084600.4025394-1-jeffrey.t.kirsher@intel.com>
Message-ID: <9cca5b6987e343cb844a549651aa9648@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Jeff Kirsher
> Sent: Sunday, January 5, 2020 12:46 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Karlsson, Magnus <magnus.karlsson@intel.com>
> Subject: [Intel-wired-lan] [net] i40e: Fix receive buffer starvation for AF_XDP
> 
> Magnus's fix to resolve a potential receive buffer starvation for AF_XDP got
> applied to both the i40e_xsk_umem_enable/disable() functions, when it
> should have only been applied to the "enable".  So clean up the undesired
> code in the disable function.
> 
> CC: Magnus Karlsson <magnus.karlsson@intel.com>
> Fixes: 1f459bdc2007 ("i40e: fix potential RX buffer starvation for AF_XDP")
> Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_xsk.c | 5 -----
>  1 file changed, 5 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


