From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Wed, 27 Feb 2019 03:31:39 +0000
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Add support for the
 ntuple feature
In-Reply-To: <20190220123931.31441-1-sasha.neftin@intel.com>
References: <20190220123931.31441-1-sasha.neftin@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B96647733@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Sasha Neftin
> Sent: Wednesday, February 20, 2019 4:40 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Add support for the ntuple
> feature
> 
> Copy the ntuple feature into list of user selectable features.
> Enable the ntuple feature.
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_defines.h |  3 +
>  drivers/net/ethernet/intel/igc/igc_main.c    | 86
> ++++++++++++++++++++++++++++
>  2 files changed, 89 insertions(+)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
