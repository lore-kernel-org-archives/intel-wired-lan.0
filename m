From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Sat, 16 Feb 2019 01:35:12 +0000
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Add multiple receive
 queues control supporting
In-Reply-To: <20190206074837.4851-1-sasha.neftin@intel.com>
References: <20190206074837.4851-1-sasha.neftin@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B96641E39@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Sasha Neftin
> Sent: Tuesday, February 5, 2019 11:49 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Add multiple receive queues
> control supporting
> 
> Enable the multi queues to receive.
> Program the direction of packets to specified queuies according
> to the mode selected in the MRQC register.
> Multiple receive queues defined by filters and RSS for 4 queues.
> Enable/disable RSS hashing and also to enable multiple receive queues.
> This patch will allow further ethtool support development.
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc.h         |  9 +++++
>  drivers/net/ethernet/intel/igc/igc_defines.h | 10 ++++++
>  drivers/net/ethernet/intel/igc/igc_main.c    | 49
> ++++++++++++++++++++++++++++
>  drivers/net/ethernet/intel/igc/igc_regs.h    |  5 +++
>  4 files changed, 73 insertions(+)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
