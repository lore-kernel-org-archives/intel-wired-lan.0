From: Edward Cree <ecree@solarflare.com>
Date: Tue, 15 Sep 2020 10:02:49 +0100
Subject: [Intel-wired-lan] [PATCH net-next v2 04/10]
 drivers/net/ethernet: clean up unused assignments
In-Reply-To: <20200915014455.1232507-5-jesse.brandeburg@intel.com>
References: <20200915014455.1232507-1-jesse.brandeburg@intel.com>
 <20200915014455.1232507-5-jesse.brandeburg@intel.com>
Message-ID: <d647a101-412b-8f17-2460-5171e0a3a218@solarflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 15/09/2020 02:44, Jesse Brandeburg wrote:
> As part of the W=1 compliation series, these lines all created
> warnings about unused variables that were assigned a value. Most
> of them are from register reads, but some are just picking up
> a return value from a function and never doing anything with it.
>
> The register reads should be OK, because the current
> implementation of readl and friends will always execute even
> without an lvalue.
>
> When it makes sense, just remove the lvalue assignment and the
> local. Other times, just remove the offending code, and
> occasionally, just mark the variable as maybe unused since it
> could be used in an ifdef or debug scenario.
>
> Only compile tested with W=1.
>
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
For sfc/falcon:
Acked-by: Edward Cree <ecree@solarflare.com>
