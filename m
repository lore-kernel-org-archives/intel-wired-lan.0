From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Wed, 12 Feb 2020 22:32:48 +0000
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Add WOL support
In-Reply-To: <20200203075520.16976-1-sasha.neftin@intel.com>
References: <20200203075520.16976-1-sasha.neftin@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B971F3525@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Sasha Neftin
> Sent: Sunday, February 2, 2020 11:55 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Add WOL support
> 
> This patch adds a define and WOL support for an i225 parts.
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc.h         |  1 +
>  drivers/net/ethernet/intel/igc/igc_defines.h |  3 ++
>  drivers/net/ethernet/intel/igc/igc_ethtool.c | 61
> ++++++++++++++++++++++++++++
>  drivers/net/ethernet/intel/igc/igc_main.c    | 10 +++++
>  4 files changed, 75 insertions(+)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
