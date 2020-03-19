From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 19 Mar 2020 07:03:37 +0000
Subject: [Intel-wired-lan] [PATCH] igc: Fix default MAC address filter
 override
In-Reply-To: <20200309231040.20873-1-andre.guedes@intel.com>
References: <20200309231040.20873-1-andre.guedes@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B97223826@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Andre Guedes
> Sent: Monday, March 9, 2020 4:11 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] igc: Fix default MAC address filter override
> 
> This patch fixes a bug when the user adds the first MAC address filter
> via ethtool NFC mechanism.
> 
> When the first MAC address filter is added, it overwrites the default
> MAC address filter configured at RAL[0] and RAH[0]. As consequence,
> frames addressed to the interface MAC address are not sent to host
> anymore.
> 
> This patch fixes the bug by calling igc_set_default_mac_filter() during
> adapter init so the position 0 of adapter->mac_table[] is assigned to
> the default MAC address.
> 
> Signed-off-by: Andre Guedes <andre.guedes@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_main.c | 2 ++
>  1 file changed, 2 insertions(+)
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
