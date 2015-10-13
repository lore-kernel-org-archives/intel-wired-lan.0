From: David Miller <davem@davemloft.net>
Date: Mon, 12 Oct 2015 19:31:52 -0700 (PDT)
Subject: [Intel-wired-lan] [PATCH v4 4/4] Adds hardware supported cross
	timestamp
In-Reply-To: <1444675522-4198-5-git-send-email-christopher.s.hall@intel.com>
References: <1444675522-4198-1-git-send-email-christopher.s.hall@intel.com>
 <1444675522-4198-5-git-send-email-christopher.s.hall@intel.com>
Message-ID: <20151012.193152.903134353277818155.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: "Christopher S. Hall" <christopher.s.hall@intel.com>
Date: Mon, 12 Oct 2015 11:45:22 -0700

> @@ -25,6 +25,8 @@
>   */
>  
>  #include "e1000.h"
> +#include <asm/tsc.h>

You cannot include an architecture specific header file in a driver
that's compiled on several architectures.
