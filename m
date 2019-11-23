From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Sat, 23 Nov 2019 04:02:33 +0000
Subject: [Intel-wired-lan] [PATCH v1 05/15] igc: Remove no need
 declaration of the igc_alloc_mapped_page
In-Reply-To: <20191119114411.41911-1-sasha.neftin@intel.com>
References: <20191119114411.41911-1-sasha.neftin@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B9717BA57@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Sasha Neftin
> Sent: Tuesday, November 19, 2019 3:44 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v1 05/15] igc: Remove no need declaration
> of the igc_alloc_mapped_page
> 
> We want to avoid forward-declarations of function if possible.
> Rearrange the igc_alloc_mapped_page function implementation.
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_main.c | 94 +++++++++++++++------------
> ----
>  1 file changed, 46 insertions(+), 48 deletions(-)
> 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
