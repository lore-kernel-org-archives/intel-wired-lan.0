From: Kalle Valo <kvalo@codeaurora.org>
Date: Wed, 12 Feb 2020 07:49:43 +0200
Subject: [Intel-wired-lan] [PATCH 20/28] drivers: net: Call
 cpu_latency_qos_*() instead of pm_qos_*()
In-Reply-To: <10624145.o336LLEsho@kreacher> (Rafael J. Wysocki's message of
 "Wed, 12 Feb 2020 00:24:36 +0100")
References: <1654227.8mz0SueHsU@kreacher> <10624145.o336LLEsho@kreacher>
Message-ID: <87v9ocwe14.fsf@kamboji.qca.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

"Rafael J. Wysocki" <rjw@rjwysocki.net> writes:

> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>
> Call cpu_latency_qos_add/update/remove_request() instead of
> pm_qos_add/update/remove_request(), respectively, because the
> latter are going to be dropped.
>
> No intentional functional impact.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/net/ethernet/intel/e1000e/netdev.c   | 13 ++++++-------
>  drivers/net/wireless/ath/ath10k/core.c       |  4 ++--
>  drivers/net/wireless/intel/ipw2x00/ipw2100.c | 10 +++++-----
>  3 files changed, 13 insertions(+), 14 deletions(-)

For the wireless stuff:

Acked-by: Kalle Valo <kvalo@codeaurora.org>

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
