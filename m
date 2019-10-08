From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 8 Oct 2019 16:54:51 +0000
Subject: [Intel-wired-lan] [net] i40e: Fix receive buffer starvation for
 AF_XDP
In-Reply-To: <20191007220724.16279-1-jeffrey.t.kirsher@intel.com>
References: <20191007220724.16279-1-jeffrey.t.kirsher@intel.com>
Message-ID: <74c9afb9236b42cc8b3015d77522b692@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Jeff Kirsher
> Sent: Monday, October 7, 2019 3:07 PM
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


