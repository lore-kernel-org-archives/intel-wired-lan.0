From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 22 Oct 2018 19:39:28 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: allow IPsec Tx offload in VEPA
 mode
In-Reply-To: <1538695732-10203-1-git-send-email-shannon.nelson@oracle.com>
References: <1538695732-10203-1-git-send-email-shannon.nelson@oracle.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D310D70@FMSMSX152.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Shannon Nelson
> Sent: Thursday, October 4, 2018 4:29 PM
> To: intel-wired-lan at lists.osuosl.org; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>
> Cc: netdev at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH] ixgbe: allow IPsec Tx offload in VEPA
> mode
> 
> When it's possible that the PF might end up trying to send a packet to one of
> its own VFs, we have to forbid IPsec offload because the device drops the
> packets into a black hole.
> See commit 47b6f50077e6 ("ixgbe: disallow IPsec Tx offload when in SR-IOV
> mode") for more info.
> 
> This really is only necessary when the device is in the default VEB mode.  If
> instead the device is running in VEPA mode, the packets will go through the
> encryption engine and out the MAC/PHY as normal, and get "hairpinned" as
> needed by the switch.
> 
> So let's not block IPsec offload when in VEPA mode.  To get there with the
> ixgbe device, use the handy 'bridge' command:
> 	bridge link set dev eth1 hwmode vepa
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


