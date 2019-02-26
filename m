From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Tue, 26 Feb 2019 04:15:59 +0000
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Add support for statistics
In-Reply-To: <20190218083731.16211-1-sasha.neftin@intel.com>
References: <20190218083731.16211-1-sasha.neftin@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B96646F88@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Sasha Neftin
> Sent: Monday, February 18, 2019 12:38 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Add support for statistics
> 
> Add support for statistics and show basic counters.
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc.h         |   4 +
>  drivers/net/ethernet/intel/igc/igc_ethtool.c | 233
> +++++++++++++++++++++++++++
>  drivers/net/ethernet/intel/igc/igc_main.c    | 167 ++++++++++++++++++-
>  3 files changed, 403 insertions(+), 1 deletion(-)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
