From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 21 Aug 2015 22:33:41 +0000
Subject: [Intel-wired-lan] [PATCH next 1/4] igbvf: Enable TSO for
 stacked	vlan
In-Reply-To: <1438851452-13143-1-git-send-email-makita.toshiaki@lab.ntt.co.jp>
References: <1438851452-13143-1-git-send-email-makita.toshiaki@lab.ntt.co.jp>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81AFF4D8@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Toshiaki Makita
> Sent: Thursday, August 06, 2015 1:57 AM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; Brandeburg, Jesse
> <jesse.brandeburg@intel.com>; Nelson, Shannon <shannon.nelson@intel.com>;
> Wyborny, Carolyn <carolyn.wyborny@intel.com>; Skidmore, Donald C
> <donald.c.skidmore@intel.com>; Vick, Matthew <matthew.vick@intel.com>;
> Ronciak, John <john.ronciak@intel.com>; Williams, Mitch A
> <mitch.a.williams@intel.com>
> Cc: intel-wired-lan at lists.osuosl.org; Toshiaki Makita
> <makita.toshiaki@lab.ntt.co.jp>
> Subject: [Intel-wired-lan] [PATCH next 1/4] igbvf: Enable TSO for stacked vlan
> 
> Setting ndo_features_check to passthru_features_check allows the driver
> to skip the check for multiple tagged TSO packets and enables stacked
> vlan TSO.
> Tested with I350.
> 
> Signed-off-by: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
> ---
>  drivers/net/ethernet/intel/igbvf/netdev.c | 1 +
>  1 file changed, 1 insertion(+)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
