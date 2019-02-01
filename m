From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 1 Feb 2019 23:10:51 +0000
Subject: [Intel-wired-lan] [PATCH 1/2] igc: Remove the
 'igc_read_mac_addr_base' method
In-Reply-To: <20190115132109.42807-1-sasha.neftin@intel.com>
References: <20190115132109.42807-1-sasha.neftin@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B966211D1@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Sasha Neftin
> Sent: Tuesday, January 15, 2019 5:21 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 1/2] igc: Remove the
> 'igc_read_mac_addr_base' method
> 
> Remove the redundant 'igc_read_mac_addr_base' method and use
> the 'igc_read_mac_addr' method directly instead.
> 
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_base.c | 15 +--------------
>  1 file changed, 1 insertion(+), 14 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
