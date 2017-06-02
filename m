From: David Miller <davem@davemloft.net>
Date: Fri, 02 Jun 2017 14:14:26 -0400 (EDT)
Subject: [Intel-wired-lan] [PATCH v2 1/1] e1000e: Undo e1000e_pm_freeze
 if __e1000_shutdown fails
In-Reply-To: <20170531155043.3596-2-jani.nikula@intel.com>
References: <20170531.110833.1362264472730468352.davem@davemloft.net>
 <20170531155043.3596-1-jani.nikula@intel.com>
 <20170531155043.3596-2-jani.nikula@intel.com>
Message-ID: <20170602.141426.713378366601051907.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jani Nikula <jani.nikula@intel.com>
Date: Wed, 31 May 2017 18:50:43 +0300

> From: Chris Wilson <chris@chris-wilson.co.uk>
> 
> An error during suspend (e100e_pm_suspend),
 ...
> lead to complete failure:
 ...
> The unwind failures stems from commit 2800209994f8 ("e1000e: Refactor PM
> flows"), but it may be a later patch that introduced the non-recoverable
> behaviour.
> 
> Fixes: 2800209994f8 ("e1000e: Refactor PM flows")
> Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=99847
> Cc: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
> Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> Cc: Dave Ertman <davidx.m.ertman@intel.com>
> Cc: Bruce Allan <bruce.w.allan@intel.com>
> Cc: intel-wired-lan at lists.osuosl.org
> Cc: netdev at vger.kernel.org
> Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
> [Jani: bikeshed repainted]
> Signed-off-by: Jani Nikula <jani.nikula@intel.com>

Jeff, please make sure this gets submitted to me soon.

Thanks.
