From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 5 Mar 2020 01:37:15 +0000
Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Remove forward declaration
In-Reply-To: <20200228002515.31650-1-sasha.neftin@intel.com>
References: <20200228002515.31650-1-sasha.neftin@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B9720149B@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Sasha Neftin
> Sent: Thursday, February 27, 2020 4:25 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v1 1/1] igc: Remove forward declaration
> 
> Move igc_adapter and igc_ring structures up to avoid
> forward declaration
> It is not necessary to forward declare these structures
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc.h | 391 +++++++++++++++++---------------
> ---
>  1 file changed, 194 insertions(+), 197 deletions(-)
> 
Tested-by: Aaron Brown <aaron.f.brown>
