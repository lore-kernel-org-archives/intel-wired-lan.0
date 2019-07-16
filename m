From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Tue, 16 Jul 2019 00:34:35 +0000
Subject: [Intel-wired-lan] [PATCH v1] igc: Update the MAC reset flow
In-Reply-To: <20190626055347.18154-1-sasha.neftin@intel.com>
References: <20190626055347.18154-1-sasha.neftin@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B970D1A6E@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2019-06-26 at 08:53 +0300, Sasha Neftin wrote:
> Use Device Reset flow instead of Port Reset flow.
> This flow performs a reset of the entire controller device,
> resulting in a state nearly approximating the state
> following a power-up reset or internal PCIe reset,
> except for system PCI configration.
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_base.c    | 2 +-
>  drivers/net/ethernet/intel/igc/igc_defines.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
