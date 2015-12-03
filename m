From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 3 Dec 2015 03:40:18 +0000
Subject: [Intel-wired-lan] [PATCH 4/5] igb: Explicitly label
	self-test	result indices
In-Reply-To: <2113406542.305783.1446575849467.JavaMail.zimbra@xes-inc.com>
References: <1888067736.304762.1446575427308.JavaMail.zimbra@xes-inc.com>,
 <2113406542.305783.1446575849467.JavaMail.zimbra@xes-inc.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81E25F9F@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [intel-wired-lan-bounces at lists.osuosl.org] on behalf of Aaron Sierra [asierra at xes-inc.com]
> Sent: Tuesday, November 03, 2015 10:37 AM
> To: Kirsher, Jeffrey T; intel-wired-lan at lists.osuosl.org
> Cc: Joe Schultz
> Subject: [Intel-wired-lan] [PATCH 4/5] igb: Explicitly label self-test  result indices
> 
> From: Joe Schultz <jschultz@xes-inc.com>
> 
> Previously, the ethtool self-test gstrings/data arrays were accessed via
> hardcoded indices, which made the code difficult to follow. This patch
> replaces the hardcoded values with enum-based labels.

> Signed-off-by: Joe Schultz <jschultz@xes-inc.com>
> Signed-off-by: Aaron Sierra <asierra@xes-inc.com>
> ---
>  drivers/net/ethernet/intel/igb/igb_ethtool.c | 38 ++++++++++++++++++----------
>  1 file changed, 24 insertions(+), 14 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
