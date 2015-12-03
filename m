From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 3 Dec 2015 03:39:59 +0000
Subject: [Intel-wired-lan] [PATCH 2/5] igb: Don't add PHY address to
 PCDL	address
In-Reply-To: <1064069608.305775.1446575838742.JavaMail.zimbra@xes-inc.com>
References: <197584129.304313.1446575155971.JavaMail.zimbra@xes-inc.com>,
 <1064069608.305775.1446575838742.JavaMail.zimbra@xes-inc.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81E25F8A@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [intel-wired-lan-bounces at lists.osuosl.org] on behalf of Aaron Sierra [asierra at xes-inc.com]
> Sent: Tuesday, November 03, 2015 10:37 AM
> To: Kirsher, Jeffrey T; intel-wired-lan at lists.osuosl.org
> Cc: Joe Schultz
> Subject: [Intel-wired-lan] [PATCH 2/5] igb: Don't add PHY address to PCDL       address
> 
> There is no reason to add the PHY address into the PCDL register address.
> 
> Signed-off-by: Aaron Sierra <asierra@xes-inc.com>
> ---
>  drivers/net/ethernet/intel/igb/e1000_phy.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
