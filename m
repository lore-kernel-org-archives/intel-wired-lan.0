From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Tue, 10 Nov 2015 18:04:52 +0000
Subject: [Intel-wired-lan] [next PATCH S21 10/14] i40e: remove
 CONFIG_I40E_VXLAN
In-Reply-To: <1446852372-25480-11-git-send-email-joshua.a.hay@intel.com>
References: <1446852372-25480-1-git-send-email-joshua.a.hay@intel.com>
 <1446852372-25480-11-git-send-email-joshua.a.hay@intel.com>
Message-ID: <1447178692.6967.7.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,

On Fri, 2015-11-06 at 15:26 -0800, Joshua Hay wrote:
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> Instead of having our own custom symbol, we can just rely
> on whether or not the kernel has the feature enabled.
> 
> In this case use IS_ENABLED(CONFIG_VXLAN) in order to handle
> built-in or module in the current BKM way.

The reason a separate symbol exists is for the case where CONFIG_I40E=y
(built in) and CONFIG_VXLAN=m (module). This causes issues if you don't
use the separate symbol because the VXLAN code won't load at kernel
load time, but the i40e module will try to find the symbol and fail.

You could either keep it and drop the menu config (default the value to
y) so that I40E_VXLAN is enabled as long as CONFIG_VXLAN is enabled, or
you could force VXLAN enabled for i40e permanently when i40e is
enabled.

Using CONFIG_VXLAN directly in code will only work if you never want to
support built-in compile of i40e, in which case you should force that
in Kconfig.

Regards,
Jake
