From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Sat, 1 Feb 2020 02:20:19 +0000
Subject: [Intel-wired-lan] [PATCH v2] igc: Complete to commit Add legacy
 power management support
In-Reply-To: <20200113133359.24847-1-sasha.neftin@intel.com>
References: <20200113133359.24847-1-sasha.neftin@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B971D270D@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Sasha Neftin
> Sent: Monday, January 13, 2020 5:34 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v2] igc: Complete to commit Add legacy
> power management support
> 
> commit 9513d2a5dc7f ("igc: Add legacy power management support")
> Add power management resume and schedule suspend requests.
> Add power management get and put synchronization.
> 
> v1 -> v2:
> add pm_runtime_put_noidle
> add pm_runtime_get_noresume
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_main.c | 27
> +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
