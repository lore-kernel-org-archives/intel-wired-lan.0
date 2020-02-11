From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Tue, 11 Feb 2020 15:48:09 -0800
Subject: [Intel-wired-lan] [PATCH 20/28] drivers: net: Call
 cpu_latency_qos_*() instead of pm_qos_*()
In-Reply-To: <10624145.o336LLEsho@kreacher>
References: <1654227.8mz0SueHsU@kreacher> <10624145.o336LLEsho@kreacher>
Message-ID: <43c9336e1c0c23e374420586868052e947b75126.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2020-02-12 at 00:24 +0100, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> Call cpu_latency_qos_add/update/remove_request() instead of
> pm_qos_add/update/remove_request(), respectively, because the
> latter are going to be dropped.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Acked-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com

For the e1000e changes

> ---
>  drivers/net/ethernet/intel/e1000e/netdev.c   | 13 ++++++-------
>  drivers/net/wireless/ath/ath10k/core.c       |  4 ++--
>  drivers/net/wireless/intel/ipw2x00/ipw2100.c | 10 +++++-----
>  3 files changed, 13 insertions(+), 14 deletions(-)

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20200211/18987c3d/attachment.asc>
