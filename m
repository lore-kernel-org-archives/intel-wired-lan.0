From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 17 May 2018 23:07:27 +0000
Subject: [Intel-wired-lan] [PATCH v2 2/2] ena: Fix settings/advertising
 for ethtool
In-Reply-To: <20180515180155.19164-2-jeffrey.t.kirsher@intel.com>
References: <20180515180155.19164-1-jeffrey.t.kirsher@intel.com>
 <20180515180155.19164-2-jeffrey.t.kirsher@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B964D0CB4@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Jeff Kirsher
> Sent: Tuesday, May 15, 2018 11:02 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v2 2/2] ena: Fix settings/advertising for
> ethtool
> 
> It appears that the Amazon Ethernet driver was setting bits in the
> 'settings' field twice.  Almost certainly this was supposed to set bits in
> the 'advertising' field instead.
> 
> CC: Mitch Williams <mitch.a.williams@intel.com>
> Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> ---
>  drivers/net/ethernet/amazon/ena/ena_ethtool.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
