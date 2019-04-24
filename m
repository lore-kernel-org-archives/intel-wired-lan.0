From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Wed, 24 Apr 2019 02:15:06 +0000
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Remove the obsolete
 workaround
In-Reply-To: <20190415111035.31815-1-sasha.neftin@intel.com>
References: <20190415111035.31815-1-sasha.neftin@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B9703934E@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Sasha Neftin
> Sent: Monday, April 15, 2019 4:11 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Remove the obsolete
> workaround
> 
> Enables a resend request after the completion timeout workaround is not
> relevant for i225 device. This patch is clean code relevant this
> workaround.
> Minor cosmetic fixes, replace the 'spaces' with 'tabs'
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_base.c    | 49 ----------------------------
>  drivers/net/ethernet/intel/igc/igc_defines.h | 12 ++-----
>  2 files changed, 3 insertions(+), 58 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
