From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 3 Dec 2015 03:40:09 +0000
Subject: [Intel-wired-lan] [PATCH 3/5] igb: Improve cable length
 function	for I210, etc.
In-Reply-To: <1313149536.305776.1446575844476.JavaMail.zimbra@xes-inc.com>
References: <853516779.304421.1446575216170.JavaMail.zimbra@xes-inc.com>,
 <1313149536.305776.1446575844476.JavaMail.zimbra@xes-inc.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81E25F97@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [intel-wired-lan-bounces at lists.osuosl.org] on behalf of Aaron Sierra [asierra at xes-inc.com]
> Sent: Tuesday, November 03, 2015 10:37 AM
> To: Kirsher, Jeffrey T; intel-wired-lan at lists.osuosl.org
> Cc: Joe Schultz
> Subject: [Intel-wired-lan] [PATCH 3/5] igb: Improve cable length function       for I210, etc.
> 
> From: Joe Schultz <jschultz@xes-inc.com>
> 
> Previously, the PHY-specific code to get the cable length for the
> I210 internal and related PHYs was reporting the cable length of a
> single pair and reporting it as the min, max, and total cable length.
> Update it so that all four pairs are checked so the true min, max,
> and average cable lengths are reported.
> 
> Signed-off-by: Joe Schultz <jschultz@xes-inc.com>
> Signed-off-by: Aaron Sierra <asierra@xes-inc.com>
> ---
>  drivers/net/ethernet/intel/igb/e1000_defines.h |  5 ++-
>  drivers/net/ethernet/intel/igb/e1000_hw.h      |  1 +
>  drivers/net/ethernet/intel/igb/e1000_phy.c     | 54 ++++++++++++++++++++++----
>  3 files changed, 51 insertions(+), 9 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
