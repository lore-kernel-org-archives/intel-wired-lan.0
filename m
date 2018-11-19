From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Mon, 19 Nov 2018 19:27:55 +0000
Subject: [Intel-wired-lan] [PATCH 2/2] igc: Remove obsolete IGC_ERR
 define
In-Reply-To: <20181112090520.31496-1-sasha.neftin@intel.com>
References: <20181112090520.31496-1-sasha.neftin@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B965C3AC8@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Sasha Neftin
> Sent: Monday, November 12, 2018 1:05 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 2/2] igc: Remove obsolete IGC_ERR define
> 
> Address community comment.
> Remove obsolete IGC_ERR define and use dev_err method.
> Suggested by Joe Perches.
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc.h      | 2 --
>  drivers/net/ethernet/intel/igc/igc_main.c | 2 +-
>  2 files changed, 1 insertion(+), 3 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
