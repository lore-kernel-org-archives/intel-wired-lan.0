From: Edward Cree <ecree@solarflare.com>
Date: Fri, 11 Sep 2020 18:16:58 +0100
Subject: [Intel-wired-lan] [RFC PATCH net-next v1 06/11]
 drivers/net/ethernet: clean up unused assignments
In-Reply-To: <20200911012337.14015-7-jesse.brandeburg@intel.com>
References: <20200911012337.14015-1-jesse.brandeburg@intel.com>
 <20200911012337.14015-7-jesse.brandeburg@intel.com>
Message-ID: <5bcd5f6f-d0c1-b9c4-d5f6-4de845ee1ec7@solarflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 11/09/2020 02:23, Jesse Brandeburg wrote:
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
> Only compile tested with W=1 and an allyesconfig with all the
> network drivers turned into modules (to try to test all options).
>
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
For the sfc/falcon part:
Acked-by: Edward Cree <ecree@solarflare.com>
(it's not the same as the solution I went with for thevery
?similar code in the Siena driver (../farch.c), but it looks
?reasonable enough).
