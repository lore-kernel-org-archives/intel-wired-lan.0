From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Sat, 1 Feb 2020 02:28:30 +0000
Subject: [Intel-wired-lan] [PATCH v2 1/1] igc: Add pcie error handler
 support
In-Reply-To: <20200129143007.19836-1-sasha.neftin@intel.com>
References: <20200129143007.19836-1-sasha.neftin@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B971D273C@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Sasha Neftin
> Sent: Wednesday, January 29, 2020 6:30 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v2 1/1] igc: Add pcie error handler support
> 
> Add pcie error detection, slot reset and resume capability
> 
> v1->v2:
> Address community comments
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_main.c | 103
> ++++++++++++++++++++++++++++++
>  1 file changed, 103 insertions(+)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
