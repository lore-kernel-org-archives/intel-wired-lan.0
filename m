From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 2 Aug 2019 01:56:06 +0000
Subject: [Intel-wired-lan] [PATCH v1] igc: Remove unneeded PCI bus
 defines
In-Reply-To: <20190730071848.7978-1-sasha.neftin@intel.com>
References: <20190730071848.7978-1-sasha.neftin@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B970DB69D@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Sasha Neftin
> Sent: Tuesday, July 30, 2019 12:19 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v1] igc: Remove unneeded PCI bus defines
> 
> PCIe device control 2 defines does not use internally.
> This patch comes to clean up those.
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_defines.h | 4 ----
>  1 file changed, 4 deletions(-)
> 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
