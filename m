From: Kraus, NechamaX <nechamax.kraus@linux.intel.com>
Date: Tue, 14 Sep 2021 14:56:54 +0300
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Change Device Reset to
 Port Reset
In-Reply-To: <20210909064618.3643764-1-sasha.neftin@intel.com>
References: <20210909064618.3643764-1-sasha.neftin@intel.com>
Message-ID: <04564b6f-46c4-a763-36a1-cae7e265903d@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 9/9/2021 09:46, Sasha Neftin wrote:
> _reset_hw_base method switched from port reset (CTRL[26]) to device reset
> (CTRL[29]) since the FW was receiving an interrupt on CTRL[29].
> FW code was later modified to also receive an interrupt on CTRL[26].
> Since certain HW values are not reset to default by CTRL[29], we go back
> to CTRL[26] for the HW reset, as it meets all current requirements.
> 
> This reverts commit bb4265ec24c13aacf3a613e64c701294b122beb7
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>   drivers/net/ethernet/intel/igc/igc_base.c    | 2 +-
>   drivers/net/ethernet/intel/igc/igc_defines.h | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
Tested-by: Nechama Kraus <nechamax.kraus@linux.intel.com>

