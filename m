From: Daniel Vetter <daniel.vetter@ffwll.ch>
Date: Wed, 28 Jun 2017 07:35:03 +0200
Subject: [Intel-wired-lan] [PATCH v2 1/1] e1000e: Undo e1000e_pm_freeze
 if __e1000_shutdown fails
In-Reply-To: <1498596665.3244.2.camel@intel.com>
References: <20170531.110833.1362264472730468352.davem@davemloft.net>
 <20170531155043.3596-1-jani.nikula@intel.com>
 <20170531155043.3596-2-jani.nikula@intel.com>
 <20170602.141426.713378366601051907.davem@davemloft.net>
 <1496781986.86439.3.camel@intel.com>
 <309B89C4C689E141A5FF6A0C5FB2118B8C61D137@ORSMSX101.amr.corp.intel.com>
 <20170620084958.7fxdn57p3o6eexbj@phenom.ffwll.local>
 <CAPM=9tzdpEDoMNYj7Z_ZM3Z0JsCpjfNW1Z+y-1p5z3HssJ5aaw@mail.gmail.com>
 <1498596665.3244.2.camel@intel.com>
Message-ID: <CAKMK7uHLdQ_Jd+h95d9kUxNPoy5Z3nP9r85GPraYcc52_Fk8bw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Jun 27, 2017 at 10:51 PM, Jeff Kirsher
<jeffrey.t.kirsher@intel.com> wrote:
> This was submitted and accepted into David Miller's net-next tree.  I can
> see if Dave can pull it into his net tree.  DOes stable need to pick this
> up as well?

Nah if it landed somewhere at least I'm happy, we can carry the fixup
for a while longer locally.

Thanks, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
