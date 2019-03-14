From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 14 Mar 2019 23:10:30 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: print PCI vendor and device ID
 during probe
In-Reply-To: <20190312111802.21203-1-sassmann@kpanic.de>
References: <20190312111802.21203-1-sassmann@kpanic.de>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D37455B@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Stefan Assmann
> Sent: Tuesday, March 12, 2019 4:18 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: netdev at vger.kernel.org; davem at davemloft.net; sassmann at kpanic.de
> Subject: [Intel-wired-lan] [PATCH] i40e: print PCI vendor and device ID during
> probe
> 
> Printing each device's PCI vendor and device ID has the advantage of easily
> revealing what hardware we're dealing with exactly. It's no longer necessary
> to match the PCI bus information to the lspci output.
> 
> Helps with bug reports where no lspci output is available.
> 
> Output before
> i40e 0000:08:00.0: fw 6.1.49420 api 1.7 nvm 6.80 0x80003c64 1.2007.0 and after
> i40e 0000:08:00.0: fw 6.1.49420 api 1.7 nvm 6.80 0x80003c64 1.2007.0
> [8086:1572] [8086:0004]
> 
> Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


