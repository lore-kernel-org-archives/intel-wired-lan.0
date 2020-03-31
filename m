From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Tue, 31 Mar 2020 19:58:57 +0000
Subject: [Intel-wired-lan] [PATCH 02/12] igc: Check unsupported flag in
 igc_add_mac_filter()
In-Reply-To: <20200318230102.36952-3-andre.guedes@intel.com>
References: <20200318230102.36952-1-andre.guedes@intel.com>
 <20200318230102.36952-3-andre.guedes@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B9722DD90@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Andre Guedes
> Sent: Wednesday, March 18, 2020 4:01 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 02/12] igc: Check unsupported flag in
> igc_add_mac_filter()
> 
> The IGC_MAC_STATE_SRC_ADDR flags is not supported by igc_add_mac_
> filter() so this patch adds a check for it and returns -ENOTSUPP
> in case it is set.
> 
> Signed-off-by: Andre Guedes <andre.guedes@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_main.c | 2 ++
>  1 file changed, 2 insertions(+)

