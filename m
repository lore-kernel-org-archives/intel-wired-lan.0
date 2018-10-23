From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 23 Oct 2018 23:30:23 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: fix MAC anti-spoofing filter
 after VFLR
In-Reply-To: <1540190671-43799-1-git-send-email-radoslawx.tyl@intel.com>
References: <1540190671-43799-1-git-send-email-radoslawx.tyl@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D310FDA@FMSMSX152.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Radoslaw Tyl
> Sent: Sunday, October 21, 2018 11:45 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Tyl, RadoslawX <radoslawx.tyl@intel.com>
> Subject: [Intel-wired-lan] [PATCH] ixgbe: fix MAC anti-spoofing filter after
> VFLR
> 
> This change resolves a driver bug where the driver is logging a message that
> says "Spoofed packets detected". This can occur on the PF
> (host) when a VF has VLAN+MACVLAN enabled and is re-started with a
> different MAC address.
> 
> MAC and VLAN anti-spoofing filters are to be enabled together.
> 
> Signed-off-by: Radoslaw Tyl <radoslawx.tyl@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


