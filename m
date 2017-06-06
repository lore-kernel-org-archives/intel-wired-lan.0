From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Tue, 06 Jun 2017 13:46:26 -0700
Subject: [Intel-wired-lan] [PATCH v2 1/1] e1000e: Undo e1000e_pm_freeze
 if __e1000_shutdown fails
In-Reply-To: <20170602.141426.713378366601051907.davem@davemloft.net>
References: <20170531.110833.1362264472730468352.davem@davemloft.net>
 <20170531155043.3596-1-jani.nikula@intel.com>
 <20170531155043.3596-2-jani.nikula@intel.com>
 <20170602.141426.713378366601051907.davem@davemloft.net>
Message-ID: <1496781986.86439.3.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 2017-06-02 at 14:14 -0400, David Miller wrote:
> From: Jani Nikula <jani.nikula@intel.com>
> Date: Wed, 31 May 2017 18:50:43 +0300
> 
> > From: Chris Wilson <chris@chris-wilson.co.uk>
> > 
> > An error during suspend (e100e_pm_suspend),
> 
>  ...
> > lead to complete failure:
> 
>  ...
> > The unwind failures stems from commit 2800209994f8 ("e1000e:
> > Refactor PM
> > flows"), but it may be a later patch that introduced the non-
> > recoverable
> > behaviour.
> > 
> > Fixes: 2800209994f8 ("e1000e: Refactor PM flows")
> > Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=99847
> > Cc: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
> > Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> > Cc: Dave Ertman <davidx.m.ertman@intel.com>
> > Cc: Bruce Allan <bruce.w.allan@intel.com>
> > Cc: intel-wired-lan at lists.osuosl.org
> > Cc: netdev at vger.kernel.org
> > Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
> > [Jani: bikeshed repainted]
> > Signed-off-by: Jani Nikula <jani.nikula@intel.com>
> 
> Jeff, please make sure this gets submitted to me soon.

Expect it later tonight, just finishing up testing.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20170606/787612d9/attachment.asc>
