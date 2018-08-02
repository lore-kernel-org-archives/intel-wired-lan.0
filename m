From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 2 Aug 2018 22:04:45 +0000
Subject: [Intel-wired-lan] e1000: ensure to free old tx/rx rings in
 set_ringparam()
In-Reply-To: <20180723160130.8911-2-jeffrey.t.kirsher@intel.com>
References: <20180723160130.8911-1-jeffrey.t.kirsher@intel.com>
 <20180723160130.8911-2-jeffrey.t.kirsher@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B9652FC35@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Jeff Kirsher
> Sent: Monday, July 23, 2018 9:02 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Bo Chen <chenbo@pdx.edu>
> Subject: [Intel-wired-lan] e1000: ensure to free old tx/rx rings in
> set_ringparam()
> 
> From: Bo Chen <chenbo@pdx.edu>
> 
> In 'e1000_set_ringparam()', the tx_ring and rx_ring are updated with new
> value
> and the old tx/rx rings are freed only when the device is up. There are
> resource
> leaks on old tx/rx rings when the device is not up. This bug is reported by
> COD,
> a tool for testing kernel module binaries I am building.
> 
> This patch fixes the bug by always calling 'kfree()' on old tx/rx rings in
> 'e1000_set_ringparam()'.
> 
> Signed-off-by: Bo Chen <chenbo@pdx.edu>
> Reviewed-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
>  drivers/net/ethernet/intel/e1000/e1000_ethtool.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
