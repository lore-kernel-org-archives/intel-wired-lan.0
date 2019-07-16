From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Tue, 16 Jul 2019 00:31:40 +0000
Subject: [Intel-wired-lan] [PATCH v1 1/2] igc: Remove the polarity field
 from a PHY information structure
In-Reply-To: <20190623104232.36661-1-sasha.neftin@intel.com>
References: <20190623104232.36661-1-sasha.neftin@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B970D1A51@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Sun, 2019-06-23 at 13:42 +0300, Sasha Neftin wrote:
> Polarity and cable length fields is not applicable for the i225 device.
> This patch comes to clean up phy information structure.
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_hw.h | 6 ------
>  1 file changed, 6 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
