From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Tue, 12 May 2015 01:35:04 +0000
Subject: [Intel-wired-lan] [PATCH 1/8] clarify implementation of
 ethtool's	get_ts_info op
In-Reply-To: <1429738837-25158-1-git-send-email-jacob.e.keller@intel.com>
References: <1429738837-25158-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B78DC257C@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Jacob Keller
> Sent: Wednesday, April 22, 2015 2:41 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 1/8] clarify implementation of ethtool's
> get_ts_info op
> 
> This patch adds some clarification about the intended way to implement
> both SIOCSHWTSTAMP and ethtool's get_ts_info. The HWTSTAMP API has
> several Rx filters which are very specific, as well as more general
> filters. The specific filters really only exist to support some broken
> hardware which can't fully implement the generic filters. This patch
> adds clarification that it is okay to support the specific filters in
> SIOCSHWTSTAMP by upscaling them to the generic filters. In addition,
> update the header for ethtool_ts_info to specify that drivers ought to
> only report the filters they support without upscaling in this manner.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  Documentation/networking/timestamping.txt | 7 +++++++
>  include/uapi/linux/ethtool.h              | 5 +++++
>  2 files changed, 12 insertions(+)
> 

Reviewed-by: Aaron Brown <aaron.f.brown@intel.com>
