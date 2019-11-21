From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 21 Nov 2019 02:24:38 +0000
Subject: [Intel-wired-lan] [PATCH v1] igc: Remove excess parameter
 description from igc_is_non_eop
In-Reply-To: <20191110155744.13755-1-sasha.neftin@intel.com>
References: <20191110155744.13755-1-sasha.neftin@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B9717A761@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Sasha Neftin
> Sent: Sunday, November 10, 2019 7:58 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v1] igc: Remove excess parameter
> description from igc_is_non_eop
> 
> The function description for igc_is_non_eop includes an extra @skb
> parameter description. This parameter doesn't exist on the function, so
> remove it.
> 
> Suggested-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc_main.c | 1 -
>  1 file changed, 1 deletion(-)
> 
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
