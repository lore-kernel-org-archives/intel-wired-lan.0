From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Mon, 5 Dec 2016 23:18:21 +0000
Subject: [Intel-wired-lan] [PATCH] igb: add i211 to i210 PHY workaround
In-Reply-To: <20161128170957.26228-1-todd.fujinaka@intel.com>
References: <20161128170957.26228-1-todd.fujinaka@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81FE5CA0@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Todd Fujinaka
> Sent: Monday, November 28, 2016 9:10 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] igb: add i211 to i210 PHY workaround
> 
> i210 and i211 share the same PHY but have different PCI IDs. Don't
> forget i211 for any i210 workarounds.
> 
> Signed-off-by: Todd Fujinaka <todd.fujinaka@intel.com>
> ---
>  drivers/net/ethernet/intel/igb/e1000_phy.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
