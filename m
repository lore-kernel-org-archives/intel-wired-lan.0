From: naamax.meir <naamax.meir@linux.intel.com>
Date: Wed, 6 Apr 2022 08:05:45 +0300
Subject: [Intel-wired-lan] [PATCH v2 1/1] e1000e: Fix possible overflow
 in LTR decoding
In-Reply-To: <20220405155601.1443799-1-sasha.neftin@intel.com>
References: <20220405155601.1443799-1-sasha.neftin@intel.com>
Message-ID: <c5a1da34-0c31-32ea-17c5-9c51159ffbee@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 4/5/2022 18:56, Sasha Neftin wrote:
> When we decode the latency and the max_latency u16 value does not fill
> the required size and could lead to the wrong LTR representation.
> Replace the u16 type with the u32 type and allow corrected LTR
> representation.
> 
> Fixes: 44a13a5d99c7 ("e1000e: Fix the max snoop/no-snoop latency for 10M")
> Reported-by: James Hutchinson <jahutchinson99@googlemail.com>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=215689
> Suggested-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
> ---
> v2: added link tag
> 
>   drivers/net/ethernet/intel/e1000e/ich8lan.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
Tested-by: Naama Meir <naamax.meir@linux.intel.com>
