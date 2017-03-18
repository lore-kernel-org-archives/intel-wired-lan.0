From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Sat, 18 Mar 2017 06:07:24 +0000
Subject: [Intel-wired-lan] [PATCH] ethtool: support queue and vf fields
 for	rxclass filters
In-Reply-To: <20170128003914.30854-1-jacob.e.keller@intel.com>
References: <20170128003914.30854-1-jacob.e.keller@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B8C5C03B4@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Jacob Keller
> Sent: Friday, January 27, 2017 4:39 PM
> To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
> Subject: [Intel-wired-lan] [PATCH] ethtool: support queue and vf fields for
> rxclass filters
> 
> Recent kernels have made it possible to specify filters applying to
> a virtual function by partitioning the ring_cookie (action) value. The
> lower 32bits will represent the queue, while the next 8bits represent
> the virtual function.
> 
> Add support to view and specify the ring_cookie in this way so that
> users do not have to manually create action values, and don't need to
> understand the underlying layout of the ring_cookie value.
> 
> Support using queue and vf fields which will fill in their specific bits
> of the ring_cookie value, using new customized OPT_RING_VF and
> OPT_RING_QUEUE.
> 
> Add support to display the ring cookie value as a split VF identifier
> and queue.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  ethtool.8.in |   7 ++++
>  rxclass.c    | 102 +++++++++++++++++++++++++++++++++++++++++++++++++-
> ---------
>  2 files changed, 92 insertions(+), 17 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
