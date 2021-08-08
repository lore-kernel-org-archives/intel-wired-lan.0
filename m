From: Fuxbrumer, Dvora <dvorax.fuxbrumer@linux.intel.com>
Date: Sun, 8 Aug 2021 11:35:06 +0300
Subject: [Intel-wired-lan] [PATCH v1 1/1] e1000e: Fix the max
 snoop/no-snoop latency for 10M
In-Reply-To: <20210704071141.1173032-1-sasha.neftin@intel.com>
References: <20210704071141.1173032-1-sasha.neftin@intel.com>
Message-ID: <9bc33892-3179-3787-4f2d-99aeec6fbdca@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 7/4/2021 10:11, Sasha Neftin wrote:
> We should decode the latency and the max_latency before directly compare.
> The latency should be presented as lat_enc = scale x value:
> lat_enc_d = (lat_enc & 0x0x3ff) x (1U << (5*((max_ltr_enc & 0x1c00)
>>> 10)))
> 
> Suggested-by: Yee Li <seven.yi.lee@gmail.com>
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
>   drivers/net/ethernet/intel/e1000e/ich8lan.c | 14 +++++++++++++-
>   drivers/net/ethernet/intel/e1000e/ich8lan.h |  3 +++
>   2 files changed, 16 insertions(+), 1 deletion(-)
> 
Tested-by: Dvora Fuxbrumer <dvorax.fuxbrumer@linux.intel.com>
