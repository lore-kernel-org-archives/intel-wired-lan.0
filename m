From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Tue, 16 Jul 2019 00:30:37 +0000
Subject: [Intel-wired-lan] [PATCH v2] igc: Add more SKUs for i225 device
In-Reply-To: <20190702113955.6248-1-sasha.neftin@intel.com>
References: <20190702113955.6248-1-sasha.neftin@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B970D1A44@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2019-07-02 at 14:39 +0300, Sasha Neftin wrote:
> Add support for more SKUs.
> v2: Fixed device id to I220
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_base.c | 3 +++
>  drivers/net/ethernet/intel/igc/igc_hw.h   | 3 +++
>  drivers/net/ethernet/intel/igc/igc_main.c | 3 +++
>  3 files changed, 9 insertions(+)
> 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
