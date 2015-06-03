From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Wed, 3 Jun 2015 03:24:52 +0000
Subject: [Intel-wired-lan] [PATCH v2 2/5] e1000e: fix legacy
	interrupt	handling in i219
In-Reply-To: <4bd9425b152903b483996d9ea340489113cf9587.1433253642.git.yanirx.lubetkin@intel.com>
References: <5c0f5ad24e5ae3adfede0279b6fdfea4312e32da.1433253642.git.yanirx.lubetkin@intel.com>
 <4bd9425b152903b483996d9ea340489113cf9587.1433253642.git.yanirx.lubetkin@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B78DDE3C6@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Yanir Lubetkin
> Sent: Tuesday, June 02, 2015 7:06 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v2 2/5] e1000e: fix legacy interrupt
> handling in i219
> 
> This fix handles a hardware issue that prevented i219 from
> working in legacy interrupts mode (IntMode=0)
> 
> Signed-off-by: Yanir Lubetkin <yanirx.lubetkin@intel.com>
> ---
>  drivers/net/ethernet/intel/e1000e/ich8lan.h |  5 ++++-
>  drivers/net/ethernet/intel/e1000e/netdev.c  | 14 ++++++++++++++
>  drivers/net/ethernet/intel/e1000e/regs.h    |  1 +
>  3 files changed, 19 insertions(+), 1 deletion(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
