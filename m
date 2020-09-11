From: Jakub Kicinski <kuba@kernel.org>
Date: Fri, 11 Sep 2020 07:55:15 -0700
Subject: [Intel-wired-lan] [RFC PATCH net-next v1 00/11] make
 drivers/net/ethernet W=1 clean
In-Reply-To: <20200911012337.14015-1-jesse.brandeburg@intel.com>
References: <20200911012337.14015-1-jesse.brandeburg@intel.com>
Message-ID: <20200911075515.6d81066b@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 10 Sep 2020 18:23:26 -0700 Jesse Brandeburg wrote:
> This series is a placeholder to show I've about finished this work.
> 
> After applying the patches below, the drivers/net/ethernet
> directory can be built as modules with W=1 with no warnings.
> 
> This series removes 1,283 warnings and hopefully allows the ethernet
> directory to move forward from here without more warnings being added.
> 
> Some of these patches are already sent to Intel Wired Lan, but the rest
> of the series titled drivers/net/ethernet affects other drivers, not
> just Intel, but they depend on the first five.

Great stuff. Much easier to apply one large series than a thousand
small patches. I haven't read all the comment changes but FWIW:

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

I feel slightly bad for saying this but I think your config did not
include all the drivers, 'cause I'm still getting some warnings after
patch 11. Regardless this is impressive effort, thanks!
