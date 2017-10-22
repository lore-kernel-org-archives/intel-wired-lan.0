From: Anders K. Pedersen | Cohaesio <akp@cohaesio.com>
Date: Sun, 22 Oct 2017 18:01:47 +0000
Subject: [Intel-wired-lan] [jkirsher/net-queue PATCH] i40e: Add
 programming descriptors to cleaned_count
In-Reply-To: <20171022011222.12997.53593.stgit@localhost.localdomain>
References: <20171022011222.12997.53593.stgit@localhost.localdomain>
Message-ID: <1508695307.4970.32.camel@cohaesio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On l?r, 2017-10-21 at 18:12 -0700, Alexander Duyck wrote:
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> This patch updates the i40e driver to include programming descriptors
> in
> the cleaned_count. Without this change it becomes possible for us to
> leak
> memory as we don't trigger a large enough allocation when the time
> comes to
> allocate new buffers and we end up overwriting a number of rx_buffers
> equal
> to the number of programming descriptors we encountered.
> 
> Fixes: 0e626ff7ccbf ("i40e: Fix support for flow director programming
> status")
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>

This patch solves the remaining memory leak we've seen, so

Tested-by: Anders K. Pedersen <akp@cohaesio.com>

Regards,
Anders
