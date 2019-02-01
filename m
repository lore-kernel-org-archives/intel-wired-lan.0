From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 1 Feb 2019 23:08:21 +0000
Subject: [Intel-wired-lan] [PATCH 1/1] igc: Remove unneeded code
In-Reply-To: <20190113092231.40675-1-sasha.neftin@intel.com>
References: <20190113092231.40675-1-sasha.neftin@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B966211BB@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Sasha Neftin
> Sent: Sunday, January 13, 2019 1:23 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 1/1] igc: Remove unneeded code
> 
> Remove the 'igc_get_link_up_info_base method' from igc_base.c file.
> Use the 'igc_get_speed_and_duplex_copper' method directly and reduce
> the code redundancy.
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_base.c | 22 +---------------------
>  1 file changed, 1 insertion(+), 21 deletions(-)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
